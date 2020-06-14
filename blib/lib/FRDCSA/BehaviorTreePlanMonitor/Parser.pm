package FRDCSA::BehaviorTreePlanMonitor::Parser;

use FRDCSA::BehaviorTreePlanMonitor::Parser::FirstPass;

use Data::Dumper;
use File::Slurp;

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / Clauses TaskNodes NonRootNodes RootNodes /

  ];

sub init {
  my ($self,%args) = @_;

}

sub Parse {
  my ($self,%args) = @_;
  my $files = $args{Files};
  my @allcontents;
  if (defined $args{Contents}) {
    push @allcontents, $args{Contents};
  }
  if (defined $args{Files}) {
    if (scalar @$files) {
      foreach my $file (@$files) {
	if (-f $file) {
	  my $contents = read_file($file);
	  push @allcontents, $contents;
	} else {
	  # throw error that a file does not exist
	}
      }
    }
  }

  my $allcontents = join("\n", @allcontents);
  if (defined $allcontents and (length($allcontents) > 0)) {
    my $res1 = $self->ParseAllContents(AllContents => $allcontents);
    if ($res1->{Success}) {
      my $behaviortrees = {};
      foreach my $key (keys %{$res1->{RootNodes}}) {
	$behaviortrees->{$key} = FRDCSA::BehaviorTreePlanMonitor->new
	  (
	   Name => $key,
	   Blackboard => FRDCSA::BehaviorTreePlanMonitor::Blackboard->new(),
	   Root => $res1->{RootNodes}->{$key},
	  );
      }
      return {
	      Success => 1,
	      BehaviorTrees => $behaviortrees,
	     };
    }
  }
  return {
	  Success => 0,
	 };
}

sub ParseAllContents {
  my ($self,%args) = @_;

  my $firstpass = FRDCSA::BehaviorTreePlanMonitor::Parser::FirstPass->new;
  print '<<<'.$args{AllContents}.">>>\n";
  my $res1 =  $firstpass->from_string( $args{AllContents} );
  if (! $res1->{Success}) {
    # throw error;
    die "Whoops!\n";
  }
  my $clauses = $res1->{Clauses};
  my $tasknodes = {};
  my $nonrootnodes = {};
  foreach my $clause (values %$clauses) {
    foreach my $conjunct (@{$clause->{Body}}) {
      if (! exists $clauses->{$conjunct}) {
	$tasknodes->{$conjunct} = 1;
      } else {
	$nonrootnodes->{$conjunct} = 1;
      }
    }
  }
  $self->Clauses($clauses);
  $self->TaskNodes($tasknodes);
  $self->NonRootNodes($nonrootnodes);
  $self->RootNodes($rootnodes);
  my $rootnodes = {};
  foreach my $clause (keys %$clauses) {
    next if $nonrootnodes->{$clause};
    $rootnodes->{$clause} = $self->BuildBehaviorSubTree(Node => $clause);
  }
  return
    {
     Success => 1,
     RootNodes => $rootnodes,
    };
}

sub BuildBehaviorSubTree {
  my ($self,%args) = @_;
  print "BuildBehaviorSubTree: $args{Node}\n";
  my @children;
  foreach my $conjunct (@{$self->Clauses->{$args{Node}}->{Body}}) {
    if (exists $self->TaskNodes->{$conjunct}) {
      push @children,
	FRDCSA::BehaviorTreePlanMonitor::Node::UserTask->new
	  (Description => $self->PresentText(Text => $conjunct));
    } else {
      push @children,
	$self->BuildBehaviorSubTree(Node => $conjunct);
    }
  }
  if (defined $self->Clauses->{$args{Node}}->{Operator}) {
    my $op = $self->Clauses->{$args{Node}}->{Operator};
    if ($op eq '->') {
      return FRDCSA::BehaviorTreePlanMonitor::Node::Sequence->new(Children => \@children);
    } elsif ($op eq '>>') {
      return FRDCSA::BehaviorTreePlanMonitor::Node::Selector->new(Children => \@children);
    }
  }
  die "Oops!\n".Dumper({Children => \@children});
}

sub PresentText {
  my ($self,%args) = @_;
  my $text = ucfirst($args{Text});
  $text =~ s/_/ /sg;
  return $text;
}

1;
