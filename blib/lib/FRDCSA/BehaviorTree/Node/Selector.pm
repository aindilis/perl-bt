package FRDCSA::BehaviorTree::Node::Selector;

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
    } elsif ($childstatus->{Status} eq 'success') {
      return {
	      Status => 'success',
	     };
    }
  }
  return {
	  Status => 'failure',
	 };
}

1;
