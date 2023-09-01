function [u_nouv,D_nouv] = rapiecage(bornes_V_p,bornes_V_q_chapeau,u_k,D)

	% Bornes du voisinage de p
	i_p_min = bornes_V_p(1);
	i_p_max = bornes_V_p(2);
	j_p_min = bornes_V_p(3);
	j_p_max = bornes_V_p(4);

	% Bornes du voisinage de q_chapeau
	i_q_min = bornes_V_q_chapeau(1);
	i_q_max = bornes_V_q_chapeau(2);
	j_q_min = bornes_V_q_chapeau(3);
	j_q_max = bornes_V_q_chapeau(4);

	% Mise à jour du domaine à restaurer
	D_nouv = D;
	D_nouv(i_p_min:i_p_max,j_p_min:j_p_max) = 0;

	% Mise à jour de l'image

	% Voisinage de p
	V_p = D(i_p_min:i_p_max,j_p_min:j_p_max);
	% On récupère la partie de l'image correspondante
	u_p = repmat(V_p,[1,1,size(u_k,3)]).*u_k(i_q_min:i_q_max,j_q_min:j_q_max,:);

	% On remplace le voisinage de p par le voisinage de q_chapeau
	u_nouv = u_k;
	u_nouv(i_p_min:i_p_max,j_p_min:j_p_max,:) = u_k(i_p_min:i_p_max,j_p_min:j_p_max,:) + u_p;

end