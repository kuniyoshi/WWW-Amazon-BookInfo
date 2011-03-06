use Test::More;

unless ( $ENV{WWWAmazonBookInfo_Author} ) {
    plan skip_all => "Author tests this.";
}

eval "use Test::Prereq";
prereq_ok( "5.010001" );

