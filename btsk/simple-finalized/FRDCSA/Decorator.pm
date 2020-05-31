package FRDCSA::BehaviorTree::Decorator;

use base 'FRDCSA::BehaviorTree::Behavior';

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / m_pChild /

  ];

=head1 NAME

FRDCSA::BehaviorTree::Decorator - Encapsulates other single behaviors.

=head1 DESCRIPTION

Part of a pure-Perl behavior tree implementation.  Implemention based
on 'The Behavior Tree Starter Kit' (Chapter 6) by Alex J. Champandard
and Philip Dunstan, and the BTSK GitHub code.  Documentation
paraphrased.

=head1 SYNOPSIS

Decorators are behaviors that encapsulate behaviors with different
behaviors.  They can do things like repeat for a certain number of
times, shield errors, or just go on forever.

=head1 AUTHOR

Andrew John Dougherty

=head1 LICENSE

GPLv3

=cut

=item init()

=cut

sub init {
  my ($self,%args) = @_;
  $self->m_pChild($args{Child});
  $self->SUPER::init(%args);
}

1;
