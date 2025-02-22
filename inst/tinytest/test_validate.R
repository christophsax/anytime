
library(anytime)

isWindows <- Sys.info()[["sysname"]] == "Windows"
isRelease <- length(unclass(packageVersion("anytime"))[[1]]) == 3

if (!isWindows && !isRelease) {

    oldtz <- Sys.getenv("TZ")

    input <- "2016-09-01 10:11:12"

    tz <- "America/Chicago"
    anytime:::setTZ(tz)
    Sys.setenv("TZ"=tz)
    expect_equivalent(as.POSIXct(input, tz=tz), anytime(input, tz=tz))
    expect_equivalent(anytime(input, tz=tz), as.POSIXct(input, tz=tz))

    tz <- "Europe/Berlin"
    anytime:::setTZ(tz)
    Sys.setenv("TZ"=tz)
    expect_equivalent(as.POSIXct(input, tz=tz), anytime(input, tz=tz))
    expect_equivalent(anytime(input, tz=tz), as.POSIXct(input, tz=tz))

    tz <- "Japan"
    anytime:::setTZ(tz)
    Sys.setenv("TZ"=tz)
    expect_equivalent(as.POSIXct(input, tz=tz), anytime(input, tz=tz))
    expect_equivalent(anytime(input, tz=tz), as.POSIXct(input, tz=tz))

    ## when using UTC parse, and output format, we can we assurred
    ## a fixed result nomatter where this runs
    Sys.setenv("TZ"="UTC")
    anytime:::setTZ("UTC")
    output <- expect_equivalent(utctime(input), as.POSIXct(input))

    Sys.setenv("TZ"=oldtz)
}
