package FRDCSA::BehaviorTreePlanMonitor::Blackboard::KeyUpdate;

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / KeyName Pre Post /

  ];

sub init {
  my ($self,%args) = @_;
  $self->KeyName($args{KeyName});
  $self->Pre($args{Value});
  $self->Post($args{Post});
}

1;
