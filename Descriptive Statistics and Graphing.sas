data one;
input x;
n=5;
p=0.40; *puttin in the information for the binomial variable;
a = probbnml(p, n, x); *returns distribution of (X < or = to X);
b =a-lag(a); *returns distribution of (X=x); 
if x=0 then b=0; *Putting 0 as the probability of X=x when x=0; 
datalines;
0
1
2
3
4
5
;
run;

proc print;
var  x a b;
run;

data two; 
mu=12.6;
sigma=2.3; 
x=10;*putting the information in for the normal random vaqriable X;
z=(x-mu)/sigma; *Z score is the prob of X being within a range, 
                  and this is the calculation of a zscore;
aprob=probnorm(z);*Calculating the probability of a z score;
x2=15;
z2=(x2-mu)/sigma; *To calculate a Z score within a range, first calculate 
                   the max Z score;
x3=7.6;
z3=(x3-mu)/sigma; *Then calculate the min Z score;
bprob=probnorm(z2)-probnorm(z3);*The probabaility of the z score (in a range) is the 
                                 probability of the max z score minus the min 
                                 z score;
run;

proc print; 
run;

proc format;
value $sfmt "M" = "Male" "F" = "Female";
value lsfmt 1 = "Athletic" 2="Sedentary"; *Transforms the numeric input 
                                           variables into alphanumeric 
                                           characters;

run;
data athlete;

infile'H:\Apps\MinitabFiles\Morrell\ST710\Elliott\athlete.dat';
input sex $ 10 lifestyle 13 systolic 1-3 diastolic 6-7; 
label systolic= "Systolic Blood Pressure";
label diastolic= "Diastolic Blood Pressure"; 
format sex $sfmt.;
format lifestyle lsfmt.; *Using the formats to transform the variables; 
run;

proc sort;
by sex lifestyle;
run;

proc univariate plots; 
var diastolic;
by sex lifestyle; *Plotting Diastolic Blood Pressure by sex and lifestyle;
title "Diastolic Blood Pressure by Sex and Lifestyle"; 
run; 

proc univariate normal; 
var systolic; *Testing Normality Systolic Blood Pressure by the whole group;
histogram systolic / normal; 
title "Distribution of Systolic Blood Pressure for entire Group";
run;

proc format;
value mefmt 1="At most grade 7" 2="Grades 8 or 9" 
      3="Grades 10 or 11" 4="At least high school"; *Transforming numeric 
	                                          variables into alphanumeric;

run;
data btt; 
infile'H:\Apps\MinitabFiles\Morrell\ST710\Elliott\btt.dat';
input mothersed 29 socio 33 socio5 73; 
format mothersed mefmt.; 
run;

proc gchart;
vbar mothersed/ midpoints= 1 to 4 by 1;
title "Histogram of Mothers' Education";
run; *Creating a Histogram and changing the midpoints to match variables;

proc gchart;
hbar socio socio5/ midpoints= 1 to 4 by 1;
label socio= "Socioeconomic Status at Birth";
label socio5 "Socioeconomic Status at 5 Years";
title "Histogram of Socioeconomic Status at Birth and 5 Years.";
run;*Creating a Horizontal Histogram to show frequency and 
     other factors between the two variables; 
 









