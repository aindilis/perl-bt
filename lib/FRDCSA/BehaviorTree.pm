package FRDCSA::BehaviorTree;

use Data::Dumper;
use Mojo::IOLoop;

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / Name SourceFileName Root /

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
}

sub LoadFromSource {
  my ($self,%args) = @_;
}

sub Start {
  my ($self,%args) = @_;
  print "Starting root node\n";
  $self->Root->Start();
}

sub Stop {
  my ($self,%args) = @_;
  print "Stopping root node\n";
  $self->Root->Stop(Status => $args{Status});
}

1;
