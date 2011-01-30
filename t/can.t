use Test::More tests => 1;

my $module  = "WWW::Amazon::BookInfo";
my @methods = qw( search );

eval "use $module";
can_ok( $module, @methods );

