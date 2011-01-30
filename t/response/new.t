use Test::More tests => 1;

my $module = "WWW::Amazon::BookInfo::Response";
eval "use $module";
new_ok( $module );

