package WWW::Amazon::BookInfo::Response;

use 5.010000;
use utf8;
use strict;
use warnings;
use mro;
use parent "Net::Amazon::Response";
use Carp qw( croak );
use Readonly;
use Scalar::Util qw( blessed );
use List::MoreUtils qw( none );
use Business::ISBN;

Readonly my @IMAGE_TYPES => qw(
    thumbnail  small  tiny  swatch  medium  large
);

our $VERSION = "0.01";

sub isbn {
    my $self = shift;

    if ( @_ ) {
        my $isbn = shift;

        unless ( blessed $isbn ) {
            $isbn = Business::ISBN->new( $isbn );
        }

        $self->{_book_info_isbn} = $isbn;
    }

    return $self->{_book_info_isbn};
}

sub isbn13 {
    my $self = shift;

    return $self->isbn->as_isbn13->as_string;
}

sub isbn10 {
    my $self = shift;

    return $self->isbn->as_isbn10->as_string;
}

sub image {
    my $self = shift;
    my $type = shift;

    croak "Image type required."
        unless $type;

    if ( none { $_ eq $type } @IMAGE_TYPES ) {
        croak "No type[$type] found.";
    }

    my $image = do {
        my $key = sprintf "%sImage", ucfirst $type;
        $self->{xmlref}{Items}[0]{ImageSets}{ImageSet}{$key};
    };

    die "The height units isn't pixels"
        if $image->{Height}{Units} ne "pixels";
    die "The width units isn't pixels"
        if $image->{Width}{Units} ne "pixels";

    return {
        type   => $type,
        url    => $image->{URL},
        height => $image->{Height}{content},
        width  => $image->{Width}{content},
    };
}

1;

__END__
=encoding utf-8

=head1 NAME

WWW::Amazon::BookInfo::Response - Wraps Net::Amazon::Response for simply

=head1 SYNOPSIS

  Blah blah blah.

=head1 DESCRIPTION

Blah blah blah.

=head1 PROPERTIES

=over

=item authors
=item publisher
=item title
=item isbn
=item edition
=item ean
=item numpages
=item dewey_decimal
=item publication_date
=item images
=item image

=back

=head1 AUTHOR

kuniyoshi kouji, E<lt>kuniyoshi@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2011 by kuniyoshi kouji

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.12.1 or,
at your option, any later version of Perl 5 you may have available.


=cut
