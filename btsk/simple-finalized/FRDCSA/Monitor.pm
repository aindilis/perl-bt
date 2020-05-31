package FRDCSA::BehaviorTree::Monitor;

use base 'FRDCSA::BehaviorTree::Parallel';

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw /  /

  ];

=head1 NAME

FRDCSA::BehaviorTree::Monitor -

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

=item init()

=cut

sub init {
  my ($self,%args) = @_;
  $self->SUPER::init(%args);
}

=item addCondition()

=cut

sub addCondition {
  my ($self,%args) = @_;
  unshift @{$self->m_Children}, $args{Condition};
  $self->m_CurrentChild($self->m_CurrentChild + 1);
}

=item addCondition()

=cut

sub addAction {
  my ($self,%args) = @_;
  push @{$self->m_Children}, $args{Action};
}

1;
