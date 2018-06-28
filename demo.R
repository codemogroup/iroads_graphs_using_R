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
plot_ly(time_movavg_acceY, x = ~time, y = ~movavg_acceY, type = "area")

vector_emovavg_acceY <- movavg(vector_acceY, 100, type=c("e"))
time_emovavg_acceY = data.frame(time = vector_time, emovavg_acceY = vector_emovavg_acceY)
plot_ly(time_emovavg_acceY, x = ~time, y = ~emovavg_acceY, type = "area")

vector_d_acceYd_Time1 <- diff(vector_acceY)/(diff(vector_time/1000))
vector_d_acceYd_Time <- append(0, vector_d_acceYd_Time1)
time_d_acceYd_Time = data.frame(time = vector_time, d_acceYd_Time = vector_d_acceYd_Time)
plot_ly(time_d_acceYd_Time, x = ~time, y = ~d_acceYd_Time, type = "area")

vector_d_acceY2d2_Time <- diff(vector_d_acceYd_Time1)/(diff(vector_time))
vector_d_acceY2d2_Time <- append(0, vector_d_acceY2d2_Time)
time_d_acceY2d2_Time = data.frame(time = vector_time, d_acceY2d2_Time = vector_d_acceY2d2_Time)
plot_ly(time_d_acceY2d2_Time, x = ~time, y = ~d_acceY2d2_Time, type = "area")

p1 <- plot_ly(time_d_acceYd_Time, x = ~time, y = ~d_acceYd_Time, type = "area") %>%
  add_lines(name = ~"1stderivative")
p2 <- plot_ly(time_accY, x = ~time, y = ~acceY, type = "area") %>%
  add_lines(name = ~"acceY")
p <- subplot(p1, p2)
p