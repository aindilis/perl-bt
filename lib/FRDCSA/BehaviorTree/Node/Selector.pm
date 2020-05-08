package FRDCSA::BehaviorTree::Node::Selector;

use base 'FRDCSA::BehaviorTree::Node';

use Data::Dumper;

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / Attribute /

  ];

sub init {
  my ($self,%args) = @_;
  $self->Attribute($args{Attribute} || "");
}

sub Method {
  my ($self,%args) = @_;
}

1;
