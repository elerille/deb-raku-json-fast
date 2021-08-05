[![Build Status](https://travis-ci.org/timo/json_fast.svg?branch=master)](https://travis-ci.org/timo/json_fast)

JSON::Fast
==========

a naive imperative json parser in pure perl6 (but with direct access to `nqp::` ops), to evaluate performance against `JSON::Tiny`. It is a drop-in replacement for `JSON::Tiny`’s from-json and to-json subs, but it offers a few extra features.

Currently it seems to be about 4x faster and uses up about a quarter of the RAM JSON::Tiny would use.

This module also includes a very fast to-json function that tony-o created and lizmat later completely refactored.

Exported subroutines
--------------------

### to-json

        my $*JSON_NAN_INF_SUPPORT = 1; # allow NaN, Inf, and -Inf to be serialized.
        say to-json [<my Perl data structure>];
        say to-json [<my Perl data structure>], :!pretty;
        say to-json [<my Perl data structure>], :spacing(4);

    enum Blerp <Hello Goodbye>;
    say to-json [Hello, Goodbye]; # ["Hello", "Goodbye"]
    say to-json [Hello, Goodbye], :enums-as-value; # [0, 1]

Encode a Perl data structure into JSON. Takes one positional argument, which is a thing you want to encode into JSON. Takes these optional named arguments:

#### pretty

`Bool`. Defaults to `True`. Specifies whether the output should be "pretty", human-readable JSON. When set to false, will output json in a single line.

#### spacing

`Int`. Defaults to `2`. Applies only when `pretty` is `True`. Controls how much spacing there is between each nested level of the output.

#### sorted-keys

`Bool`, defaults to `False`. Specifies whether keys from objects should be sorted before serializing them to a string or if `$obj.keys` is good enough.

### from-json

        my $x = from-json '["foo", "bar", {"ber": "bor"}]';
        say $x.perl;
        # outputs: $["foo", "bar", {:ber("bor")}]

Takes one positional argument that is coerced into a `Str` type and represents a JSON text to decode. Returns a Perl datastructure representing that JSON.

Additional features
-------------------

### Strings containing multiple json pieces

When the document contains additional non-whitespace after the first successfully parsed JSON object, JSON::Fast will throw the exception `X::JSON::AdditionalContent`. If you expect multiple objects, you can catch that exception, retrieve the parse result from its `parsed` attribute, and remove the first `rest-position` characters off of the string and restart parsing from there.

