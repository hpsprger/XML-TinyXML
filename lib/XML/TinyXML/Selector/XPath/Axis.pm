package XML::TinyXML::Selector::XPath::Axis;

sub child {
    my ($class, $context) = @_;
    return map { $_->children } @{$context->items};
}

sub descendant {
    my ($class, $context) = @_;
    my @res = map { $_->children } @{$context->items};
    if (@res) {
        my $newctx = XML::TinyXML::Selector::XPath::Context->new($context->xml);
        $newctx->{items} = \@res;
        push (@res, descendant($class, $newctx));
    }
    return wantarray?@res:\$res;
}

sub parent {
    my ($class, $context) = @_;
    return $context->parent;
}

sub ancestor {
    my ($class, $context) = @_;
    my @res;
    foreach my $node (@{$context->items}) {
        my $parent = $node->parent;
        push(@res, $parent)
           if($parent); 
    }

    if (@res) {
        my $newctx = XML::TinyXML::Selector::XPath::Context->new($context->xml);
        $newctx->{items} = \@res;
        my @new = ancestor($class, $newctx);
        push (@res, @new)
            if (@new);
    }
    return wantarray?@res:\@res;
}

sub following_sibling {
    my ($class, $context) = @_;
    my @res;
    foreach my $node (@{$context->items}) {
        while ($node) {
            my $next = $node->nextSibling;
            push (@res, $next) if $next;
            $node = $next;
        }
    }
    return wantarray?@res:\@res;
}

sub preceding_sibling {
    my ($class, $context) = @_;
    foreach my $node (@{$context->items}) {
        my @res;
        while ($node) {
            my $prev = $node->prevSibling;
            push (@res, $prev) if $prev;
            $node = $prev;
        }
    }
    return wantarray?@res:\@res;
}

sub attribute {
    my ($class, $context) = @_;
    return map { $_->attributes } @{$context->items};
}

sub self {
    my ($class, $context) = @_;
    return @{$context->items};
}

sub descendant_or_self {
    my ($class, $context) = @_;
    my @res = descendant($context);
    unshift(@res, $context->{node});
    return wantarray?@res:\@res;
}

sub ancestor_or_self {
    my ($class, $context) = @_;
    my @res = ancestor($context);
    unshift(@res, $context->{node});
    return wantarray?@res:\@res;
}


1;
