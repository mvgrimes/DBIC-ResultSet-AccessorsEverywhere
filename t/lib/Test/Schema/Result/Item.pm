package Test::Schema::Result::Item;

use parent qw/DBIx::Class::Core/;

__PACKAGE__->table("items");

__PACKAGE__->add_columns(
    id => {
        data_type         => "integer",
        is_auto_increment => 1,
        is_nullable       => 0,
    },
    user => {
        data_type         => "integer",
        is_nullable       => 0,
    },
    the_namey => {
        accessor    => 'name',
        data_type   => "varchar",
        is_nullable => 1,
        size        => 255
    },
);

__PACKAGE__->set_primary_key("id");

1;
