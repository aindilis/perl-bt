package FRDCSA::BehaviorTree::Sequence;

use base 'FRDCSA::BehaviorTree::Composite';

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / m_CurrentChild /

  ];

=head1 NAME

FRDCSA::BehaviorTree::Sequence - 

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

sub DESTROY {
  my ($self,%args) = @_;
  $self->SUPER::DESTROY(%args);
}

=item onInitialize()

=cut

sub onInitialize {
  my ($self,%args) = @_;
  $self->SUPER::onInitialize(%args);
  $self->m_CurrentChild(0);
}


=item update()

=cut

sub update {
  my ($self,%args) = @_;
  $self->SUPER::update(%args);
  while (1) {
    my $status = $self->m_CurrentChild->tick();
    if ($status->{Status} ne 'BH_SUCCESS') {
      return $status;
    }
    $self->m_CurrentChild($self->m_CurrentChild + 1);
    if ($self->m_CurrentChild eq $self->size) {
      return
	{
	 Status => 'BH_SUCCESS',
	};
    }
  }
  return
    {
     Status => 'BH_INVALID',
    };
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
  $self->SUPER::addChild(%args);
  # $args{Child};
}

=item removeChild()

=cut

sub removeChild {
  my ($self,%args) = @_;
  $self->SUPER::removeChild(%args);
  # $args{Child};
}

=item clearChildren()

=cut

sub clearChildren {
  my ($self,%args) = @_;
  $self->SUPER::clearChildren(%args);
}

1;
