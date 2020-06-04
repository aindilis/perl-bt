package FRDCSA::BehaviorTreePlanMonitor::Node::Root;

use base 'FRDCSA::BehaviorTreePlanMonitor::Node::Sequence';

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
  $self->FRDCSA::BehaviorTreePlanMonitor::Node::Sequence::init(%args);
  assert((scalar @{$self->Children}) == 1);
}

1;

