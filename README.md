# Neural_Networks_2
This is a work similar to the in maxxim333/Neural_Networks repository. This time, after cross-validation and creation of .rbf files, "sensitivity" parameter is calculated INDIVIDUALLY for each gene from a custom list of genes. This is done for both datasets and then a scatter plot is made to compare performance of each gene in each of the datasets.

## Usage: 
The only things that needs to be changed are the input and output files directories and WEKA directory. Everything else is done automatically.

Rscript needs to be installed for running R script from within shell

R version 3.4.4

## Data:
This is a real data of polymorphisms and some of their conservation and biochemical properties. The names of the proteins and the polymorphisms were masked by indexes (2nd and 1st columns, respectively) and random noise was added to each of the columns.

## Goal:
Neural Networks will eliminate most of the columns. Each of two files has a common SubstitutionMatrix, SIFT and PolyPhen DIV columns (at least originally, before addition of noise). Columns called "entropy" and "pssm native" are different and come from computation of conservation patterns in homologous or orthologous sequences (non_congruent_known_homologs.arff and non_congruent_known_orthologs.arff, respectively). Both file contain "tag" column in which "1" corresponds to "Pathogenic Mutation" label and "0" to "Neutral Mutation"

The goal is to see for which gene the usage conservation information based on orthologs will yield a pathogenicity predictor with higher sensitivity than using information based on homologs. In each iteration, NN are training using the following conditions:
1. Only SIFT and PolyPhen DIV columns
2. SIFT, PolyPhen DIV, substitutionmatrix,  entropy and pssm-native based on homologs sequences
3. SIFT, PolyPhen DIV, substitutionmatrix,  entropy and pssm-native based on orthologues sequences
(1-3 are repeated using NN with 0 hidden layers and 1 hidden layer and 2 nodes)

After that, Sensitivity parameter, defined by (True_Positives/Total_Positives) is calculated for each gene individually for each condition of each dataset. Scatter plots comparing conditions 1 VS 2, 1 VS 3 and 2 VS 3 are outputted. Each of the plots has a diagonal line (x=y). All the genes above this line have a greater sensitivity if using orthologs dataset instead of homologs and vice-versa. 

## Methods:
Training with only values of SIFT and PolyPhen (well-known pathogenicity predictors) is established as baseline. If next predictors will have lower performance than this one, the predictors are worthless, as they are less useful than just using the values of currently known predictors.

Because there are >3x more pathogenic variants than neutral ones, SMOTE is performed during training and neutral variants are oversampled. The exact way the SMOTE is performed is described in commented-out section in the beginning of the script.

This script doesn't include test phase, only training and 5-fold cross-validation. The performance is assessed directly from .rbf files generated during cross-validation, by calculating true and postitives/negatives from which (in the python script) sensitivities are computed for each neural network condition and for each dataset and gene. Because there are 100 of these values for each condition, average of each performance value is outputed. The reason the performance is calculated directly from .rbf instead of the usual training/test partition is because the dataset is too small and dividing it would reduce the training dataset even more. I didn't have an "outside" data to test my model so this is the reason the "Build Model" step was also skipped.
