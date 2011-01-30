use Test::More tests => 1;

my $module  = "WWW::Amazon::BookInfo::Response";
my @methods = qw( isbn isbn13 isbn10 image );

eval "use $module";
can_ok( $module, @methods );

