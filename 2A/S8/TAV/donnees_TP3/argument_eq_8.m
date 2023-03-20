function [poids,argument] = argument_eq_8(mu_test,sigma_test,liste_nvg,F)

	N = length(mu_test);
	A = zeros(256,N);
    for i = 1:N
		mu_i = mu_test(i);
		sigma_i = sigma_test(i);
		A(:,i) = 1/sqrt(2*pi)/sigma_i*exp(-(liste_nvg-mu_i).^2/(2*sigma_i^2));
    end
    poids = A\F';
	argument = min(sum(F'-A*poids).^2);
end