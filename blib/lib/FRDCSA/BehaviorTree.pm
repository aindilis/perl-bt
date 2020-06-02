package FRDCSA::BehaviorTree;

# FRDCSA::BehaviorTree::Node::Root
# use FRDCSA::BehaviorTree::Node::Base;

use Data::Dumper;

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / Name SourceFileName Root Nodes Queue SendMessage Controller /

  ];

sub init {
  my ($self,%args) = @_;
  $self->Name($args{Name} || 'BehaviorTree-'.rand());
  $self->SourceFileName($args{SourceFileName});
  if (-f $self->SourceFileName) {
    $self->LoadFromSource();
  } else {
    $self->Root($args{Root});
  }
  $self->Controller($args{Controller});
  $self->UpdateNodes();
}

sub UpdateNodes {
  my ($self,%args) = @_;
  $self->Nodes({});
  $self->Queue([$self->Root]);
  $self->IndexNodes();
}

sub LoadFromSource {
  my ($self,%args) = @_;
}

sub IndexNodes {
  my ($self,%args) = @_;
  while (my $node = shift @{$self->Queue}) {
    $self->Nodes->{$node->Name} = $node;
    $node->Tree($self);
    if ($node->can('Description')) {
      print 'Indexing: '.$node->Description."\n";
    }
    if ($node->can('Children')) {
      if (defined $node->Children) {
	foreach my $child (@{$node->Children}) {
	  push @{$self->Queue}, $child;
	  $child->Parent($node);
	}
      }
    }
  }
}

sub Start {
  my ($self,%args) = @_;
  print "Starting root node.\n";
  # print Dumper($self);
  # while ($self->Root->Status eq 'BH_INVALID' or $self->Root->Status eq 'BH_RUNNING') {
  # print Dumper($self->Root->Status);
  $self->Root->Tick();
  # Mojo::IOLoop->singleton->one_tick();
  # }
  # print "Finished root node.\n";
}

sub Stop {
  my ($self,%args) = @_;
  # print "Stopping root node.\n";
  # $self->Root->Stop();
  # print "Stopped root node.\n";
}


# Interaction with the GUI, should make this abstract, by passing in callbacks

sub Log {
  my ($self,%args) = @_;
  # print "Logging: ".$args{Message}."\n";
  if ($args{Message}) {
    $self->Controller->app->plan_monitor_log($self->Controller,'Log: '.$args{Message});
  }
}

sub SendToMojo {
  my ($self,%args) = @_;
  # print "Updating: ".$args{Message}."\n";
  if ($args{Update}) {
    $self->Controller->app->plan_monitor_log($self->Controller,$args{Update});
  }
}

1;
