function [existe_q,bornes_V_p,bornes_V_q_chapeau] = d_min(i_p,j_p,u_k,D,t,T)

%voisinage de p
[nb_lignes, nb_colonnes, nb_canaux]=size(u_k);
i_p_min=max(1,i_p-t);
i_p_max=min(nb_lignes,i_p+t);
j_p_min=max(1,j_p-t);
j_p_max=min(nb_colonnes, j_p+t);
bornes_V_p=[i_p_min i_p_max j_p_min j_p_max];
voisinage_p = u_k(i_p_min:i_p_max,j_p_min:j_p_max,:);

d_inf = Inf;
existe_q = false;

%fenetre de recherche
i_min=max(t+1,i_p-T+t);
i_max=min(nb_lignes-t,i_p+T-t);
j_min=max(t+1,j_p-T+t);
j_max=min(nb_colonnes-t, j_p+T-t);

masque=~repmat(D(i_p_min:i_p_max,j_p_min:j_p_max),[1,1,nb_canaux]);

%intersection fenetre de recherche et domaine de recherche

for i=i_min:i_max
    for j=j_min:j_max
        i_q_min=i-t;
        i_q_max=i+t;
        j_q_min=j-t;
        j_q_max=j+t;
        if max(D(i_q_min:i_q_max,j_q_min:j_q_max),[],'all')==0
            existe_q=true;
            voisinage_q = u_k(i_q_min:i_q_max,j_q_min:j_q_max,:).*masque;
            d = sum((voisinage_p-voisinage_q).^2, 'all');
            if d<d_inf
                d_inf=d;
                bornes_V_q_chapeau=[i_q_min i_q_max j_q_min j_q_max];
            end
        end
    end
end

