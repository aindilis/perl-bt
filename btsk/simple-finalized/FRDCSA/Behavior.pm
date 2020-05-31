package FRDCSA::BehaviorTree::Behavior;

use Data::Dumper;

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / Status m_eStatus /

  ];

=head1 NAME

FRDCSA::BehaviorTree::Behavior - Base class of all behaviors in tree.

=head1 DESCRIPTION

Part of a pure-Perl behavior tree implementation.  Implemention based
on 'The Behavior Tree Starter Kit' (Chapter 6) by Alex J. Champandard
and Philip Dunstan, and the BTSK GitHub code.  Documentation
paraphrased.

=head1 SYNOPSIS

An abstract interface that is started, ran and stopped.  Leaf nodes,
such as actions (i.e. "move to door", "open door", "close door"),
conditions (i.e. "is the temperature too high?", "has too much time
passed?") inherit from this base class.  Tree branches are
higher-order behaviors, adding together tinier beahviors to give more
complex behavior.

All behaviors must return a status.  Status have two functions:
completion status - indicates success or failure of completed
behaviors, and execution status - on every update while the behavior
is running.  Usually set to 'RUNNING', but 2nd gen BTs can improve
performance by making better use of execution statuses.

=head1 AUTHOR

Andrew John Dougherty

=head1 LICENSE

GPLv3

=cut

=item init

=cut

sub init {
  my ($self,%args) = @_;
  $self->m_eStatus('BH_INVALID');
}

sub DESTROY {
  my ($self,%args) = @_;
}

=item onInitialize()

Called once, right before the first call to update the method of the
behavior.

=cut

sub onInitialize {
  my ($self,%args) = @_;
}


=item update()

Called just once every time the BT is updated, until it returns a
status of terminated.

=cut

sub update {
  my ($self,%args) = @_;
  return {Status => $self->Status};
}

=item onTerminate($status)

Called just once, right after the earlier update signals it's stopped.

=cut

sub onTerminate {
  my ($self,%args) = @_;
  $self->Status($args{Status});
}

=item tick()

BT tick method.

=cut

sub tick {
  my ($self,%args) = @_;
  if ($self->m_eStatus ne 'BH_RUNNING') {
    $self->onInitialize();
  }

  $self->m_eStatus($self->update());

  if ($self->m_eStatus ne 'BH_RUNNING') {
    $self->onTerminate(Status => $self->m_eStatus);
  }

  return $self->m_eStatus;
}

=item reset()

=cut

sub reset {
  my ($self,%args) = @_;
  $self->m_eStatus('BH_INVALID');
}

=item abort()

=cut

sub abort {
  my ($self,%args) = @_;
  $self->onTerminate(Status => 'BH_ABORTED');
  $self->m_eStatus('BH_ABORTED');
}

=item isTerminated()

=cut

sub isTerminated {
  my ($self,%args) = @_;
  return
    ($self->m_eStatus eq 'BH_SUCCESS') or
    ($self->m_eStatus eq 'BH_FAILURE');
}

=item isRunning()

=cut

sub isRunning {
  my ($self,%args) = @_;
  return $self->m_eStatus eq 'BH_RUNNING';
}

1;
