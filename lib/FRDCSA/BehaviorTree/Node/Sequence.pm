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
  $self->SUPER::init(%args);
}

sub Tick {
  my ($self,%args) = @_;
  $self->SUPER::Tick(%args);
  foreach my $child (@{$self->Children}) {
    my $childstatus = $child->Tick();
    if ($childstatus->{Status} eq 'running') {
      return {
	      Status => 'running',
	     };
    } elsif ($childstatus->{Status} eq 'failure') {
      return {
	      Status => 'failure',
	     };
    }
  }
  return {
	  Status => 'success',
	 };
}

1;
