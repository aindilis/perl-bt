package FRDCSA::BehaviorTreePlanMonitor::Blackboard::StateUpdate;

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / KeyUpdates /

  ];

sub init {
  my ($self,%args) = @_;
  if ($args{Update}) {
    # process the state update
    if ($args{Update}{action}) {
      
    }
  }
  $self->KeyUpdates($args{KeyName});
}

1;
