package FRDCSA::BehaviorTree::Node::LeafTask;

use base 'FRDCSA::BehaviorTree::Node::Base';

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

sub Tick {
  my ($self,%args) = @_;
  $self->SUPER::Tick(%args);
}

1;
