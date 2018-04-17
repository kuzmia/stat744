library(igraph)

amat <- matrix(sample(0:1, 36, replace=TRUE), ncol=6) #creates random 6-by-6 adjacency matrix
g1 <- graph_from_adjacency_matrix(amat) #use adjacency matrix to generate graph

as_adjacency_matrix(g1) #displays sparse adjacency matrix

plot.igraph(g1) #plot network