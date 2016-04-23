use lib 't/lib';

use Test::Schema;
use Test::More;
use Try::Tiny;

my $schema = Test::Schema->connect( 'dbi:SQLite:dbname=:memory:', '', '' )
  or die 'Unable to connect to schema';
$schema->deploy;

is_deeply [ $schema->sources ], ['User'], 'Schema has User ResultSet';

my $user = try {
    $schema->resultset('User')->create( {
            userName => 'Bill',
            passWord => 'pass',
        } )
}
catch { die $_ unless m/No such column/ };
ok $user, 'added user to db';

my $user_rs = $schema->resultset('User')->search( { userName => 'Bill' } );
my $count = try { $user_rs->count } catch { die $_ unless m/No such column/ };
is $count, 1, 'searched for user';

done_testing;

