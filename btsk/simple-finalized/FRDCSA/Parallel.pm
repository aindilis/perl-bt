package FRDCSA::BehaviorTree::Parallel;

use base 'FRDCSA::BehaviorTree::Composite';

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / m_eSuccessPolicy m_eFailurePolicy iSuccessCount iFailureCount
   /

  ];

=head1 NAME

FRDCSA::BehaviorTree::Parallel -

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
  $self->m_eSuccessPolicy($args{SuccessPolicy});
  $self->m_eFailurePolicy($args{FailurePolicy});
  $self->SUPER::init(%args);
}

=item update()

=cut

sub update {
  my ($self,%args) = @_;
  $self->iSuccessCount(0);
  $self->iFailureCount(0);

  foreach my $it (@{$self->m_Children}) {
    my $b = $it;
    if (! $b->isTerminated()) {
      $b->tick();
    }
    if ($b->Status eq 'BH_SUCCESS') {
      $self->iSuccessCount($self->iSuccessCount + 1);
      if ($self->m_eSuccessPolicy eq 'RequireOne') {
	return
	  {
	   Status => 'BH_SUCCESS',
	  };
      }
    }
    if ($b->Status eq 'BH_FAILURE') {
      $self->iFailureCount($self->iFailureCount + 1);
      if ($self->m_eFailurePolicy eq 'RequireOne') {
	return
	  {
	   Status => 'BH_FAILURE',
	  };
      }
    }
  }
  if ($self->m_eFailurePolicy eq 'RequireAll' and $self->iFailureCount == $self->size) {
    return
      {
       Status => 'BH_FAILURE',
      };
  }
  if ($self->m_eSuccessPolicy eq 'RequireAll' and $self->iSuccessCount == $self->size) {
    return
      {
       Status => 'BH_SUCCESS',
      };
  }

  return
    {
     Status => 'BH_RUNNING',
    };
}

=item onTerminate($status)

=cut

sub onTerminate {
  my ($self,%args) = @_;
  foreach my $it (@{$self->m_Children}) {
    my $b = $it;
    if ($b->isRunning()) {
      $b->abort();
    }
  }
}

1;
