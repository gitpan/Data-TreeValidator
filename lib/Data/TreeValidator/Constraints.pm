package Data::TreeValidator::Constraints;
BEGIN {
  $Data::TreeValidator::Constraints::VERSION = '0.02';
}
# ABSTRACT: A collection of constraints for validating data
use strict;
use warnings;

use Data::TreeValidator::Util qw( fail_constraint );
use Set::Object qw( set );

use Sub::Exporter -setup => {
    exports => [ qw( length options required ) ]
};

sub required { \&_required }
sub _required {
    local $_ = shift;
    fail_constrant("Required") unless defined $_ && "$_" ne '';
}

sub length {
    my %args = @_;
    my ($min, $max) = @args{qw( min max )};
    return sub {
        my ($input) = @_;

        fail_constraint("Input must be longer than $min characters")
            if exists $args{min} && length($input) < $min;
        fail_constraint("Input must be shorter than $max characters")
            if exists $args{max} && length($input) > $max;
    }
}

sub options {
    my $valid = set(@_);
    return sub {
        my ($input) = @_;
        $valid->contains($input);
    };
}

1;


__END__
=pod

=encoding utf-8

=head1 NAME

Data::TreeValidator::Constraints - A collection of constraints for validating data

=head1 SYNOPSIS

    use Data::TreeValidator::Constraints qw( required );

=head1 DESCRIPTION

Constraints currently take a single form, a subroutine reference. If the data
does not validate, an exception will be raised (which is caught by process
methods). If an exception is not raised, the data will be assumed to be valid.

All methods below are available for importing into using modules

=head1 FUNCTIONS

=head2 required

Checks that $input is defined, and stringifies to a true value (not the empty
string)

=head2 length min => $min, max => $max

Checks that a given input is between C<$min> and C<$max>. You do not have to
specify both parameters, either or is also fine.

=head2 options @options

Checks that a given input is in the set defined by C<@options>.

=head1 AUTHOR

Oliver Charles

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Oliver Charles <oliver.g.charles@googlemail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

