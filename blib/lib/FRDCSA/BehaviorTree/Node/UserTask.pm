package FRDCSA::BehaviorTree::Node::UserTask;

use base 'FRDCSA::BehaviorTree::Node::LeafTask';

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
  $self->SUPER::init(%args);
}

sub Tick {
  my ($self,%args) = @_;
  # send a message saying we've started, wait for the user to tell us
  # to proceed

  my $result = $self->SUPER::Tick(%args);
  $self->Update
    (Update => 'JSON: '.to_json({Description => $self->Description, Name => $self->Name}));
  return $result;
}

1;
