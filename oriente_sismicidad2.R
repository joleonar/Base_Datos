# Script para representar histogramas in R
# > getwd()
# > setwd("/home/lalvarado/Sismologia_R")
# > source(oriente_sismicidad2.R) 

library(ssBase)
library(ssEDA)
library(mapdata)

library(maps)

jpeg()

# Lee datos del archivo oriente_2.txt (Creado a partir de orientecorr_zmap.txt)
# en este archivo la longitud va de 0 a 360 por lo que sumo 360 a la columna de longitud original.
base<-scan("oriente_2.txt",sep="",what=list(longitude=0,latitude=0,year=0,month=0,day=0,magnitude=0,depth=0,hour=0,minute=0,seconds=0))
names(base)
# Crea un catalogo temporal Oriente 
as.catalogue(base, catname="Oriente")

resu <- summary(Oriente)
print(resu)

# Extrae los sismos con magnitud mayor a 0.5
a <- subsetrect(Oriente,minmag=0.5)

# Mapa de epicentros
# epicentres(a,criteria=FALSE,magnitude=c(3,4,5,6,7),cex=c(0.5,1,2,3),usr=c(292,300,6,12))
# epicentres(a,criteria=FALSE,depth=c(0,40,70,Inf),cex=c(0.5,1,2,3),usr=c(292,300,6,12))
# title(main="Sismicidad zona Oriental",cex.main=1, font.main=1)
# text(x=294,y=11.5, labels="Mar Caribe", adj=c(0,1), font.main=1)

# Grafico de eventos en profundidad
#rotation(a,theta=90,ylim=c(-300,0),km=FALSE) # theta degrees of the direction viewing from north positive to west
				     # for example theta=0 is viewing to the north (corte a lo largo de la longitud)	
			      	     # and for ‘theta=-45’ one would be viewing towards the NE.
#title(main="Sismicidad zona Oriental en profundidad",cex.main=1, font.main=1)

# Distribucion en profundidad
#par(mfrow=c(2,1))
#b <- subsetrect(Oriente,minmag=2.5,mindepth=0,maxdepth=40)
#depth.hist(b)
#title(main="Distribucion en profundidad sismos superficiales",cex.main=1, font.main=1)

#b <- subsetrect(Oriente,minmag=1.0,mindepth=40.1,maxdepth=450)
#depth.hist(b)
#title(main="Distribucion en profundidad sismos profundos",cex.main=1, font.main=1)

# Si se requiere mas control sobre el histograma
#b <- subsetrect(Oriente,minmag=1.0,mindepth=0,maxdepth=40)
#as.catalogue(b,catname="temp")
#hist(temp$depth,main="Distribucion en profundidad sismos superficiales",xlab="Profundidad", ylab="Frequencia",breaks=seq(0,40,1))

#b <- subsetrect(Oriente,minmag=1.0,mindepth=40.1,maxdepth=420)
#as.catalogue(b,catname="temp")
#hist(temp$depth,main="Distribucion en profundidad sismos profundos",xlab="Profundidad", ylab="Frequencia",breaks=seq(40,420,10))

# Distribucion magnitud-frecuencia
#bvalue <- freq.magnitude(b,delta=0.1)
#print(bvalue)

# Series de tiempo conteo de los eventos
#b <- subsetrect(Oriente,minmag=4.0,mindepth=0,maxdepth=420)
#timeplot(b)
#title(main=expression(paste("Eventos en catalogo con ML >=4")))
# Crea un nuevo catalogo 
#as.catalogue(a, catname="Oriente1")



# Magnitude-time scatter plot
b <- subsetrect(Oriente,minmag=0.5,minday=julian(1,1,1960))
as.catalogue(b,catname="Oriente1")
plot(Oriente1$time/365+1975, Oriente1$magnitude, pch='.', cex=2.0, main="Incompleto", xlab="Year", ylab="Magnitud")


#b <- hist(Oriente$mag, breaks=seq(0,7.5,0.1),plot=FALSE)

# Plot the linear frequency histogram
#par(mfrow=c(2,1))
#plot(b, freq=TRUE,main="",xlab="Magnitud",ylab="Frecuencia", cex.lab=0.7,cex.axis=0.6)

# Find positive frequencies
#n <- which(b$counts>0)

# Take the log of the positive frequencies and replot
#b$counts[n] <- log10(b$counts[n])
#plot(b,freq=TRUE, main="",xlab="Magnitud",ylab="log10(Frecuencia)", cex.lab=0.7,cex.axis=0.6)
#timeplot(a)
#epicentres(a,criteria=FALSE,magnitude=c(2,3,5,6,7),cex=c(20,30,40,50),usr=c(360-72,360-60,8,15))
dev.off()

