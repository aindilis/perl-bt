package FRDCSA::BehaviorTree::ActiveSelector;

use base 'FRDCSA::BehaviorTree::Selector';

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw /  /

  ];

=head1 NAME

FRDCSA::BehaviorTree::ActiveSelector -

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
  $self->m_CurrentChild($self->size - 1);
}


=item update()

=cut

sub update {
  my ($self,%args) = @_;
  my $prev = $self->m_CurrentChild;

  FRDCSA::BehaviorTree::Selector::onInitialize($self);
  my $result = FRDCSA::BehaviorTree::Selector::update($self);

  if (($prev != ($self->size - 1)) and ($self->m_CurrentChild != $prev)) {
    # $prev->abort();
    $self->m_Children->[$prev]->onTerminate('BH_ABORTED');
  }

  return $result;
}

1;
