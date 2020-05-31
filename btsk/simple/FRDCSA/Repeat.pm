package FRDCSA::BehaviorTree::Repeat;

use base 'FRDCSA::BehaviorTree::Decorator';

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / m_iCounter m_iLimit /

  ];

=head1 NAME

FRDCSA::BehaviorTree::Repeat - Run child behavior until meeting a
threshold.

=head1 DESCRIPTION

Part of a pure-Perl behavior tree implementation.  Implemention based
on 'The Behavior Tree Starter Kit' (Chapter 6) by Alex J. Champandard
and Philip Dunstan, and the BTSK GitHub code.  Documentation
paraphrased.

=head1 SYNOPSIS

Repeat for a certain number of times, or just go on forever.

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
  $self->m_iCounter($args{Counter});
  $self->m_iLimit($args{Limit});
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
  # ??? return $self->SUPER::update(%args);
  $self->SUPER::update(%args);
  while (1) {
    $self->m_pChild->tick();
    if ($self->m_pChild->Status eq 'BH_RUNNING') {
      break;
    }
    if ($self->m_pChild->Status eq 'BH_FAILURE') {
      return
	{
	 Status => 'BH_FAILURE',
	};
    }
    if ($self->m_iCounter == $self->m_iLimit) {
      return
	{
	 Status => 'BH_SUCCESS',
	};
    }
  }
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
