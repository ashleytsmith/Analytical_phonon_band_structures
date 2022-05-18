function D=rotations(Din,t)
rot1=[cos(t),-sin(t);sin(t),cos(t)];
rot2=[cos(t),sin(t);-sin(t),cos(t)];
D=rot1*Din*rot2;