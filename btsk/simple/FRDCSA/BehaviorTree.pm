package FRDCSA::BehaviorTree::BehaviorTree;

use Data::Dumper;

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / m_pRoot /

  ];

=head1 NAME

FRDCSA::BehaviorTree::BehaviorTree - Class implementing the behaviors tree.

=head1 DESCRIPTION

Part of a pure-Perl behavior tree implementation.  Implemention based
on 'The Behavior Tree Starter Kit' (Chapter 6) by Alex J. Champandard
and Philip Dunstan, and the BTSK GitHub code.  Documentation
paraphrased.

=head1 SYNOPSIS



=head1 AUTHOR

Andrew John Dougherty

=head1 LICENSE

GPLv3

=cut

sub tick {
  my ($self,%args) = @_;
}

1;
