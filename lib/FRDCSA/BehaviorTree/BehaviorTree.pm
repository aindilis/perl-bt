package FRDCSA::BehaviorTree::BehaviorTree;

use Data::Dumper;

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / Name SourceFileName /

  ];

sub init {
  my ($self,%args) = @_;
  $self->Name($args{Name} || 'BehaviorTree-'.rand());
  $self->SourceFileName($args{SourceFileName});
}

sub Load {
  my ($self,%args) = @_;

}

1;


