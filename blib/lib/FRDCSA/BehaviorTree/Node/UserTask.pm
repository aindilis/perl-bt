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

   qw / /

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
    $self->SendToMojo(Update => 'JSON: '.to_json({Message => 'Starting Task Node '.$self->Description, Name => $self->Name}));
    $self->Status('BH_RUNNING');
  } elsif ($self->Status eq 'BH_RUNNING') {
    $self->SendToMojo(Update => 'JSON: '.to_json({Message => 'Finishing Task Node '.$self->Description, Name => $self->Name}));
    $self->Status('BH_SUCCESS');
  }
  $self->FRDCSA::BehaviorTreeStarterKit::Action::tick();
}

1;
