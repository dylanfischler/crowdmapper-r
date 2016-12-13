point_data <- read.csv("~/Documents/projects/crowdmapper/crowdmapper-clustering/clusters-csv")
# str(point_data)
# point_data$cluster <- factor(point_data$cluster)
# str(point_data)
# for ( i in levels(point_data) ) { print(i) }

f_point_data <- read.csv("~/Documents/projects/crowdmapper/crowdmapper-clustering/clusters-csv")
f_point_data$cluster <- factor(point_data$cluster)
for ( i in levels(f_point_data) ) { print(i) }

# grouping...
Groups<-levels(factor(f_point_data[[3]]))


fileConn<-file("~/Documents/projects/crowdmapper/crowdmapper-r/curves.csv")
writeLines(c("lat,long,cluster"), fileConn)

pointsFrame <- data.frame()

for( i in Groups) {
  if(i != 0) {
    cluster <- as.matrix(subset(point_data, cluster == i))
    
    try ({
      curve <- principal.curve(cluster, start=NULL, thresh=0.001, plot.true=FALSE, maxit=10, stretch=2, smoother="smooth.spline", trace=FALSE)
      print(curve$s)
      print("finished:")
      print(i)
      
      pointsFrame <- rbind(pointsFrame, data.frame(curve$s))
    })
    
    
    #pointsMatrix <- cbind(pointsMatrix, curve$s)
    
    # write.table(curve$s, fileConn, sep = ",")
    # write.table(curve$s, file = fileConn, sep = ',')
  }
}

write.csv(pointsFrame, fileConn)

close(fileConn)

# point_data[,c(1,2)]

#cluster13 <- as.matrix(subset(point_data, cluster == "13"))
#curve13 <- principal.curve(cluster13, start=NULL, thresh=0.001, plot.true=FALSE, maxit=10, stretch=2, smoother="smooth.spline", trace=FALSE)
#cluster3 <- as.matrix(subset(point_data, cluster == "3"))
#curve3 <- principal.curve(cluster3, start=NULL, thresh=0.001, plot.true=FALSE, maxit=10, stretch=10, smoother="smooth.spline", trace=FALSE)
# points(curve3, col='blue')
# lines(curve3, col='red')
#cluster14 <- as.matrix(subset(point_data, cluster == "14"))
#curve14 <- principal.curve(cluster14, start=NULL, thresh=0.001, plot.true=FALSE, maxit=10, stretch=10, smoother="smooth.spline", trace=FALSE)
