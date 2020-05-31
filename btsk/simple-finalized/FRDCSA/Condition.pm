package FRDCSA::BehaviorTree::Condition;

use base 'FRDCSA::BehaviorTree::Behavior';

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / /

  ];

=head1 NAME

FRDCSA::BehaviorTree::Condition - Leaf nodes which evaluate
information.

=head1 DESCRIPTION

Part of a pure-Perl behavior tree implementation.  Implemention based
on 'The Behavior Tree Starter Kit' (Chapter 6) by Alex J. Champandard
and Philip Dunstan, and the BTSK GitHub code.  Documentation
paraphrased.

=head1 SYNOPSIS

A class which inherits from FRDCSA::BehaviorTree::Behavior, and allows
one to check various conditions in the environment, such as whether a
delivery has just arrived, whether there is adequate inventory of a
certain item, etc.  Conditions are either true or false.  These are
used either as point checks (checking if something is true at the
current time point), or 'while' checks, running as long as it is true
then exiting with failure.  They accept an argument indicating
negation - to do the opposite behavior.  In point check mode this
negates the boolean values, and it changes 'while' to 'until'.

=head1 AUTHOR

Andrew John Dougherty

=head1 LICENSE

GPLv3

=cut

=item init()

=cut

sub init {
  my ($self,%args) = @_;
  # $self->SUPER::init(%args);
}

sub DESTROY {
  my ($self,%args) = @_;
  # $self->SUPER::DESTROY(%args);
}

=item onInitialize()

=cut

sub onInitialize {
  my ($self,%args) = @_;
  return $self->SUPER::onInitialize(%args);
}


=item update()

=cut

sub update {
  my ($self,%args) = @_;
  return $self->SUPER::update(%args);
}

=item onTerminate($status)

=cut

sub onTerminate {
  my ($self,%args) = @_;
  $self->SUPER::onTerminate(%args);
}

=item tick()

=cut

sub tick {
  my ($self,%args) = @_;
  $self->SUPER::tick(%args);
}

1;
