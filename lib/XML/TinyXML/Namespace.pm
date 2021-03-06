# -*- tab-width: 4 -*-
# ex: set tabstop=4:

=head1 NAME

XML::TinyXML::Node - Tinyxml Node object

=head1 SYNOPSIS

=over 4

  use XML::TinyXML::Node;

  $node = XML::TinyXML::Node->new("child", "somevalue", { attribute => "value" });

  $attr = $node->getAttribute("attribute");
  or
  $attr = $node->getAttribute(1); # attribute at index 1
  or
  @attrs = $node->getAttributes(); # returns all attributes in the node
  
=back

=head1 DESCRIPTION

Node representation for the TinyXML API

=head1 INSTANCE VARIABLES

=over 4

=item * _attr

Reference to the underlying XmlNamespacePtr object (which is a binding to the XmlNamespace C structure)

=back

=head1 METHODS

=over 4

=cut

package XML::TinyXML::Namespace;
 
use strict;
use warnings;

our $VERSION = "0.34";

=item new ($ns)

Wrap the XmlNamespacePtr C structure exposing accessor to its members

=cut
sub new {
    my ($class, $ns) = @_;
    return undef unless(UNIVERSAL::isa($ns, "XmlNamespacePtr"));
    my $self = bless({ _ns => $ns }, $class);
    return $self;
}

=item name ([$newName])

Get/Set the short name (prefix) of the namespace

=cut
sub name {
    my ($self, $newName) = @_;
    my $name = $self->{_ns}->name;
    if ($newName) {
        $self->{_ns}->name($newName);
    }
    return $name;
}

=item value ([$newUri])

Get/Set the uri of the namespace

=cut
sub uri {
    my ($self, $newUri) = @_;
    my $uri = $self->{_ns}->uri;
    if ($newUri) {
        $self->{_ns}->uri($newUri);
    }
    return $uri;
}

=item type ()

Returns the type of this node

(at the moment it will return always the string : "NAMESPACE" 
 which can be used to distinguish namespace-nodes from attribute-nodes 
 or from xml-nodes in @sets returned by xpath selections)

=cut
sub type {
    return "NAMESPACE";
}

1;

=back

=head1 SEE ALSO

=over 4

XML::TinyXML::Node XML::TinyXML

=back

=head1 AUTHOR

xant, E<lt>xant@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008-2010 by xant

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.


=cut
