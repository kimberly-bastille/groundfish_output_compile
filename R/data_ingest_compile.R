#### Ingest and compile files from googledrive

#read in google sheets 
library(magrittr)
library(googlesheets4)
library(googledrive)

#If you have trouble getting access, use the following code and select 0 to get a new token - make sure to check the third box:
#gs4_auth()
print("start_ingest")
dat_list <- googledrive::drive_ls("shiny_output_data")
print("list of shiny out")
print(dat_list)

dat_all<- data.frame()
for(i in 1:row(dat_list)){
  dat = googlesheets4::range_read(paste0("https://docs.google.com/spreadsheets/d/",dat_list[2]), col_names = FALSE)
  dat <- dat %>% dplyr::mutate(run_opt = i)
  dat_all<- dat_all %>% rbind(dat)
  write.csv(dat_all, file = paste0(here::here("shiny_output_compile.csv")))
}


