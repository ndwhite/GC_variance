#!/usr/bin/perl
#Calculate variance of GC content in a fasta-format alignment
#Noor D. White
use Data::Dumper

$All_squares_here = 0;
$Average_GC = 0;
$All_Nuc = 0;
$G = 0;
$C = 0;
$GC = 0;
$Squar_GC = 0;
$length = 0;
$Num_taxa = 0;
$Variance = 0;
$NumG = 0;
$NumC = 0;
$nucleotides = 0;

#Open file
open (FILE, $ARGV[0]) || die "where is the file?\n";
until (eof FILE) {
	$line = <FILE>;
	chomp $line;

#Calculate average GC for every taxon
	#Read in $header
	if ($line =~ m/>/){
	$Num_taxa++;
	} else {

	#Read in $sequence
	$sequence = $line;

	#replace '-' in $sequence
	$sequence=~ s/\-//g;
	#replace g with G
	$sequence=~ s/g/G/g;
	#replace c with C
	$sequence=~ s/c/C/g;
	#count 'G' in $sequence	-> $G
	$G = grep {$_ eq 'G'} split //, $sequence;
	#count 'C' in $sequence	-> $C
	$C = grep {$_ eq 'C'} split //, $sequence;
	#sum $G and $C  -> $GC
	$GC = $G + $C;

	#explode and add number of nucleotides in $sequence to $All_Nuc
	$nucleotides = length $sequence;
	$All_Nuc = $All_Nuc + $nucleotides;
	
	#Add Gs and Cs to overall GC summation for locus
	$NumG = $NumG + $G;
	$NumC = $NumC + $C;
	
	#Square $GC -> $Squar_GC
	$Squar_GC = $GC ** 2;

	#Add $Squar_GC to $All_squares_here	
	$All_squares_here = $All_squares_here + $Squar_GC;
	}
}		

#Calculate overall GC content of locus
	#$Average_GC = ($NumG + $NumC)/$length
	$Average_GC = ($NumG + $NumC)/$All_Nuc;

#Calculate Variance
	$Variance = $All_squares_here/$Num_taxa;

#print "Locus\tAverage GC\tVariance\n$ARGV[0]\t$Average_GC\t$Variance\n";
print "$ARGV[0]\t$Average_GC\t$Variance\n";

end;
