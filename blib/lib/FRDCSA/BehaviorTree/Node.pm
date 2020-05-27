package FRDCSA::BehaviorTree::Node;

use Data::Dumper;

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / Name Description Parent Children /

  ];

sub init {
  my ($self,%args) = @_;
  my $ref = ref($self);
  $ref =~ s/.*:://;
  $self->Name($args{Name} || $ref.'-'.rand());
  $self->Description($args{Description} || '');
  $self->Parent($args{Parent});
  $self->Children($args{Children});
}


# some comments from:
# http://magicscrollsofcode.blogspot.com/2010/12/behavior-trees-by-example-ai-in-android.html

# As in any BT node, a CheckConditions and a DoAction functions,
sub CheckConditions {
  my ($self,%args) = @_;
  # to check if the node can be updated,

}

sub DoAction {
  my ($self,%args) = @_;
  # and to actually update the node, respectively.
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


1;


