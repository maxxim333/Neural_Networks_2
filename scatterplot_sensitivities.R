#Read tables
siftonly_0hl<-data.frame(read.table("sensitivity_siftpoly_ohl_averages_withcolumns", header =FALSE))
siftonly_2hl<-read.table("sensitivity_siftpoly_2hl_averages_withcolumns", header =FALSE)
homologs_params_0hl<-read.table("sensitivity_homologs_siftpoly_pssmnatentropy_ohl_averages_withcolumns", header =FALSE)
homologs_params_2hl<-read.table("sensitivity_homologs_siftpoly_pssmnatentropy_2hl_averages_withcolumns", header =FALSE)
orthologs_params_0hl<-read.table("sensitivity_orthologs_siftpoly_pssmnatentropy_0hl_averages_withcolumns", header =FALSE)
orthologs_params_2hl<-read.table("sensitivity_orthologs_siftpoly_pssmnatentropy_2hl_averages_withcolumns", header =FALSE)



#######Plots############
#Only predictors VS Homologs PSSMnat, entropy, BLOSSUM62
par(mfrow=c(2,2))
plot1<-plot(siftonly_0hl$V2, homologs_params_0hl$V2, main="Sensitivity of SIFT only VS SIFT + Homologs Parameters for NN with 0 hidden layers", 
            xlab="SIFT only",ylab="SIFT/PoplyPhen + Homologs", pch=19, ylim=c(0,1), xlim=c(0.2,0.9))
text(siftonly_0hl$V2, homologs_params_0hl$V2, labels=homologs_params_0hl$V1, cex= 0.6, pos=1)
lines(x = c(0,100), y = c(0,100))

plot1<-plot(siftonly_2hl$V2, homologs_params_2hl$V2, main="Sensitivity of SIFT/PolyPhen only VS SIFT/PolyPhen + Homologs Parameters for NN with 2 hidden layers", 
            xlab="SIFT only",ylab="SIFT/PoplyPhen + Homologs", pch=19, ylim=c(0,1), xlim=c(0.2,0.9))
text(siftonly_2hl$V2, homologs_params_2hl$V2, labels=homologs_params_0hl$V1, cex= 0.6, pos=1)
lines(x = c(0,100), y = c(0,100))



#Only predictors VS SIFT/PolyPhen + Orthologs PSSMnat, entropy, BLOSSUM62
plot1<-plot(siftonly_0hl$V2, orthologs_params_0hl$V2, main="Sensitivity of SIFT only VS SIFT + Orthologs Parameters for NN with 0 hidden layers", 
            xlab="SIFT/PoplyPhen only",ylab="SIFT/PoplyPhen + Orthologs", pch=19, ylim=c(0,1), xlim=c(0.2,0.9))
text(siftonly_0hl$V2, orthologs_params_0hl$V2, labels=homologs_params_0hl$V1, cex= 0.6, pos=1)
lines(x = c(0,100), y = c(0,100))

plot1<-plot(siftonly_2hl$V2, orthologs_params_2hl$V2, main="Sensitivity of SIFT/PolyPhen only VS SIFT/PolyPhen + Orthologs Parameters for NN with 2 hidden layers", 
            xlab="SIFT/PoplyPhen only",ylab="SIFT/PoplyPhen + Orthologs", pch=19, ylim=c(0,1), xlim=c(0.2,0.9))
text(siftonly_2hl$V2, orthologs_params_2hl$V2, labels=homologs_params_0hl$V1, cex= 0.6, pos=1)
lines(x = c(0,100), y = c(0,100))





#Orthologs VS Homologs
par(mfrow=c(1,2))
plot1<-plot(homologs_params_0hl$V2, orthologs_params_0hl$V2, main="Sensitivity of Orthologs VS Homologs for NN with 0 hidden layers", 
            xlab="Homologs",ylab="Orthologs", pch=19, ylim=c(0,1), xlim=c(0.2,1))
text(homologs_params_0hl$V2, orthologs_params_0hl$V2, labels=homologs_params_0hl$V1, cex= 0.7, pos=1)
lines(x = c(0,100), y = c(0,100))


plot1<-plot(homologs_params_2hl$V2, orthologs_params_2hl$V2, main="Sensitivity of Orthologs VS Homologs for NN with 2 hidden layers", 
            xlab="Homologs",ylab="Orthologs", pch=19, ylim=c(0,1), xlim=c(0,1))
text(homologs_params_2hl$V2, orthologs_params_2hl$V2, labels=homologs_params_2hl$V1, cex= 0.7, pos=1)
lines(x = c(0,100), y = c(0,100))

