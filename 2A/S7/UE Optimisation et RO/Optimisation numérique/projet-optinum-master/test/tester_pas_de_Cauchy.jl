@doc doc"""
Tester le Pas de Cauchy local"""

function tester_pas_de_Cauchy(Pas_De_Cauchy::Function)
	@testset "Cas test g nul" begin
		g = [0; 0]
		H = [1 0 ; 0 1]
		delta = 1
		s, e = Pas_De_Cauchy(g,H,delta)
		@test s ≈ [0; 0]
		@test e == 0
	end
	@testset "Cas test H nul, a = 0, b != 0" begin
		g = [1; 1]
		H = [0 0 ; 0 0]
		delta = sqrt(2)
		s, e = Pas_De_Cauchy(g,H,delta)
		@test s ≈ -g
		@test e == 1
	end
	@testset "Cas test H < 0, a < 0, b != 0" begin
		g = [1; 1]
		H = [-1 0 ; 0 -1]
		delta = sqrt(2)
		s, e = Pas_De_Cauchy(g,H,delta)
		@test s ≈ -g
		@test e == 1
	end
	@testset "Cas test H > 0, a > 0, b != 0, delta = 0.9 deltabar" begin
		g = [1; 1]
		H = [1 0 ; 0 1]
		deltabar = norm(g)^3/(g'*H*g)
		delta = 0.9*deltabar
		s, e = Pas_De_Cauchy(g,H,delta)
		@test s ≈ -delta/norm(g)*g
		@test e == 1
	end
	@testset "Cas test H > 0, a > 0, b != 0, delta = 1.1 deltabar" begin
		g = [1; 1]
		H = [1 0 ; 0 1]
		deltabar = norm(g)^3/(g'*H*g)
		delta = 1.1*deltabar
		s, e = Pas_De_Cauchy(g,H,delta)
		@test s ≈ -deltabar/norm(g)*g
		@test e == -1
    end
end