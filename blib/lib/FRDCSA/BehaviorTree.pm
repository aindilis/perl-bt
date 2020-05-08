package FRDCSA::BehaviorTree;

use Data::Dumper;

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / /

  ];

sub init {
  my ($self,%args) = @_;
}

sub Start {
  my ($self,%args) = @_;
}

sub Stop {
  my ($self,%args) = @_;
}

1;
