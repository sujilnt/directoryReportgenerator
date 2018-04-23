use strict;
use warnings;
 
my ($path,$regexExpression) = @ARGV;
my $filename="data.txt";

if (not defined $path) {
  die "File is directory is not given , please try again \n";
}
if (not defined $regexExpression) {
  # if regular expression not added or with the script it automatically consider regular expression as *		
  $regexExpression="*";
  print "--Taking default Regular Expression. \n"
}

if (defined $regexExpression) {
  print "The regular Expression : $regexExpression \n";
  my $directorypathx= `pwd`;
  print `find '$path' -name '$regexExpression' -printf " %kKb %p\n" | sort -h -r > $filename `;
   
  #!/usr/bin/gnuplot
  # gnuplot script file for plotting bandwidth over time
  `cat << __EOF| gnuplot
  set terminal pngcairo font "arial,9.5" size 1920,800
  set output 'barchart.png'
  set datafile separator ""
  set boxwidth  50 absolute
  set style fill solid
  set rmargin 5
  set offsets 0.6, 0.1, 0,0
  set xlabel "FileNames with their paths"
  set ylabel "fileSize in KB"
  set xtics border in scale 0,0  rotate by -75  autojustify
  set title "File si8zes of the given folder"
  plot "data.txt" using 1:xtic(1) with impulses
__EOF`;
  # creating the HTML File 
  open my $HTML, '>', 'overview.html' or die "couldnt create a HTML file \n";
  print $HTML <<'_END_HEADER_';
  <html>
  <head><title></title></head>
  <body>
_END_HEADER_

print "---Image File created,creating HTML file .. \n";
# printing the heading in the html and image.
print $HTML "<h1 style='color:red; font-weight: bold; padding: 12px 0 0 29px; margin:0'>Name of the directory: $directorypathx$path'</h1>";
print $HTML "<img src='./barchart.png' alt='image not found'/>";

# opening the dat.txt and retrieving the data and creating table 
print $HTML "<table style='width:70%;border-spacing: 5px;padding: 0px 0px 44px 43px;'>";
# creating table headers
print $HTML "<tr>";
print $HTML "<th style='text-align: left;'> FIle Size in KB</th>";
print $HTML "<th style='text-align: left;'> FileNames with path</th>";
print $HTML "<th style='text-align: left;'> owner</th>";
print $HTML "</tr>";

open my $DataFile, '<', $filename or die "couldnt read data,txt, please run the script again ! \n";
while (my $line = <$DataFile>) {
my ($garbageVale,$sizeofFile1,$FileNames)= split /\s+/,$line;
my ($ownerOFFile)= `stat -c '%U' $FileNames`;
if(not defined $ownerOFFile) {
	$ownerOFFile="owner of the coludnt be retrieved."
}
print $HTML "<tr>";
print $HTML "<td> $sizeofFile1</td>";
print $HTML "<td> <a href='$FileNames'>$FileNames</a></td>";
print $HTML "<td> $ownerOFFile </td>" ;
print $HTML "</tr>";
} 
print $HTML "</table></body></html>";
close $HTML or die $!;
print "---successfully created overview.html file !! \n"
}


# how to run the program your script.

# with regularExpression as input  
#  perl task.pl <dir> "<regular Expression in quotes >"
# ex:- perl task.pl /bin "*t"

# running without regular Expression.   
#  perl task.pl <dir> 
# ex:- perl task.pl /bin 