package FRDCSA::BehaviorTreePlanMonitor::Parser::FirstPass;

use Data::Dumper;

use base qw( Parser::MGC );

sub Clauses {
  my $self = shift;
  my ( $clauses, %opts ) = @_;
  if (defined $clauses) {
    $self->{clauses} = $clauses;
  } else {
    return $self->{clauses};
  }
}

sub parse {
  my $self = shift;
  print "parse\n";
  $self->Clauses({});
  my $rootnode = $self->parse_rule_list;
  print Dumper($rootnode);
  return
    {
     Success => 1,
     Clauses => $self->Clauses,
    };
}

sub parse_rule_list {
  my $self = shift;
  print "parse_rule_list\n";
  $self->sequence_of
    (
     sub { $self->parse_rule; }
    );
  print Dumper($self->Clauses);
}

sub parse_rule {
  my $self = shift;
  print "parse_rule\n";

  my $head = $self->parse_head;
  my $operator = $self->parse_operator;
  my $body = $self->parse_body;

  $self->Clauses->{$head} =
    {
     Head => $head,
     Operator => $operator,
     Body => $body,
    };
}

sub parse_head {
  my $self = shift;
  print "parse_head\n";
  my $head = $self->parse_predicate();
  print Dumper($head);
  return $head;
}

sub parse_predicate {
  my $self = shift;
  print "parse_predicate\n";
  return $self->expect( qr/[a-z][a-zA-Z0-9_]*/ );
}

sub parse_operator {
  my $self = shift;
  print "parse_operator\n";
  my $operator = $self->any_of( 'parse_sequence_operator', 'parse_selector_operator' );
  print Dumper($operator);
  return $operator;
}

sub parse_sequence_operator {
  my $self = shift;
  print "parse_sequence_operator\n";
  my $operator = $self->expect( qr/->/ );
  print Dumper($operator);
  return $operator;
}

sub parse_selector_operator {
  my $self = shift;
  print "parse_selector_operator\n";
  my $operator = $self->expect( qr/>>/ );
  print Dumper($operator);
  return $operator;
}

sub parse_body {
  my $self = shift;
  print "parse_body\n";
  my $conjunctlist = $self->parse_conjunct_list;
  $self->parse_period;
  print Dumper($conjunctlist);
  return $conjunctlist;
}

sub parse_conjunct_list {
  my $self = shift;
  print "parse_conjunct_list\n";
  my $conjuncts = $self->list_of
    (
     ",",
     sub {
       $self->parse_predicate;
     }
    );
  @$conjuncts > 0 or $self->fail( "Expected at least one conjunct" );
  return $conjuncts;
}

sub parse_period {
  my $self = shift;
  print "parse_period\n";
  print Dumper($self->expect( qr/\./ ));
}

1;
