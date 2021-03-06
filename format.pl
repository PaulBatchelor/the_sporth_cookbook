use 5.01;
use strict;

my $codemode=0;
my $openfile= 1;
my $out;
open FILE, $ARGV[0];
while(<FILE>)
{
    if(m/^##:/) {
        chomp;
        s/^##:\s*//;

        print $_."\n";

        if(m/\# (.*)/ and $openfile == 1) {
            my $name = lc($1);
            $name =~ s/ /_/g;
            $out = "res/cook/$name.sp";
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

# the best back button is no back button
# print("\n\\[[Back](/proj/cook)]\n\n");

close FILE;
