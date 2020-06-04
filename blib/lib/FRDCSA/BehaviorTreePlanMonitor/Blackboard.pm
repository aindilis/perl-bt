package FRDCSA::BehaviorTreePlanMonitor::Blackboard;

use Data::Dumper;

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / Keys /

  ];

sub init {
  my ($self,%args) = @_;
  $self->Keys({});
}

sub AddKey {
  my ($self,%args) = @_;
  if (! exists $self->Keys->{$args{Key}->Name}) {
    $self->Keys->{$args{Key}->Name} = $args{Key};
  } else {
    # throw an error that the key already exists
  }
}

sub Update {
  my ($self,%args) = @_;
  my $toupdate = {};
  foreach my $key (keys %{$args{Keys}}) {
    my $res = $self->Keys->{$key}->Update(Value => $args{Keys}{$key});
    foreach my $name (keys %{$res->{Watchers}}) {
      if (! exists $toupdate->{$name}) {
	$toupdate->{$name} = $res->{Watchers}{$name};
      }
      $watcher->AddKeyUpdate(Update => $res->{KeyUpdate});
    }
  }
  foreach my $watcher (values %$toupdate) {
    $watcher->DoKeyUpdates();
  }
}

1;
