$codemode=0;


open CODE, ">$ARGV[0].code";

while(<>)
{
    if(m/^##:/) {
        chomp;
        s/^##:\s*//;
        print $_."\n";
    }
    if(m/^##---/) {
        if($codemode) {
            print("``");
            $codemode = 0;
        } else {
            print("``\n");
            $codemode = 1;
        }
    } elsif($codemode) {
        print $_;
        print CODE $_;
    }

}
