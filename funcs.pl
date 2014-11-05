#!/usr/bin/perl -w
#copyright(c)2014 Hsiang Chen

use strict;

sub	main{
	my $file;
	my $out;
	open OUT,">funcs.inc";
	printf OUT "; this file is generated by perl script.\n";
	foreach $file (<*.asm>){
		printf	"%s\n{\n",$file;
		printf	OUT "; %s\n",$file;
		open IN,"<$file";
		my $line;
		while(defined($line = <IN>)){
			chomp($line);
			if($line =~ s/^(\w+)(\s+|\t+)proc/$1$2proto/){
				$line =~ s/(\s+|\t+)uses(\s+|\t+)/$1$2/;
				$line =~ s/(\s+|\t+)esi((\s+|\t+)|,\w+|)/$1$2/;
				$line =~ s/(\s+|\t+)edi((\s+|\t+)|,\w+|)/$1$2/;
				$line =~ s/(\s+|\t+)ebx((\s+|\t+)|,\w+|)/$1$2/;
				$line =~ s/(\s+|\t+)ecx((\s+|\t+)|,\w+|)/$1$2/;
				$line =~ s/(\s+|\t+)edx((\s+|\t+)|,\w+|)/$1$2/;
				$line =~ s/(\s+|\t+),(\w+)/$1$2/;
				printf "%s\n",$line;
				printf OUT "%s\n",$line;
			}
		}
		close IN;
		printf	"}\n";
	}
	close OUT;
}

main;