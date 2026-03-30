# Buffon's Needle simulation (Monte Carlo) to estimate pi

set.seed(42)

try({
  this_file <- rstudioapi::getActiveDocumentContext()$path
  if (nzchar(this_file)) setwd(dirname(this_file))
}, silent = TRUE)

buffon_pi <- function(M, l=1, d=2) {
  theta <- runif(M, 0, pi/2)   # angle
  y     <- runif(M, 0, d/2)    # distance from center to nearest line
  crosses <- y <= (l/2) * sin(theta)
  p <- mean(crosses)
  pi_hat <- ifelse(p > 0, (2*l)/(d*p), NA_real_)
  list(pi_hat=pi_hat, crosses=crosses)
}

# Parameters
l <- 1
d <- 2
M <- 20000

theta <- runif(M, 0, pi/2)
y     <- runif(M, 0, d/2)
crosses <- y <= (l/2) * sin(theta)

cum_p  <- cumsum(crosses) / (1:M)
cum_pi <- (2*l) / (d * cum_p)
cum_pi[cum_p == 0] <- NA   

final_est <- tail(na.omit(cum_pi), 1)
cat("Final pi estimate (last non-NA):", final_est, "\n")
cat("Output folder:", getwd(), "\n")


png("cumulative_pi.png", width=1600, height=800, res=200)
plot(1:M, cum_pi, type="l",
     xlab="Number of throws (M)",
     ylab="Cumulative pi estimate",
     main="Buffon's needle: cumulative estimate approaches pi")
abline(h=pi, lty=2)
dev.off()

plot(1:M, cum_pi, type="l",
     xlab="Number of throws (M)",
     ylab="Cumulative pi estimate",
     main="Buffon's needle: cumulative estimate approaches pi")
abline(h=pi, lty=2)

#  Repeated simulations (variability)
Ms <- c(200, 1000, 5000)
reps <- 200

estimates <- lapply(Ms, function(m) replicate(reps, buffon_pi(m, l, d)$pi_hat))


png("estimate_histograms.png", width=1600, height=800, res=200)
hist(estimates[[1]], breaks=30, col=rgb(0,0,1,0.35),
     xlab="pi estimate", main="Variability shrinks with more throws")
hist(estimates[[2]], breaks=30, col=rgb(1,0,0,0.35), add=TRUE)
hist(estimates[[3]], breaks=30, col=rgb(0,0.6,0,0.35), add=TRUE)
abline(v=pi, lty=2)
legend("topright",
       legend=paste0("M=", Ms),
       fill=c(rgb(0,0,1,0.35), rgb(1,0,0,0.35), rgb(0,0.6,0,0.35)),
       border=NA)
dev.off()


hist(estimates[[1]], breaks=30, col=rgb(0,0,1,0.35),
     xlab="pi estimate", main="Variability shrinks with more throws")
hist(estimates[[2]], breaks=30, col=rgb(1,0,0,0.35), add=TRUE)
hist(estimates[[3]], breaks=30, col=rgb(0,0.6,0,0.35), add=TRUE)
abline(v=pi, lty=2)
legend("topright",
       legend=paste0("M=", Ms),
       fill=c(rgb(0,0,1,0.35), rgb(1,0,0,0.35), rgb(0,0.6,0,0.35)),
       border=NA)


