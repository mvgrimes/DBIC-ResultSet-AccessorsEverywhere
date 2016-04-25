# NAME

DBIx::Class::ResultSet::AccessorsEverywhere - Component for DBIx::Class that allows the use of accessor names in search/create/etc

# VERSION

version 0.10

# STATUS

<div>
    <a href="https://travis-ci.org/mvgrimes/DBIC-ResultSet-AccessorsEverywhere"><img src="https://travis-ci.org/mvgrimes/DBIC-ResultSet-AccessorsEverywhere.svg?branch=master" alt="Build Status"></a>
    <a href="https://metacpan.org/pod/DBIx::Class::ResultSet::AccessorsEverywhere"><img alt="CPAN version" src="https://badge.fury.io/pl/DBIC-ResultSet-AccessorsEverywhere.svg" /></a>
</div>

# DESCRIPTION

    package Schema::ResultSet::User;
    use parent 'DBIx::Class::ResultSet';
    __PACKAGE__->load_components('AccessorsEverywhere');
    1;

    package Schema::Result::User;
    use parent qw/DBIx::Class::Core/;
    __PACKAGE__->table("users");
    __PACKAGE__->add_columns(
        id => {
            data_type         => "integer",
            is_auto_increment => 1,
            is_nullable       => 0,
        },
        'the_firstNameX' => {   # a really poorly named column in the db
            accessor    => 'first_name',     # a "perlish" accessor
            data_type   => "varchar",
            is_nullable => 1,
            size        => 255
        },
    );
    __PACKAGE__->set_primary_key("id");
    1;

    ## Your app:
    $schema->resultset('User')->create({ first_name => 'Bill' });
    $schema->resultset('User')->search({ first_name => 'Bill' });

By specifying the `accessor` attribute when defining a table schema,
[DBIx::Class](https://metacpan.org/pod/DBIx::Class) can change the name of accessors it creates for those columns.
This can be extremely helpful when the database fields are poorly named and
not under your control. Unfortunately, DBIx::Class expects the table column
names when creating new entries, searching, etc.

`DBIx::Class::AccessorsEverywhere` is component that can be loaded into your
ResultSet classes that allows the use of the accessor names instead in
create, search, etc. operations.

This is an early release. Don't expect this to work everywhere. The following
DBIx::Class methods have been tested, others might work, but need to be tested.

    $rs->create({ accessor_name => 'value' });
    $rs->search({ accessor_name => 'value' });

# SEE ALSO

[DBIx::Class](https://metacpan.org/pod/DBIx::Class)

# BUGS

Please report any bugs or feature requests on the bugtracker website [http://github.com/mvgrimes/DBIC-ResultSet-AccessorsEverywhere/issues](http://github.com/mvgrimes/DBIC-ResultSet-AccessorsEverywhere/issues)

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

# AUTHOR

Mark Grimes <mgrimes@cpan.org>

# SOURCE

Source repository is at [https://github.com/mvgrimes/DBIC-ResultSet-AccessorsEverywhere](https://github.com/mvgrimes/DBIC-ResultSet-AccessorsEverywhere).

# COPYRIGHT AND LICENSE

This software is copyright (c) 2016 by Mark Grimes <mgrimes@cpan.org>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
