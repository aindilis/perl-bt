package FRDCSA::BehaviorTree::Node::Sequence;

use base 'FRDCSA::BehaviorTree::Node';

use Data::Dumper;

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / Children /

  ];

sub init {
  my ($self,%args) = @_;
  $self->Children($args{Children} || []);
}

1;
