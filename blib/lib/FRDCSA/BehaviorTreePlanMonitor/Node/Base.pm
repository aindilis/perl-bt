package FRDCSA::BehaviorTreePlanMonitor::Node::Base;

use base 'FRDCSA::BehaviorTreeStarterKit::Behavior';

use Data::Dumper;

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / Name Description Tree Parent Watchers /

  ];

sub init {
  my ($self,%args) = @_;
  my $ref = ref($self);
  $ref =~ s/.*:://;
  $self->Name($args{Name} || $ref.'-'.rand());
  $self->Description($args{Description} || '');
  $self->Tree($args{Tree});
  $self->Parent($args{Parent});
  $self->Status($args{Status});
  $self->Watchers($args{Watchers});
}

sub Status {
  my ($self, $status) = @_;
  if (! defined $status) {
    return $self->m_eStatus;
  } else {
    $self->m_eStatus($status);
  }
}

sub Tick {
  my ($self, %args) = @_;
  # this is started, so now if it's a regular task, we have to send a message to the GUI saying we've started
  # $self->Log(Message => 'Ticked: '.$self->Name);
  $self->tick();
}

sub SendToMojo {
  my ($self,%args) = @_;
  $self->Tree->SendToMojo(%args);
}

sub Log {
  my ($self,%args) = @_;
  $self->Tree->Log(%args);
}

1;



