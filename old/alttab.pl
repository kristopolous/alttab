#!/usr/bin/perl
use Data::Dumper;
use strict;
use warnings;
use feature qw(say state);

my @clientList;

my $windowRaw = `xlsclients -l | sed -E 's/^\ +//'`;
my @windowList = split(/\n/, $windowRaw);

my %current = ();
my $pattern = "";

TOP:
foreach(@windowList) {
  foreach $pattern ( qw{ ^(Window)\s(.*): ^Instance.(Class):\s*(.*)$ ^(Command):\s*(.*)$ } ) {
    if (my($key, $value) = $_ =~ /$pattern/s) {

      if (exists $current{$key}) {
        my %copy = %current;
        push @clientList, \%copy;
        my %current = ();
      } 

      $current{$key} = $value;

      next TOP;
    }
  } 
}

my %byId = ();

foreach(@clientList) {
  $byId{$_->{Window}} = "$_->{Class} $_->{Command}"
}


sub findWindow {
  my %match = ();
  my $window = "";
  my $search = "";
  while( ($window, $search) = each(%byId) ) {
    if ( $search =~ /$_[0]/i ) {
      $match{$window} = $search;
    }
  }
  return %match;
}


my %match = findWindow "skype";
print Dumper \%match;
