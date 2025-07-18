
setwd("D:/MY DATA/Works/CardiacRehab")
library(haven)
data <- read_sav("data3.sav")

data[,c(2:10,12:13,15:18)] <- as.data.frame(lapply(data[,c(2:10,12:13,15:18)],factor))
data[,22:128] <- as.data.frame(lapply(data[,22:128],function(var) factor(var,ordered=T)))

impvars <- data.frame(
  intention.item.1 = c('P3','WFT4','V1','WFT7','WFT1','q31eCC','LD1','WFT6','WFT3','WFT2'),
  intention.item.2 = c('WFT8','BE15','BE2','LD1','q31eCC','WFT6','WFT7','WFT1','WFT2','WFT3'),
  intention.item.3 = c('V1','LD4','WFT7','q31aCC','WFT6','q31eCC','WFT1','LD1','WFT3','WFT2'),
  intention.item.4 = c('q31fCC','LD8','height2','exercise','dischargediagnosed','BMI','WFT6','WFT1','WFT2','WFT3'),
  intention.item.5 = c('V1','MR3','Ethnicity','q34bPB','BE8','q31aCC','q31dCC','LD1','WFT3','WFT2'),
  intention.item.6 = c('BE11','q34dPB','LD2','LD4','q31eCC','q31aCC','MR5','q31dCC','LD1','WFT2'))
significantrows <- list()
allrows <- list()

source("fixedpolr.R")
library(MASS) # Though fixedpolr is used, other functions from MASS package are required
for (i in 1:6) {
  
  dat <- data[,c(which(names(data) %in% impvars[,i]),i+122)]
  
  formula_i <- as.formula(paste0(names(dat)[ncol(dat)]," ~ ."))
  olrfit <- fixedpolr(formula_i, dat, Hess=T)
  # print(summary(olrfit))
  
  coeffs <- coef(summary(olrfit))
  ci <- exp(confint(olrfit))
  p <- pnorm(abs(coeffs[,"t value"]), lower.tail = FALSE) * 2
  NAcells <- rep(NA,length(table(dat[,ncol(dat)]))-1)
  coeffs <- cbind(coeffs, 
                  "OR" = c(exp(coef(olrfit)),NAcells), 
                  "ci.low" = c(ci[,1],NAcells), "ci.up" = c(ci[,2],NAcells), "p.value" = round(p,3))
  coeffs <- as.data.frame(coeffs) 
  significantrows[[i]] <- coeffs[coeffs$p.value < 0.05,c("OR","ci.low","ci.up","p.value")]
  allrows[[i]] <- coeffs[,c("OR","ci.low","ci.up","p.value")]
  
}

# save.image("sessimg_cf1.RData")
