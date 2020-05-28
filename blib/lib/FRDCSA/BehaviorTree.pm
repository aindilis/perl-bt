package FRDCSA::BehaviorTree;

use FRDCSA::BehaviorTree::Node::Base;

use Data::Dumper;

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / Name SourceFileName Root Nodes Queue /

  ];

sub init {
  my ($self,%args) = @_;
  print "What?\n";
  $self->Name($args{Name} || 'BehaviorTree-'.rand());
  $self->SourceFileName($args{SourceFileName});
  if (-f $self->SourceFileName) {
    $self->LoadFromSource();
  } else {
    $self->Root($args{Root});
  }
  $self->Nodes({});
  $self->Queue([$self->Root]);
  $self->IndexNodes();
}

sub LoadFromSource {
  my ($self,%args) = @_;
}

sub IndexNodes {
  my ($self,%args) = @_;
  while (my $node = shift @{$self->Queue}) {
    $self->Nodes->{$node->Name} = $node;
    $node->Tree($self);
    if (defined $node->Children) {
      foreach my $child (@{$node->Children}) {
	push @{$self->Queue}, $child;
      }
    }
  }
}

sub Log {
  my ($self,%args) = @_;
  print $args{Message}."\n";
}

sub Start {
  my ($self,%args) = @_;
  print "Starting root node\n";
  $self->Root->Start(Status => 'running');
}

sub Stop {
  my ($self,%args) = @_;
  print "Stopping root node\n";
  $self->Root->Stop(Status => $args{Status});
}

1;
