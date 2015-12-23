myapp = oauth_app("Appl",
                  key="yourConsumerKeyHere",secret="yourConsumerSecretHere")
sig = sign_oauth1.0(myapp,
                    token = "yourTokenHere",
                    token_secret = "yourTokenSecretHere")
homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv "
download.file(fileUrl, destfile = "./data/cameras.csv", method = "curl")
list.files("./data")


fileName <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
con1 <- unz(fileName, filename="f_project.dat", open = "r")

temp <- tempfile()
a1<-download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",temp)
data <- read.table(unz(temp, "a1.dat"))
unlink(temp)
a<-unzip("C:\Users\advortso\AppData\Local\Temp\Rtmpa0PyRJ\file144c4cb82612:a1.dat")
download(fileName, dest="dataset.zip", mode="wb") 
unzip(temp, "body_acc_x_test.txt")

setwd(paste(path,"/tmpdir",sep="")) # change directory to where the
> temporary files are
> do.call(file.remove,list(list.files(pattern="temp*)))
                                      > setwd(path)