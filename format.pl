use 5.01;
use strict;

my $codemode=0;
my $openfile= 1;

while(<>)
{
    if(m/^##:/) {
        chomp;
        s/^##:\s*//;

        print $_."\n";

        if(m/\# (.*)/ and $openfile == 1) {
            my $name = lc($1);
            $name =~ s/ /_/g;
            my $out = "res/cook/$name.sp";
            open CODE, ">$out";
            print("\n\\[[code](/$out)]\n\n");
            $openfile = 0;
        }
    }
    if(m/^##---/) {
        if($codemode) {
            $codemode = 0;
            print("\n");
        } else {
            $codemode = 1;
            print("\n");
        }
    } elsif($codemode) {
        print "    $_";
        print CODE $_;
    }

}
