package FRDCSA::BehaviorTree::Node::UserTask;

use base 'FRDCSA::BehaviorTree::Node::Base';
use base 'FRDCSA::BehaviorTreeStarterKit::Action';

use Mojo::IOLoop;

use Data::Dumper;

use JSON qw(to_json from_json);

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / UserFeedback /

  ];

sub init {
  my ($self,%args) = @_;
  $self->FRDCSA::BehaviorTree::Node::Base::init(%args);
  $self->FRDCSA::BehaviorTreeStarterKit::Action::init(%args);
}

sub Tick {
  my ($self,%args) = @_;
  print "UserTask Tick\n";
  $self->FRDCSA::BehaviorTree::Node::Base::Tick();
}

sub tick {
  my ($self,%args) = @_;
  print "UserTask tick\n";
  print 'Status: '.$self->Status."\n";
  if ($self->Status eq 'BH_INVALID') {
    $self->SendToMojo(Update => 'Log: Starting Task Node '.$self->Description);
    $self->SendToMojo(Update => 'JSON: '.to_json({Description => $self->Description, Name => $self->Name}));
    # $self->SendToMojo(Update => 'JSON: '.to_json({Message => 'Starting Task Node '.$self->Description, Name => $self->Name}));
    $self->Status('BH_RUNNING');
    sleep 1;
  } elsif ($self->Status eq 'BH_RUNNING') {
    if (defined $self->UserFeedback) {
      if ($self->UserFeedback->{action} eq 'update' and
	  $self->UserFeedback->{value} eq 'done') {
	$self->SendToMojo(Update => 'Log: Succeeded: Task Node '.$self->Description);
    # $self->SendToMojo(Update => 'JSON: '.to_json({Message => 'Finishing Task Node '.$self->Description, Name => $self->Name}));
	$self->Status('BH_SUCCESS');
	$self->UserFeedback(undef);
      } elsif ($self->UserFeedback->{action} eq 'update' and
	       $self->UserFeedback->{value} eq 'failed') {
	$self->SendToMojo(Update => 'Log: Failed: Task Node '.$self->Description);
	$self->Status('BH_FAILURE');
	$self->UserFeedback(undef);
      } else {
	$self->SendToMojo(Update => 'Log: Invalid Response: Task Node '.$self->Description);
	$self->Status('BH_INVALID');
	$self->UserFeedback(undef);
      }
    }
  }
  $self->FRDCSA::BehaviorTreeStarterKit::Action::tick();
}

1;
