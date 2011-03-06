use Test::More;
use WWW::Amazon::BookInfo;
use Business::ISBN;

unless ( $ENV{WWWAmazonBookInfo_Author} ) {
    plan skip_all => "Author tests this.";
}

eval "use Config::Pit ( )";
plan tests => 3;
my $config = Config::Pit::get( "amazon.co.jp" );

my $isbn = Business::ISBN->new( "978-4873114279" );

my $ua = WWW::Amazon::BookInfo->new(
    token      => $config->{token},
    secret_key => $config->{secret_key},
    locale     => $config->{locale},
);

my $res = $ua->search(
    isbn => $isbn,
);

isa_ok( $res, "WWW::Amazon::BookInfo::Response" );

$res = $ua->search(
    isbn => $isbn->as_isbn13->as_string,
);

isa_ok( $res, "WWW::Amazon::BookInfo::Response" );

$res = $ua->search(
    isbn => $isbn->as_isbn10->as_string,
);

isa_ok( $res, "WWW::Amazon::BookInfo::Response" );

