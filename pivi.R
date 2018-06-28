library("rjson")
json_file <- "logpivi_tida_pinidiya1.json"
json_data <- fromJSON(file=json_file)
vector_acceX <- numeric()
vector_acceY <- numeric()
vector_acceZ <- numeric()
vector_acceX_raw <- numeric()
vector_acceY_raw <- numeric()
vector_acceZ_raw <- numeric()
vector_time <- numeric()
vector_gpsSpeed <- numeric()
vector_lat <- numeric()
vector_lon <- numeric()

for (item in json_data){
  vector_acceX <- c(vector_acceX, item$acceX)
  #vector_acceY <- head(c(vector_acceY, item$acceY), 100)
  vector_acceY <- c(vector_acceY, item$acceY)
  vector_acceZ <- c(vector_acceZ, item$acceZ)
  vector_acceX_raw <- c(vector_acceX_raw, item$acceX_raw)
  vector_acceY_raw <- c(vector_acceY_raw, item$acceY_raw)
  vector_acceZ_raw <- c(vector_acceZ_raw, item$acceZ_raw)
  #vector_time <- head(c(vector_time, item$time), 100)
  vector_time <- c(vector_time, item$time)
  vector_gpsSpeed <- c(vector_gpsSpeed, item$gpsSpeed)
  vector_lat <- c(vector_lat, item$lat)
  vector_lon <- c(vector_lon, item$lon)
}

library("ggplot2")

time_accY = data.frame(time = vector_time, acceY = vector_acceY)
theme_set(theme_classic())

library(plotly)

p <- plot_ly(time_accY, x = ~time, y = ~acceY, type = "area")
p

library("pracma")

vector_movavg_acceY <- movavg(vector_acceY, 100, type=c("s"))
time_movavg_acceY = data.frame(time = vector_time, movavg_acceY = vector_movavg_acceY)