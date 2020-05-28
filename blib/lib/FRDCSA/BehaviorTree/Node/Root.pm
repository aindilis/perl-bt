package FRDCSA::BehaviorTree::Node::Root;

use base 'FRDCSA::BehaviorTree::Node::Base';

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
  $self->SUPER::init(%args);
  assert(scalar @{$self->Children} == 1);
}

sub Start {
  my ($self,%args) = @_; 
  $self->Status($args{Status});
  while ($self->Status eq 'running') {
    $self->Children->[0]->Tick;
    return;
    # $self->NonblockingSleep();
  }
}

sub Stop {
  my ($self,%args) = @_; 
  $self->Status($args{Status});
  foreach my $child (@{$self->Children}) {
    $child->Stop(Status => $self->Status);
  }
}

1;

