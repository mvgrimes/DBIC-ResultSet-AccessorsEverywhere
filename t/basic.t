use lib 't/lib';

use Test::Schema;
use Test::More;
use Try::Tiny;

# Connect to test DB and deploy
my $schema = Test::Schema->connect( 'dbi:SQLite:dbname=:memory:', '', '' )
  or die 'Unable to connect to schema';
$schema->deploy;

# Insert into DB using accessor names instead of field names
my $user = try {
    $schema->resultset('User')->create( {
            userName => 'Bill',
            passWord => 'pass',
        } )
}
catch { die $_ unless m/No such column/ };
ok $user, 'added user to db by accessor';

# Find by accessor names instead of field name
my $user_fetch =
  try { $schema->resultset('User')->find( { userName => 'Bill' } ) }
catch { die $_ unless m/No such column/; return };
ok $user_fetch, 'find user by accessor';

# Ensure we can still find by an ID
ok $schema->resultset('User')->find( $user->id ), 'find by id';

# Search using accessor instead of field name
my $user_rs = $schema->resultset('User')->search( { userName => 'Bill' } );
my $count =
  try { $user_rs->count } catch { die $_ unless m/No such column/; return };
is $count, 1, 'searched for user by accessor';

# Insert via add_to_*
my $item =
  try { $user->add_to_items( { name => 'The item' } ) }
catch { die $_ unless m/No such column/; return };
ok $item, 'inserted via add_to_';
is $user->items->first->name, 'The item', '... with the correct name';

done_testing;

