function pop_rank = non_dom_sort(pop_vec, f_vec)
%% ”ñ—D‰zƒ\[ƒgƒvƒƒOƒ‰ƒ€ (f_vec‚Ìs‚ªŒÂ‘Ì”Ô†C—ñ‚ª•]‰¿ŠÖ”ƒxƒNƒgƒ‹’l)

f_vec_NUM = size(f_vec, 2); % •]‰¿ŠÖ”f_i(x)‚Ì¬•ª‚Ì”
POP_NUM = size(f_vec, 1); %% ŒÂ‘Ì”[-]


%% ŒÂ‘Ìi,j‚Ì”äŠr‚Ì€”õ
% ŒÂ‘Ìi
F_vec_1 = permute(f_vec, [3 1 2]);
F_vec_1 = repmat(F_vec_1, [POP_NUM 1 1]);
% ŒÂ‘Ìj
F_vec_2 = permute(f_vec, [1 3 2]);
F_vec_2 = repmat(F_vec_2, [1 POP_NUM 1]);


%% ”ñ—D‰z”äŠr ( f_k(x_i) - f_k(x_j) )
ir = 1;
pop_front=1;
pop_index = 1:POP_NUM;% ŒÂ‘Ì”Ô†”z—ñ

while pop_front
    
    F_vec = F_vec_1 - F_vec_2;
    non_dominant_pop = uint8((sign(F_vec)+1)/2); % ”ñ—D‰zŠÖŒWF1‚È‚çŒÂ‘Ìi‚É‘Î‚µ‚Ä—D‰z‚·‚é‰ğ‚ª‘¶İ‚µ‚Ä‚¢‚éD
    non_dominant_pop = sum(non_dominant_pop,3);
    non_dominant_pop = non_dominant_pop - diag(diag(non_dominant_pop));% ‘ÎŠp¬•ª0‰»
    non_dominant_pop(non_dominant_pop < f_vec_NUM) = 0;% ‘S‚Ä‚Ì•]‰¿ŠÖ”f_k‚Å‚æ‚è—DG‚È‰ğ‚ª‘¶İ‚µ‚Ä‚¢‚é‚©‚Ç‚¤‚©D
    non_dominant_num = sum(non_dominant_pop, 1)/f_vec_NUM; % ŒÂ‘Ìi‚É‘Î‚·‚é—D‰z‰ğ‚Ì” (ŒÂ‘Ìi‚æ‚è—DG‚ÈŒÂ‘Ì‚Ì”)
    
    non_dominant_num_i(ir) = {non_dominant_num};
    
    % ”ñ—òŒÂ‘Ì”Ô†‚Ì’Tõ
    pop_front_ind = find(non_dominant_num == 0);
    pop_front = pop_index(pop_front_ind);% ”ñ—òŒÂ‘Ì”Ô†
    pop_rank(ir) = {pop_front};


    %% ƒ‰ƒ“ƒN‚ÉŠi”[‚µ‚½ŒÂ‘Ì‚ğœ‚­
    pop_index(pop_front_ind) = [];
    F_vec_1(:,pop_front_ind,:) = [];
    F_vec_2(:,pop_front_ind,:) = [];
    F_vec_1(pop_front_ind,:,:) = [];
    F_vec_2(pop_front_ind,:,:) = [];
    
    
    ir = ir+1;
    
end
pop_rank = pop_rank(1:end-1);



