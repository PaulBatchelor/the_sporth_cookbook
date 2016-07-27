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
            print("\\end{lstlisting}\n");
            print("\\end{tabular}\n");
            print("\\newline\\newline\n");
            $codemode = 0;
        } else {
            print("\\newline\\newline\n");
            print("\\begin{tabular}{ | l l } &\n");
            print("\\begin{lstlisting}\n");
            $codemode = 1;
        }
    } elsif($codemode) {
        print $_;
        print CODE $_;
    }

}
