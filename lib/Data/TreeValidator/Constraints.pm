package Data::TreeValidator::Constraints;
BEGIN {
  $Data::TreeValidator::Constraints::VERSION = '0.01';
}
# ABSTRACT: A collection of constraints for validating data
use strict;
use warnings;

use Sub::Exporter -setup => {
    exports => [ qw( required ) ]
};

sub required { \&_required }
sub _required {
    local $_ = shift;
    die "Required" unless defined $_ && "$_" ne '';
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

=head1 METHODS

=head2 required($input)

Checks that $input is defined, and stringifies to a true value (not the empty
string)

=head1 AUTHOR

Oliver Charles

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Oliver Charles <oliver.g.charles@googlemail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

