package FRDCSA::BehaviorTree::Composite;

use base 'FRDCSA::BehaviorTree::Behavior';

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / m_Children /

  ];

=head1 NAME

FRDCSA::BehaviorTree::Composite - A behavior node with multiple
children behaviors.

=head1 DESCRIPTION

Part of a pure-Perl behavior tree implementation.  Implemention based
on 'The Behavior Tree Starter Kit' (Chapter 6) by Alex J. Champandard
and Philip Dunstan, and the BTSK GitHub code.  Documentation
paraphrased.

=head1 SYNOPSIS

Create better, more complex behaviors through combining lesser
behaviors together.

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

=item addChild()

=cut

sub addChild {
  my ($self,%args) = @_;
  # $args{Child};
}

=item removeChild()

=cut

sub removeChild {
  my ($self,%args) = @_;
  # $args{Child};
}

=item clearChildren()

=cut

sub clearChildren {
  my ($self,%args) = @_;
}

=item size()

=cut

sub size {
  my ($self,%args) = @_;
  return scalar @{$self->m_Children};
}

1;
