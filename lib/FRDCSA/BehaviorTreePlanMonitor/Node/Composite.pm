package FRDCSA::BehaviorTreePlanMonitor::Node::Composite;

use base 'FRDCSA::BehaviorTreePlanMonitor::Node::Base';
use base 'FRDCSA::BehaviorTreeStarterKit::Composite';

use Data::Dumper;

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / /

  ];

sub init {
  my ($self, %args) = @_;
  print "start init composite\n";
  my $ref = ref($self);
  print "$ref\n";
  $self->Children($args{Children} || []);
  $self->FRDCSA::BehaviorTreePlanMonitor::Node::Base::init();
  $self->FRDCSA::BehaviorTreeStarterKit::Composite::init();
  print "finish init composite\n";
}

sub Children {
  my ($self, $children) = @_;
  if (! defined $children) {
    return $self->m_Children;
  } else {
    $self->m_Children($children);
  }
}

1;



