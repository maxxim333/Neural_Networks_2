'''
The function used to calculate the SMOTE Percentage was 

(tag1-tag0)*100/tag0

Where tag1 is the majoritary class


'''

'''
Python script for that is
'''

'''
import re

def Smote(data_file):
        tag_0 = 0
        tag_1 = 1
        f = open(data_file,'r')
        for line in f:
                if line.startswith('@') or line == '\n' or line == '':
                        continue
                        #Now we want to elminate all the spaces, tabs... that weve in the line. We use {1,100} to
                        #specify the number of regular expressions that match from 1 to 100 repetitions:
                        #if the regular expression appears 1 time,2,3,...,100 times it will be changed by "" (eliminate)
                        #the character
                newline = re.sub("[ \t\r\n\f]{1,100}","",line)
                new = newline.split(',')
                if float(new[-1]) == 0:
                        tag_0 += 1
                elif float(new[-1]) == 1:
                        tag_1 += 1
        f.close()
        #We know the variables tag_1 and tag_0, which correspond to the number of pathogenic and neutral variants
        #present in the protein (arff file), respectively. We now must equalise the number of these variables in
        #order to obtain a better predictor (to increase predictors performance)
        if tag_0 == tag_1:
                smote = 0
        elif tag_1 > tag_0:
                rest = tag_1 - tag_0
                smote = float(rest) * 100 / float(tag_0)
        elif tag_0 > tag_1:
                rest = tag_0 - tag_1
                smote = float(rest) * 100 / float(tag_1)
        #We want a number with just one decimal value or more ,in order to do so, we use % to implement what we want in the
        #variable of interest
        print   "%.1f" % smote

Smote("/home/mvaskin/Desktop/maks/5mar/new_polymorphism_229.arff")
Smote("/home/mvaskin/Desktop/maks/6mar/new_attributes.arff")
'''
'''


'''
THIS IS ALL FOR HOMOLOGS

export CLASSPATH=$CLASSPATH:/home/mvaskin/Desktop/weka/weka-3-6-8/weka.jar


#mapfile -t my_array < <( bash -c 'echo $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM $RANDOM' )

mapfile -t my_array < <( bash -c 'echo $RANDOM $RANDOM $RANDOM' )

#Define paths
mkdir weka_output_individual
homologs_file=/home/mvaskin/Desktop/github/nn_individual/non_congruent_known_homologs.arff
orthologs_file=/home/mvaskin/Desktop/github/nn_individual/non_congruent_known_orthologs.arff
output_dir=/home/mvaskin/Desktop/github/nn_individual/weka_output_individual/


for i in $my_array; do

echo ·············ITERATION $i·················


#Previously I did  JAVA_OPTS="-Djava.util.Arrays.useLegacyMergeSort=true" beause it was giving me an error in SMOTE function

echo Currently Working on:
################### 0 Hidden Layers Neural Network ######################

### SIFT and POLYPHEN only ###
echo SIFT and POLYPHEN only Homologs 0 Hidden Layers NN
#Remove attributes and build rbf
java -Djava.util.Arrays.useLegacyMergeSort=true weka.classifiers.meta.FilteredClassifier -t ${homologs_file} -x 5 -s 1 -p 1,2 -distribution -F "weka.filters.MultiFilter -F \"weka.filters.unsupervised.attribute.Remove -R 1,2,3,4,5,6,7,8,9,10,13,14,15,16,17\"-F \"weka.filters.unsupervised.attribute.RemoveType -T string \" -F \"weka.filters.supervised.instance.SMOTE -C 0 -K 5 -P 328 -S 1 \"" -W weka.classifiers.functions.MultilayerPerceptron -- -L 0.3 -M 0.2 -N 500 -V 0 -S ${RANDOM} -E 20 -H 0 > ${output_dir}final_specific_homologs_siftpoly_ohl_rep${i}.rbf

#Build Model 0 hidden layers for homologs only with SIFT and PolyPhen predictors
java -Djava.util.Arrays.useLegacyMergeSort=true weka.classifiers.meta.FilteredClassifier -t ${homologs_file} -d ${output_dir}nn_0_homologs_siftpoly.model -F "weka.filters.MultiFilter -F \"weka.filters.unsupervised.attribute.Remove -R 1,2,3,4,5,6,7,8,9,10,13,14,15,16,17 \" -F \"weka.filters.unsupervised.attribute.RemoveType -T string \" -F \"weka.filters.supervised.instance.SMOTE -C 0 -K 5 -P 328 -S 1 \"" -W weka.classifiers.functions.MultilayerPerceptron -- -L 0.3 -M 0.2 -N 500 -V 0 -S ${RANDOM} -E 20 -H 0 > ${output_dir}nn_0_sift_poly_rep${i}.info


### SIFT, POLYPHEN, PSSMnat and Entropy ###
echo SIFT, POLYPHEN, PSSMnat and Entropy Homologs 0 Hidden Layers NN
#Remove attributes and build rbf
java -Djava.util.Arrays.useLegacyMergeSort=true weka.classifiers.meta.FilteredClassifier -t ${homologs_file} -x 5 -s 1 -p 1,2 -distribution -F "weka.filters.MultiFilter -F \"weka.filters.unsupervised.attribute.Remove -R 1,2,3,4,7,9,10,13,14,15,16,17\"-F \"weka.filters.unsupervised.attribute.RemoveType -T string \" -F \"weka.filters.supervised.instance.SMOTE -C 0 -K 5 -P 328 -S 1 \"" -W weka.classifiers.functions.MultilayerPerceptron -- -L 0.3 -M 0.2 -N 500 -V 0 -S ${RANDOM} -E 20 -H 0 > ${output_dir}final_specific_homologs_siftpoly_pssmnatentropy_ohl_rep${i}.rbf



################### 1 Hidden Layers, 2 nodes Neural Network ######################

### SIFT and POLYPHEN only ###
echo SIFT and POLYPHEN only Homologs 1 Hidden Layers NN
#Remove attributes and build rbf
java -Djava.util.Arrays.useLegacyMergeSort=true weka.classifiers.meta.FilteredClassifier -t ${homologs_file} -x 5 -s 1 -p 1,2 -distribution -F "weka.filters.MultiFilter -F \"weka.filters.unsupervised.attribute.Remove -R 1,2,3,4,5,6,7,8,9,10,13,14,15,16,17\"-F \"weka.filters.unsupervised.attribute.RemoveType -T string \" -F \"weka.filters.supervised.instance.SMOTE -C 0 -K 5 -P 328 -S 1 \"" -W weka.classifiers.functions.MultilayerPerceptron -- -L 0.3 -M 0.2 -N 500 -V 0 -S ${RANDOM} -E 20 -H 2 > ${output_dir}final_specific_homologs_siftpoly_2hl_rep${i}.rbf




### SIFT, POLYPHEN, PSSMnat and Entropy ###
echo SIFT, POLYPHEN, PSSMnat and Entropy Homologs 1 Hidden Layers NN
#Remove attributes and build rbf
java -Djava.util.Arrays.useLegacyMergeSort=true weka.classifiers.meta.FilteredClassifier -t ${homologs_file} -x 5 -s 1 -p 1,2 -distribution -F "weka.filters.MultiFilter -F \"weka.filters.unsupervised.attribute.Remove -R 1,2,3,4,7,9,10,13,14,15,16,17\"-F \"weka.filters.unsupervised.attribute.RemoveType -T string \" -F \"weka.filters.supervised.instance.SMOTE -C 0 -K 5 -P 328 -S 1 \"" -W weka.classifiers.functions.MultilayerPerceptron -- -L 0.3 -M 0.2 -N 500 -V 0 -S ${RANDOM} -E 20 -H 2 > ${output_dir}final_specific_homologs_siftpoly_pssmnatentropy_2hl_rep${i}.rbf





'''
THIS IS ALL FOR ORTHOLOGS

'''



### SIFT, POLYPHEN, PSSMnat and Entropy ###
echo SIFT POLYPHEN, PSSMnat and entropy Orthologs 0 Hidden Layers NN
#Remove attributes and build rbf
java -Djava.util.Arrays.useLegacyMergeSort=true weka.classifiers.meta.FilteredClassifier -t ${orthologs_file} -x 5 -s 1 -p 1,2 -distribution -F "weka.filters.MultiFilter -F \"weka.filters.unsupervised.attribute.Remove -R 1,2,3,4,7,9,10,13,14,15,16,17\"-F \"weka.filters.unsupervised.attribute.RemoveType -T string \" -F \"weka.filters.supervised.instance.SMOTE -C 0 -K 5 -P 328 -S 1 \"" -W weka.classifiers.functions.MultilayerPerceptron -- -L 0.3 -M 0.2 -N 500 -V 0 -S ${RANDOM} -E 20 -H 0 > ${output_dir}final_specific_orthologs_siftpoly_pssmnatentropy_ohl_rep${i}.rbf





### SIFT, POLYPHEN, PSSMnat and Entropy ###
echo SIFT POLYPHEN, PSSMnat and entropy Orthologs 1 Hidden Layers NN
#Remove attributes and build rbf
java -Djava.util.Arrays.useLegacyMergeSort=true weka.classifiers.meta.FilteredClassifier -t ${orthologs_file} -x 5 -s 1 -p 1,2 -distribution -F "weka.filters.MultiFilter -F \"weka.filters.unsupervised.attribute.Remove -R 1,2,3,4,7,9,10,13,14,15,16,17\"-F \"weka.filters.unsupervised.attribute.RemoveType -T string \" -F \"weka.filters.supervised.instance.SMOTE -C 0 -K 5 -P 328 -S 1 \"" -W weka.classifiers.functions.MultilayerPerceptron -- -L 0.3 -M 0.2 -N 500 -V 0 -S ${RANDOM} -E 20 -H 2 > ${output_dir}final_specific_orthologs_siftpoly_pssmnatentropy_2hl_rep${i}.rbf

echo ${i}>>seeds_used.txt ;done


###### Counting Sensitivities for each protein average #####
python performance_from_rbf_individualgenes.py > python_output.txt



echo sensitivity siftpoly_ohl averages>>individual_sensitivities.txt
while read p; do echo "$p">>individual_sensitivities.txt
grep -A 7 "$p" python_output.txt | awk '/homologs_siftpoly_ohl/{c=7} c-->0' | grep  "Sensitivity" | grep -o "[0-9]*.[0-9].*" | awk '{ total += $1; count++ } END { print total/count }' >>individual_sensitivities.txt
echo " ">>individual_sensitivities.txt;done <list_genes_more_than_19_pathogenic.txt 


echo sensitivity siftpoly_2hl averages>>individual_sensitivities.txt
while read p; do echo "$p">>individual_sensitivities.txt
grep -A 7 "$p" python_output.txt | awk '/homologs_siftpoly_2hl/{c=7} c-->0' | grep  "Sensitivity" | grep -o "[0-9]*.[0-9].*" | awk '{ total += $1; count++ } END { print total/count }' >>individual_sensitivities.txt
echo " ">>individual_sensitivities.txt;done <list_genes_more_than_19_pathogenic.txt 

echo sensitivity homologs_siftpoly_pssmnatentropy_ohl averages>>individual_sensitivities.txt
while read p; do echo "$p">>individual_sensitivities.txt
grep -A 7 "$p" python_output.txt | awk '/homologs_siftpoly_pssmnatentropy_ohl/{c=7} c-->0' | grep  "Sensitivity" | grep -o "[0-9]*.[0-9].*" | awk '{ total += $1; count++ } END { print total/count }'  >>individual_sensitivities.txt
echo " ">>individual_sensitivities.txt;done <list_genes_more_than_19_pathogenic.txt 

echo sensitivity homologs_siftpoly_pssmnatentropy_2hl averages>>individual_sensitivities.txt
while read p; do echo "$p">>individual_sensitivities.txt
grep -A 7 "$p" python_output.txt | awk '/homologs_siftpoly_pssmnatentropy_2hl/{c=7} c-->0' | grep  "Sensitivity" | grep -o "[0-9]*.[0-9].*" | awk '{ total += $1; count++ } END { print total/count }'  >>individual_sensitivities.txt
echo " ">>individual_sensitivities.txt;done <list_genes_more_than_19_pathogenic.txt 

echo sensitivity orthologs_siftpoly_pssmnatentropy_0hl averages>>individual_sensitivities.txt
while read p; do echo "$p">>individual_sensitivities.txt
grep -A 7 "$p" python_output.txt | awk '/orthologs_siftpoly_pssmnatentropy_ohl/{c=7} c-->0' | grep  "Sensitivity" | grep -o "[0-9]*.[0-9].*" | awk '{ total += $1; count++ } END { print total/count }'  >>individual_sensitivities.txt
echo " ">>individual_sensitivities.txt;done <list_genes_more_than_19_pathogenic.txt 

echo sensitivity orthologs_siftpoly_pssmnatentropy_2hl averages>>individual_sensitivities.txt
while read p; do echo "$p">>individual_sensitivities.txt
grep -A 7 "$p" python_output.txt | awk '/orthologs_siftpoly_pssmnatentropy_2hl/{c=7} c-->0' | grep  "Sensitivity" | grep -o "[0-9]*.[0-9].*" | awk '{ total += $1; count++ } END { print total/count }' >>individual_sensitivities.txt
echo " ">>individual_sensitivities.txt;done <list_genes_more_than_19_pathogenic.txt 


#Put them all in tabular format
split -l 106 individual_sensitivities.txt

#Change the names
for file in x*;do mv $file "$(head -1 $file)";done
 
#Now I delete the empty lines and put all in two columns
for file in sensitivity*; do head -1 $file >> "${file}"_withcolumns; cat "$file" |tail -n +2 | sed '/^[[:space:]]*$/d'|awk '{printf "%s%s",$0,(NR%2?FS:RS)}' >> "${file}"_withcolumns; done

#Delete spaces in filenames
find -name "* *" -type f | rename 's/ /_/g'



#Launch R
Rscript scatterplot_sensitivities.R 

#Show plots
xdg-open Rplots.pdf

