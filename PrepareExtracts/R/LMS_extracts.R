
setwd("~/github/LMS-Statistical-Extracts")
library(data.table)

Extract.LMS.Matches <- function(dataloc = "PrepareExtracts/data-raw", outputloc = "StatisticalExtracts"){

  # get the (psi_j, theta_j, x_qj) by firm cluster
  # see also Table 3 of the Online Supplement
  # download https://github.com/setzler/LMS/raw/main/4_StatisticalAnalyses/data/FE/blm_adjusted_naics2_cz_broadmarket.rds
  dd <- readRDS(sprintf("%s/blm_adjusted_naics2_cz_broadmarket.rds",dataloc))

  # the data is in "long" format, but we need it in "wide" format.
  psi_j <- dd$interactions[WorkerEffect == 1][variable == "FEnl"][, list(FirmCluster, psi_j = value)]
  theta_j <- dd$interactions[WorkerEffect == 1][variable == "gamma"][, list(FirmCluster, theta_j = value)]
  w_jq <- dd$interactions[variable == "y1"][, list(WorkerEffectQ, FirmCluster, w_jq = value)]
  dd2 <- merge(psi_j, theta_j, by = "FirmCluster")
  dd3 <- merge(dd2, w_jq, by = "FirmCluster")

  # we reconstruct x using the mean wage equation
  dd3[, x_jq := (w_jq - psi_j) / theta_j]

  # remove unnecessary information, use descriptive names
  dd3 <- dd3[, list(FirmCluster_j = FirmCluster, WorkerEffectDecile_q = WorkerEffectQ, FirmEffect_psi_j = psi_j, SkillComplementarity_theta_j = theta_j, WorkerEffect_q = x_jq, ExpectedWage_q_j = w_jq)]

  write.csv(dd3,file=sprintf("%s/LMS-Firm-Worker-Matches.csv",outputloc), row.names=F)

}


Extract.LMS.RegionalStayers <- function(dataloc = "PrepareExtracts/data-raw", outputloc = "StatisticalExtracts"){

  # get the rho_r by broad market
  # see also Table A.7 of the AER appendix
  # url <- "https://raw.githubusercontent.com/setzler/LMS/main/4_StatisticalAnalyses/data/params/LMS_params_naics2_cz_broadmarket.csv"
  # destfile <- "~/Downloads/LMS_params_naics2_cz_broadmarket.csv"
  # download.file(url = url, destfile = destfile)
  # url <- "https://raw.githubusercontent.com/setzler/LMS/main/4_StatisticalAnalyses/data/params/LMS_params_naics2_cz_broadmarket_bootstraps.csv"
  # destfile <- "~/Downloads/LMS_params_naics2_cz_broadmarket_bootstraps.csv"
  # download.file(url = url, destfile = destfile)

  dd <- setDT(read.csv(sprintf("%s/LMS_params_naics2_cz_broadmarket.csv",dataloc)))
  dd <- dd[ma == "ma1"] # preferred MA(1) specification
  dd[, list(broad_market, rho_r = rho)]

  write.csv(dd,file=sprintf("%s/LMS-Stayer-Characteristics.csv",outputloc), row.names=F)

}

Extract.LMS.Matches(dataloc = "PrepareExtracts/data-raw", outputloc = "StatisticalExtracts")
Extract.LMS.RegionalStayers(dataloc = "PrepareExtracts/data-raw", outputloc = "StatisticalExtracts")
