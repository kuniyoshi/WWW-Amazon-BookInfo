use Test::More tests => 1;

my $module = "WWW::Amazon::BookInfo";
eval "use $module";
my %param = (
    token      => "my_token",
    secret_key => "my_secret_key",
    locale     => "my_locale",
);
new_ok( $module, [ %param ] );

