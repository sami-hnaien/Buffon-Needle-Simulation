# ==============================================================================
# Project: Estimating Pi using Buffon's Needle Simulation (Monte Carlo)
# Author: Sami Hnaien
# Course: Statistical Theory - University of Milan (UNIMI)
# ==============================================================================

set.seed(42)

# Function to run one simulation of M throws
buffon_pi <- function(M, l=1, d=2) {
  # Generate random angles and distances from the needle center to the line
  theta <- runif(M, 0, pi/2)   
  y     <- runif(M, 0, d/2)    
  
  # Condition: A needle crosses a line if Y <= (L/2) * sin(theta)
  crosses <- y <= (l/2) * sin(theta)
  
  # Calculate estimated probability (p) and Pi (pi_hat) 
  p <- mean(crosses)
  pi_hat <- ifelse(p > 0, (2*l)/(d*p), NA_real_)
  
  list(pi_hat=pi_hat, crosses=crosses)
}

# --- Main Simulation Parameters ---
l <- 1    # Needle length
d <- 2    # Distance between lines
M <- 20000

# Perform the simulation
theta <- runif(M, 0, pi/2)
y     <- runif(M, 0, d/2)
crosses <- y <= (l/2) * sin(theta)

# Cumulative estimation to see convergence
cum_p  <- cumsum(crosses) / (1:M)
cum_pi <- (2*l) / (d * cum_p)
cum_pi[cum_p == 0] <- NA   

# --- Visualisation 1: Convergence Plot ---
# Automatically find min/max to zoom the plot
ymin <- min(cum_pi, na.rm = TRUE)
ymax <- max(cum_pi, na.rm = TRUE)

plot(1:M, cum_pi, type="l", col="red", lwd=2,
     ylim=c(ymin, ymax), #Auto-zoom
     xlab="Number of throws (M)",
     ylab="Cumulative pi estimate",
     main="Buffon's Needle: Convergence toward Pi")
abline(h=pi, col="black", lty=2, lwd=2) # True Pi line
legend("bottomright", legend=c("My Estimate", "True Pi"), 
       col=c("red", "black"), lty=c(1, 2), lwd=2)

# --- Visualisation 2: Variability Analysis ---
Ms <- c(200, 1000, 5000)
reps <- 200
estimates <- lapply(Ms, function(m) replicate(reps, buffon_pi(m, l, d)$pi_hat))

hist(estimates[[1]], breaks=30, col=rgb(0,0,1,0.35), xlim=c(2, 4.5),
     xlab="Pi estimate", main="Variability Shrinks as M Increases")
hist(estimates[[2]], breaks=30, col=rgb(1,0.6,0.6,1), add=TRUE) # Pink (M=1000)
hist(estimates[[3]], breaks=30, col=rgb(0,0.6,0,0.35), add=TRUE) # Green (M=5000)
abline(v=pi, col="black", lty=2, lwd=2)
legend("topright",
       legend=paste0("M=", Ms),
       fill=c(rgb(0,0,1,0.35), rgb(1,0.6,0.6,1), rgb(0,0.6,0,0.35)),
       border=NA)

cat("Final pi estimate:", tail(na.omit(cum_pi), 1), "\n")

