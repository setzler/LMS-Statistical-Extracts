
setwd("~/github/LMS-Statistical-Extracts")
library(data.table)

Extract.LMS.Matches <- function(dataloc = "PrepareExtracts/data-raw", outputloc = "StatisticalExtracts", adjusted = TRUE){

  # get the (psi_j, theta_j, x_qj) by firm cluster
  # see also Table 2 of LMS
  if(adjusted){
    # download https://github.com/setzler/LMS/raw/main/4_StatisticalAnalyses/data/FE/blm_adjusted_naics2_cz_broadmarket.rds
    dd <- readRDS(sprintf("%s/blm_adjusted_naics2_cz_broadmarket.rds",dataloc))
  }
  if(!adjusted){
    # download https://github.com/setzler/LMS/raw/main/4_StatisticalAnalyses/data/FE/blm_unadjusted_naics2_cz_broadmarket.rds
    dd <- readRDS(sprintf("%s/blm_unadjusted_naics2_cz_broadmarket.rds",dataloc))
  }

  # the data is in "long" format, but we need it in "wide" format.
  psi_j <- dd$interactions[WorkerEffect == 1][variable == "FEnl"][, list(FirmCluster, psi_j = value)]
  theta_j <- dd$interactions[WorkerEffect == 1][variable == "gamma"][, list(FirmCluster, theta_j = value)]
  w_jq <- dd$interactions[variable == "y1"][, list(WorkerEffectQ, FirmCluster, w_jq = value)]
  dd2 <- merge(psi_j, theta_j, by = "FirmCluster")
  dd3 <- merge(dd2, w_jq, by = "FirmCluster")

  # we reconstruct x using the mean wage equation
  dd3[, x_jq := (w_jq - psi_j) / theta_j]
  
  # cluster sizes
  dd3 = merge(dd3, dd$cluster_sizes[,list(Size_FirmCluster=sum(size)),list(FirmCluster=cluster)], by="FirmCluster")
  
  # remove unnecessary information, use descriptive names
  dd3 <- dd3[, list(FirmCluster_k = FirmCluster, Size_FirmCluster_k = Size_FirmCluster, 
                    FirmPremium_psik = psi_j, SkillComplementarity_thetak = theta_j,
                    WorkerDecile_q = WorkerEffectQ, WorkerSkill_xq = x_jq, ExpectedLogWage_wkq = w_jq)]
  
  if(adjusted){
    write.csv(dd3,file=sprintf("%s/LMS-Firm-Worker-Matches.csv",outputloc), row.names=F)
  }
  if(!adjusted){
    write.csv(dd3,file=sprintf("%s/LMS-Firm-Worker-Matches_unadjusted.csv",outputloc), row.names=F)
  }

}


Extract.LMS.RegionalCharacteristics <- function(dataloc = "PrepareExtracts/data-raw", outputloc = "StatisticalExtracts"){

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
  
  dd2 = dd[, list(BroadMarket = broad_market, UnconditionalPassthrough = unc_pt, 
                  NetPassthrough = net_pt, MarketPassthrough = market_pt, 
                  Parameter_rho = rho, Parameter_beta = beta)]

  write.csv(dd2,file=sprintf("%s/LMS-Regional-Passthrough.csv",outputloc), row.names=F)
  
  dd3 = dd[, list(BroadMarket = broad_market, 
                  LaborShare = labor_share, Parameter_alpha = alpha,
                  ValueAdded = EVA_pc, Wagebill = EWB_pc,
                  WorkerRents_FirmLevel = Rw_firm, 
                  WorkerRents_MarketLevel = Rw_market,  
                  FirmRents_FirmLevel = Rf_firm, 
                  FirmRents_MarketLevel = Rf_market)]
  
  write.csv(dd3,file=sprintf("%s/LMS-Regional-Rents.csv",outputloc), row.names=F)
  
}


Extract.LMS.StayerDifferences <- function(dataloc = "PrepareExtracts/data-raw", outputloc = "StatisticalExtracts"){

  # get the DiD
  # see also Figure 1 of LMS
  # url <- "https://raw.githubusercontent.com/setzler/LMS/main/4_StatisticalAnalyses/data/params/LMS_DiD_naics2_cz.csv"
  # destfile <- "~/Downloads/LMS_DiD_naics2_cz.csv"
  # download.file(url = url, destfile = destfile)
  
  dd <- setDT(read.csv(sprintf("%s/LMS_DiD_naics2_cz.csv",dataloc)))
  
  dd = dd[, list(EventTime=event_time,
                 LogWageDiff_Unconditional = wages, LogVADiff_Unconditional = va,
                 LogWageDiff_FirmLevel = wagesnet, LogVADiff_FirmLevel = vanet,
                 LogWageDiff_MarketLevel = wagesmean, LogVADiff_MarketLevel = vamean)]

  write.csv(dd,file=sprintf("%s/LMS-Stayer-Differences.csv",outputloc), row.names=F)

}


Extract.LMS.Matches(dataloc = "PrepareExtracts/data-raw", outputloc = "StatisticalExtracts")
Extract.LMS.Matches(dataloc = "PrepareExtracts/data-raw", outputloc = "StatisticalExtracts", adjusted=FALSE)
Extract.LMS.RegionalCharacteristics(dataloc = "PrepareExtracts/data-raw", outputloc = "StatisticalExtracts")
Extract.LMS.StayerDifferences(dataloc = "PrepareExtracts/data-raw", outputloc = "StatisticalExtracts")
