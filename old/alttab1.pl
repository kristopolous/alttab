#!/usr/bin/perl
use Data::Dumper;
use strict;
use warnings;
use feature qw(say state);

my @clientList;

sub doMap {
  `xdotool windowmap $_[0]`
}

sub doUnmap {
  `xdotool windowminimize $_[0]`
}

sub findWindow {
  my $string = "";
  my $id = "";

  my $windowRaw = `xwininfo -root -tree | grep ^"        0" | grep -v "has no name" | sed -E 's/\\s+//'`;
  my @windowList = split(/\n/, $windowRaw);

  my %byId = ();
  foreach(@windowList) {
    my ($id, $string) = $_ =~ /(0x[0-9a-f]*)(.*)/;
    $byId{$id} = $string;
  }

  my %match = ();
  my $window = "";
  my $search = "";
  while( ($window, $search) = each(%byId) ) {
    if ( $search =~ /$_[0]/i ) {
      $match{$window} = $search;
      doMap $window
    } else {
      doUnmap $window
    }
  }
  return %match;
}


while (<>) {
  chomp($_);
  print $_;
  my %match = findWindow $_;
  print Dumper \%match;
}
