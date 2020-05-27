package FRDCSA::BehaviorTree::Node::LeafTask;

use base 'FRDCSA::BehaviorTree::Node';

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
  $self->Children(undef);
}

sub Method {
  my ($self,%args) = @_;

}

1;
