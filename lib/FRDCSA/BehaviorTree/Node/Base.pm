package FRDCSA::BehaviorTree::Node::Base;

use Data::Dumper;

use Time::HiRes qw(usleep);

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / Name Description Tree Parent Children Status Watchers /

  ];

sub init {
  my ($self,%args) = @_;
  my $ref = ref($self);
  $ref =~ s/.*:://;
  $self->Name($args{Name} || $ref.'-'.rand());
  $self->Description($args{Description} || '');
  $self->Tree($args{Tree});
  $self->Parent($args{Parent});
  $self->Children($args{Children} || []);
  $self->Status($args{Status});
  foreach my $child (@{$self->Children}) {
    if (! defined $child->Parent) {
      $child->Parent($self);
    }
  }
  $self->Watchers($args{Watchers});
}

# some comments from:
# http://magicscrollsofcode.blogspot.com/2010/12/behavior-trees-by-example-ai-in-android.html


# As in any BT node, a CheckConditions and a DoAction functions,

# sub Start {
#   my ($self,%args) = @_; 
# }

sub Stop {
  my ($self,%args) = @_; 
  $self->Status($args{Status});
  if (defined $self->Children) {
    foreach my $child (@{$self->Children}) {
      $child->Stop(Status => $self->Status);
    }
  }
}

# The Start and End functions are called

sub Start {
  my ($self,%args) = @_;
  # just before starting to update the node,
}


sub End {
  my ($self,%args) = @_;
  # and just after finishing the logic of the node.
}

sub Tick {
  my ($self, %args) = @_;
  $self->Status('running');
  # this is started, so now if it's a regular task, we have to send a message to the GUI saying we've started
  $self->Log(Message => 'Ticked: '.$self->Name);
  $self->DoAction(%args);
  return {
	  Status => $self->Status,
	 };
}

sub DoAction {
  my ($self,%args) = @_;
  # and to actually update the node, respectively.
}

sub CheckConditions {
  my ($self,%args) = @_;
  # to check if the node can be updated,
}

sub Update {
  my ($self,%args) = @_;
  $self->Tree->Update(%args);
}

sub Log {
  my ($self,%args) = @_;
  $self->Tree->Log(%args);
}


1;



