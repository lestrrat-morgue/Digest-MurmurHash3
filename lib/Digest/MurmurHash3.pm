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

our @EXPORT_OK = qw( murmur32 mumur128 murmur128_x86 murmur128_x64 );
if ( ! HAVE_64BITINT ) {
    *murmur128_x64 = sub {
        Carp::croak( "64bit integers are not supported on your perl" );
    };
    *murmur128 = \&murmur128_x64;
} else {
    *murmur128 = \&murmur128_x86;
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

    my $hash = murmur32( $data_to_hash );

    # Create four 8 bit pieces
    my ($v1, $v2, $v3, $v4) = murmur128_x86( $data_to_hash );

    # Create two 64 bit pieces (your perl must be built to use 64bit ints)
    my ($v1, $v2) = murmur128_x64( $data_to_hash );

=cut