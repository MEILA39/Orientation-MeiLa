function sigma = compute_stress(Q, E, L, s, c, node1, node2)
    sigma = E/L*[-c -s c s]*[Q(2*node1-1,1); Q(2*node1,1); Q(2*node2-1,1); Q(2*node2,1)];
end