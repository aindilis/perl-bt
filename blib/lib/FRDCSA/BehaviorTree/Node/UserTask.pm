package FRDCSA::BehaviorTree::Node::UserTask;

use base 'FRDCSA::BehaviorTree::Node::LeafTask';

use Mojo::IOLoop;

use Data::Dumper;

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / /

  ];

sub init {
  my ($self,%args) = @_;
  $self->SUPER::init(%args);
}

sub Tick {
  my ($self,%args) = @_;
  # send a message saying we've started, wait for the user to tell us
  # to proceed

  my $result = $self->SUPER::Tick(%args);
  $self->Update(Update => 'Please start task: '.$self->Description);
  return $result;
}

1;
