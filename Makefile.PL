use 5.010000;
use ExtUtils::MakeMaker;

eval "use Test::Manifest";

WriteMakefile(
    NAME              => 'WWW::Amazon::BookInfo',
    VERSION_FROM      => 'lib/WWW/Amazon/BookInfo.pm',
    PREREQ_PM         => {
        Readonly          => 0,
        "List::MoreUtils" => 0,
        "Business::ISBN"  => 0,
        "Net::Amazon"     => 0,
    },
    ABSTRACT_FROM     => 'lib/WWW/Amazon/BookInfo.pm',
    AUTHOR            => 'kuniyoshi kouji <kuniyoshi@cpan.org>',
);

