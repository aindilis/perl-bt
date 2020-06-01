package FRDCSA::BehaviorTree::Node::Root;

use base 'FRDCSA::BehaviorTree::Node::Sequence';

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
  $self->FRDCSA::BehaviorTree::Node::Sequence::init(%args);
  assert((scalar @{$self->Children}) == 1);
}

1;

