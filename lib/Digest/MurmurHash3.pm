package Digest::MurmurHash3;
use strict;
use base qw(Exporter);
use Config ();
use constant HAVE_64BITINT => $Config::Config{use64bitint};
use XSLoader;
BEGIN {
    our $VERSION = '0.01';
    XSLoader::load __PACKAGE__, $VERSION;
}

our @EXPORT_OK = qw( murmur32 murmur128_x86 murmur128_x64 );
if ( ! HAVE_64BITINT ) {
    *murmur128_x64 = sub {
        Carp::croak( "64bit integers are not supported on your perl" );
    };
}

1;
__END__

=head1 NAME

Digest::MurmurHash3 - MurmurHash3 Implementation For Perl

=head1 SYNOPSIS

    use Digest::MurmurHash3 qw( murmur32 );

    # on 64 bit platforms, defaults to x64. otherwise x86
    # note that the values for each platform *WILL DIFFER*
    use Digest::MurmurHash3 qw( murmur128 );

    # If you want to explicitly require one algorithm, you need
    # to be specific
    use Digest::MurmurHash3 qw( murmur128_x64 );
    use Digest::MurmurHash3 qw( murmur128_x86 );

    my $hash = mumur32( $data_to_hash );

=cut