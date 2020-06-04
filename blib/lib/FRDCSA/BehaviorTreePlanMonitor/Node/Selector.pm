package FRDCSA::BehaviorTreePlanMonitor::Node::Selector;

use base 'FRDCSA::BehaviorTreePlanMonitor::Node::Composite';
use base 'FRDCSA::BehaviorTreeStarterKit::Selector';

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
  $self->FRDCSA::BehaviorTreePlanMonitor::Node::Composite::init(%args);
  $self->FRDCSA::BehaviorTreeStarterKit::Selector::init(%args);
}

sub Tick {
  my ($self,%args) = @_;
  print "Selector Tick\n";
  $self->FRDCSA::BehaviorTreePlanMonitor::Node::Composite::Tick();
}

sub tick {
  my ($self,%args) = @_;
  print "Selector tick\n";
  $self->FRDCSA::BehaviorTreeStarterKit::Selector::tick();
}

sub update {
  my ($self,%args) = @_;
  $self->FRDCSA::BehaviorTreeStarterKit::Selector::update();
}

1;

