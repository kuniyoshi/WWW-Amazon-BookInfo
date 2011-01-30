use Test::More;
use WWW::Amazon::BookInfo;
use Business::ISBN;

unless ( $ENV{WWWAmazonBookInfo_Author} ) {
    plan skip_all => "Author tests this.";
}

eval "use Test::Exception";
eval "use Config::Pit ( )";

plan tests => 1;

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

my $large_imgae = $res->image( "large" );

is( $large_imgae->{url}, "http://ecx.images-amazon.com/images/I/51Hgdb6WcQL.jpg" );

