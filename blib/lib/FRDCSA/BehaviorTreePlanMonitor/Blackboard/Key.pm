package FRDCSA::BehaviorTreePlanMonitor::Blackboard::Key;

use Data::Dumper;

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / Name Value Watchers /

  ];

sub init {
  my ($self,%args) = @_;
  $self->Name($args{Name});
  $self->Value($args{Value});
  $self->Watchers({});
}

sub AddWatcher {
  my ($self,%args) = @_;
  if (! exists $self->Watchers->{$args{Watcher}->Name}) {
    $self->Watchers->{$args{Watcher}->Name} = $args{Watcher};
  } else {
    # throw a warning already exists
  }
}

sub RemoveWatcher {
  my ($self,%args) = @_;
  if (exists $self->Watchers->{$args{Watcher}->Name}) {
    delete $self->Watchers->{$args{Watcher}->Name};
  } else {
    # throw warning does not exist
  }
}

sub Update {
  my ($self,%args) = @_;
  my $oldvalue = $self->Value;
  my $newvalue = $args{Value};
  $self->Value($newvalue);
  return
    {
     Update => FRDCSA::BehaviorTreePlanMonitor::Blackboard::KeyUpdate->new
     (
      KeyName => $self->Name,
      Pre => $oldvalue,
      Post => $newvalue,
     ),
     Watchers => $self->Watchers,
    };
}

1;
