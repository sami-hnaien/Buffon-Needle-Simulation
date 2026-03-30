\# Buffon's Needle: Estimating Pi using Monte Carlo



\*\*Author:\*\* Sami HNAIEN  

\*\*Course:\*\* Statistical Theory - University of Milan (UNIMI)



\[cite\_start]This project explores the \*\*Buffon's Needle problem\*\*, a classic probability experiment used to estimate the value of $\\pi$ through simulation\[cite: 1, 15].



\## 📌 Objective

\[cite\_start]The goal is to demonstrate the \*\*Law of Large Numbers\*\* by simulating the drop of a needle on a floor with parallel lines and observing how the estimate stabilizes over time \[cite: 27-28, 90].



\## 📂 Project Structure

Knowing the organization of the files is essential for reproducibility:



.

├── code

│   └── buffon\_simulation.R      # Main simulation script (R)

├── docs

│   └── presentation.pdf         # Project presentation - Score: 8.5/10

└── plots

&#x20;   ├── cumulative\_pi.png        # Convergence plot (Red line)

&#x20;   └── estimate\_histograms.png  # Variance \& Sampling distribution



\---



\## 🧮 Methodology

\- \[cite\_start]\*\*Trials (M)\*\*: 20,000 repetitions\[cite: 25].

\- \[cite\_start]\*\*Formula\*\*: $\\pi \\approx \\frac{2L}{dP}$\[cite: 21, 53].

\- \[cite\_start]\*\*Crossing Condition\*\*: A "hit" is recorded if $Y \\leq \\frac{L}{2} \\sin(\\theta)$\[cite: 42].



\## 📊 Visualizations



\### 1. Convergence toward $\\pi$

The red line shows the cumulative estimate of $\\pi$. \[cite\_start]As the number of trials ($M$) increases, the estimate converges and stabilizes around the real value of 3.14159 \[cite: 57-64].



!\[Convergence](plots/cumulative\_pi.png)



\### 2. Variability Analysis

These histograms compare different sample sizes. \[cite\_start]As $M$ grows (from Blue to Green), the distribution becomes narrower, showing that larger samples significantly reduce estimation error \[cite: 72-86].



!\[Variability](plots/estimate\_histograms.png)



\## 💻 Tech Stack

\- \*\*Language\*\*: R

\- \*\*Libraries\*\*: Base R (stats \& graphics)

\- \[cite\_start]\*\*Concepts\*\*: Monte Carlo Methods, Geometric Probability, Law of Large Numbers\[cite: 23, 27].



\---

\*\*Contact:\*\* \[samihnaien57@gmail.com]

