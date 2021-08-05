use Test;
use JSON::Fast;

plan 0x21 * 2 + 2;

my @tests =
    "\x[0]"  => '"\\u0000"',
    "\x[1]"  => '"\\u0001"',
    "\x[2]"  => '"\\u0002"',
    "\x[3]"  => '"\\u0003"',
    "\x[4]"  => '"\\u0004"',
    "\x[5]"  => '"\\u0005"',
    "\x[6]"  => '"\\u0006"',
    "\x[7]"  => '"\\u0007"',
    "\x[8]"  => '"\\u0008"',
    "\x[9]"  => '"\\t"',
    "\x[a]"  => '"\\n"',
    "\x[b]"  => '"\\u000b"',
    "\x[c]"  => '"\\u000c"',
    "\x[d]"  => '"\\r"',
    "\x[e]"  => '"\\u000e"',
    "\x[f]"  => '"\\u000f"',
    "\x[10]" => '"\\u0010"',
    "\x[11]" => '"\\u0011"',
    "\x[12]" => '"\\u0012"',
    "\x[13]" => '"\\u0013"',
    "\x[14]" => '"\\u0014"',
    "\x[15]" => '"\\u0015"',
    "\x[16]" => '"\\u0016"',
    "\x[17]" => '"\\u0017"',
    "\x[18]" => '"\\u0018"',
    "\x[19]" => '"\\u0019"',
    "\x[1a]" => '"\\u001a"',
    "\x[1b]" => '"\\u001b"',
    "\x[1c]" => '"\\u001c"',
    "\x[1d]" => '"\\u001d"',
    "\x[1e]" => '"\\u001e"',
    "\x[1f]" => '"\\u001f"',
    "\r\n" => '"\\r\\n"';

for @tests {
    is (my $result = to-json($_.key)), $_.value, "control character $_.key.ord() => $_.value()";
    is from-json($result), $_.key, "control character goes backwards, too";
}

is from-json('"\u1234\r"'), "\x[1234]\r", "simple control character escape plus a unicode sequence";
is from-json('"\r\u1234"'), "\r\x[1234]", "simple control character escape plus a unicode sequence";
