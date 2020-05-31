package FRDCSA::BehaviorTree::Selector;

use base 'FRDCSA::BehaviorTree::Composite';

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / m_CurrentChild /

  ];

=head1 NAME

FRDCSA::BehaviorTree::Selector -

=head1 DESCRIPTION

Part of a pure-Perl behavior tree implementation.  Implemention based
on 'The Behavior Tree Starter Kit' (Chapter 6) by Alex J. Champandard
and Philip Dunstan, and the BTSK GitHub code.  Documentation
paraphrased.

=head1 SYNOPSIS


=head1 AUTHOR

Andrew John Dougherty

=head1 LICENSE

GPLv3

=cut


=item onInitialize()

=cut

sub onInitialize {
  my ($self,%args) = @_;
  $self->m_CurrentChild(0);
}


=item update()

=cut

sub update {
  my ($self,%args) = @_;
  while (1) {

    my $status = $self->m_Children->[$self->m_CurrentChild]->tick();

    if ($status->{Status} ne 'BH_FAILURE') {
      return $status;
    }

    $self->m_CurrentChild($self->m_CurrentChild + 1);
    if ($self->m_CurrentChild eq $self->size) {
      return
	{
	 Status => 'BH_FAILURE',
	};
    }
  }
}

1;
