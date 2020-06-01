package FRDCSA::BehaviorTree::Node::Sequence;

use base 'FRDCSA::BehaviorTree::Node::Composite';
use base 'FRDCSA::BehaviorTreeStarterKit::Sequence';

use Carp::Assert;
use Data::Dumper;

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw /  /

  ];

sub init {
  my ($self,%args) = @_;
  $self->FRDCSA::BehaviorTree::Node::Composite::init(%args);
  $self->FRDCSA::BehaviorTreeStarterKit::Sequence::init(%args);
}

sub Tick {
  my ($self,%args) = @_;
  print "Sequence Tick\n";
  $self->FRDCSA::BehaviorTree::Node::Composite::Tick();
}

sub tick {
  my ($self,%args) = @_;
  print "Sequence tick\n";
  $self->FRDCSA::BehaviorTreeStarterKit::Sequence::tick();
}

sub update {
  my ($self,%args) = @_;
  $self->FRDCSA::BehaviorTreeStarterKit::Sequence::update();
}

1;

