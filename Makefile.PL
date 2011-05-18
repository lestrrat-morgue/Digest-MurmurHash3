use inc::Module::Install;
use Config;

all_from 'lib/Digest/MurmurHash3.pm';

tests "t/*.t";
use_xshelper();

if ( $Config{use64bitint} ) {
    makemaker_args DEFINE => "-DHAVE_64BITINT";
}
WriteAll;