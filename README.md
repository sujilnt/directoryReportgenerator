# directoryReportgenerator
Genarating a Report of overview of the files under a given directory. It prints filename , user and the size . Main works good for linux machines


# Run the script with regular Expression
perl task.pl <dir> "<regular Expression in quotes >" 
 example 1:-
 
perl run.pl /bin  "*t"
 
# Run this script without without regular expression

 ex:- perl task.pl /bin  
*t -> the files names starting from  t
If no regular expression considered it automatically consider “*”;



