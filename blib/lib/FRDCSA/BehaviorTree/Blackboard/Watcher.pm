package FRDCSA::BehaviorTree::Blackboard::Watcher;

use Data::Dumper;

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / Name Node Watching KeyUpdates /

  ];

sub init {
  my ($self,%args) = @_;
  $self->Name($args{Name});
  $self->Node($args{Node});
  $self->Watching({});
  $self->KeyUpdates([]);
}

sub WatchKey {
  my ($self,%args) = @_;
  if (! exists $self->Watching->{$args{Key}->Name}) {
    $self->Watching->{$args{Key}->Name} = $args{Key};
  } else {
    # throw error key already being watched
  }
}

sub UnwatchKey {
  my ($self,%args) = @_;
  if (exists $self->Watching->{$args{Key}->Name}) {
    delete $self->Watching->{$args{Key}->Name};
  } else {
    # throw error no key exists
  }
}

sub AddKeyUpdate {
  my ($self,%args) = @_;
  push @{$self->KeyUpdates}, $args{Update};
}

sub DoKeyUpdates {
  my ($self,%args) = @_;
  foreach my $keyupdate (@{$self->KeyUpdates}) {
    $self->Node->ProcessKeyUpdate
      (
       Watcher => $self,
       KeyUpdate => $keyupdate,
      );
  }
  $self->KeyUpdates([]);
}

1;
