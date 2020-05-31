package FRDCSA::BehaviorTree::Action;

use base 'FRDCSA::BehaviorTree::Behavior';

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / /

  ];

=head1 NAME

FRDCSA::BehaviorTree::Action - Leaf nodes which interact with the
environment.

=head1 DESCRIPTION

Part of a pure-Perl behavior tree implementation.  Implemention based
on 'The Behavior Tree Starter Kit' (Chapter 6) by Alex J. Champandard
and Philip Dunstan, and the BTSK GitHub code.  Documentation
paraphrased.

=head1 SYNOPSIS

A class which inherits from FRDCSA::BehaviorTree::Behavior, and allows
one to implement action nodes which carry out interaction with the
blackboard and environment.

=head1 AUTHOR

Andrew John Dougherty

=head1 LICENSE

GPLv3

=cut

=item init()

One will need to interact with other compontents and objects to
instantiate.  One might have to access the blackboard, or execute some
side-effect.  Usually, you can pass extra params to interface with
these components.

=cut

sub init {
  my ($self,%args) = @_;
  $self->SUPER::init(%args);
}

sub DESTROY {
  my ($self,%args) = @_;
  $self->SUPER::DESTROY(%args);
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
