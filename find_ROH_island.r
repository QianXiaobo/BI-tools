#function for the proportion of individuals in a ROHi
roh_island <- function(pop,chr,p1,p2){
	names(pop) <- tolower(names(pop))
	a <- pop[pop$chr==chr,]
	island <- subset(a,pos1<=p1 & pos2>=p2)
	n <- length(unique(island$iid))/length(unique(pop$iid))
	return(n)
}

#function to obtain later the poisson test
possion.roh_island <- function(pop,chr,p1,p2){
	names(pop) <- tolower(names(pop))
	a <- pop[pop$chr==chr,]
	island <- subset(a,pos1<=p1 & pos2>=p2)
	n <- length(unique(island$iid))
	return(n)
}

#function to return binom.test pvalue
pvalue <- function(x, n, p=0.5, alter='greater'){
	a <- binom.test(x, n, p, alternative=alter)
	return(a$p.value)
}

args <- commandArgs(T)
window_file <- args[1]
ROH_file <- args[2]
n <- as.numeric(args[3])

dat_window <- read.table(window_file, header=F)
colnames(dat_window) <- c('CHR', 'POS1', 'POS2')
dat_ROH <- read.table(ROH_file, header=T)

data.n <- apply(dat_window, 1, function(x) possion.roh_island(dat_ROH, x[1], x[2], x[3]))
data.p <- apply(dat_window, 1, function(x) roh_island(dat_ROH, x[1], x[2], x[3]))
data.pvalue <- sapply(data.n, function(x) pvalue(x, n))
data.pvalue <- data.frame(data.pvalue=data.pvalue)
dat_window <- cbind(dat_window, data.n, data.p, data.pvalue)
write.table(dat_window, file='test.ROHi.txt', col.names=T, row.names=F, quote=F)
