package WWW::Amazon::BookInfo;

use 5.010000;
use utf8;
use strict;
use warnings;
use mro;
use parent "Net::Amazon";
use Carp qw( croak );
use Readonly;
use Scalar::Util qw( blessed );
use Business::ISBN;
use WWW::Amazon::BookInfo::Response;

our $VERSION = "0.03";

Readonly my %DEFAULT => (
    locale => "jp",
);

sub search {
    my $self  = shift;
    my %param = @_;

    croak "ISBN required."
        unless exists $param{isbn};

    if ( ! blessed $param{isbn} ) {
        $param{isbn} = Business::ISBN->new( $param{isbn} );
    }
    elsif ( ! $param{isbn}->isa( "Business::ISBN" ) ) {
        croak "ISBN should isa Business::ISBN.";
    }
    elsif ( $param{isbn}->isa( "Business::ISBN" ) ) {
        ;
    }
    else {
        croak "Could not parse ISBN.";
    }

    my $string = join q{}, split m{[-]}, $param{isbn}->as_isbn13->as_string;
    my $isbn   = $param{isbn};
    $param{isbn} = $string;

    my $res = $self->next::method( %param );

    if ( $res->is_error ) {
        die sprintf "Could not get information of %s.[%s]",
            $param{isbn}, $res->message;
    }

    die "Too many properties ware found." if @{ [ $res->properties ] } > 1;

    my $book = bless $res, "WWW::Amazon::BookInfo::Response";
    $book->isbn( $isbn );

    return $book;
}

1;
__END__
=encoding utf-8

=head1 NAME

WWW::Amazon::BookInfo - Wrapper for Net::Amazon to simple find book info.

=head1 SYNOPSIS

  use WWW::Amazon::BookInfo;

  my $ua  = WWW::Amazon::BookInfo->new(
      token      => $token,
      secret_key => $secret_key,
  );

  my $res = $ua->search( isbn => $isbn );

  say $res->isbn;

=head1 DESCRIPTION

Wraps Net::Amazon to describe book by using Amazon's data.

=head1 SEE ALSO

=over

=item Net::Amazon

=over

=item Net::Amazon::Property::Book

=item Net::Amazon::Response::ISBN

=back

=back

=head1 AUTHOR

kuniyoshi kouji, E<lt>kuniyoshi@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2011 by kuniyoshi kouji

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.12.1 or,
at your option, any later version of Perl 5 you may have available.


=cut

