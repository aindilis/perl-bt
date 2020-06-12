package FRDCSA::BehaviorTreePlanMonitor::Parser;

use FRDCSA::BehaviorTreePlanMonitor::PMParser;

use Data::Dumper;
use File::Slurp;

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / /

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
      my $bt = FRDCSA::BehaviorTreePlanMonitor->new
	(
	 Blackboard => FRDCSA::BehaviorTreePlanMonitor::Blackboard->new(),
	 Root => $res1->{RootNode},
	);
      return {
	      Success => 1,
	      BehaviorTree => $bt
	     };
    }
  }
  return {
	  Success => 0,
	 };
}

sub ParseAllContents {
  my ($self,%args) = @_;
  my $pmparser = FRDCSA::BehaviorTreePlanMonitor::PMParser->new;
  print '<<<'.$args{AllContents}.">>>\n";
  return $pmparser->from_string( $args{AllContents} );
}

1;
