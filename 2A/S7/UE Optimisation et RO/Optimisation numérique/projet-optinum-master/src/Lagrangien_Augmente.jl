@doc doc"""
#### Objet

Résolution des problèmes de minimisation avec une contrainte d'égalité scalaire par l'algorithme du lagrangien augmenté.

#### Syntaxe
```julia
xmin,fxmin,flag,iter,μₖs,λₖs = Lagrangien_Augmente(algo,f,gradf,hessf,c,gradc,hessc,x0,options)
```

#### Entrées
  - algo : (String) l'algorithme sans contraintes à utiliser:
    - "newton"  : pour l'algorithme de Newton
    - "cauchy"  : pour le pas de Cauchy
    - "gct"     : pour le gradient conjugué tronqué
  - f : (Function) la fonction à minimiser
  - gradf       : (Function) le gradient de la fonction
  - hessf       : (Function) la hessienne de la fonction
  - c     : (Function) la contrainte [x est dans le domaine des contraintes ssi ``c(x)=0``]
  - gradc : (Function) le gradient de la contrainte
  - hessc : (Function) la hessienne de la contrainte
  - x0 : (Array{Float,1}) la première composante du point de départ du Lagrangien
  - options : (Array{Float,1})
    1. epsilon     : utilisé dans les critères d'arrêt
    2. tol         : la tolérance utilisée dans les critères d'arrêt
    3. itermax     : nombre maximal d'itération dans la boucle principale
    4. λ₀     : la deuxième composante du point de départ du Lagrangien
    5. μ₀, τ    : valeurs initiales des variables de l'algorithme

#### Sorties
- xmin : (Array{Float,1}) une approximation de la solution du problème avec contraintes
- fxmin : (Float) ``f(x_{min})``
- flag : (Integer) indicateur du déroulement de l'algorithme
   - 0    : convergence
   - 1    : nombre maximal d'itération atteint
   - (-1) : une erreur s'est produite
- niters : (Integer) nombre d'itérations réalisées
- μₖs : (Array{Float64,1}) tableau des valeurs prises par mu_k au cours de l'exécution
- λₖs : (Array{Float64,1}) tableau des valeurs prises par lambda_k au cours de l'exécution

#### Exemple d'appel
```julia
using LinearAlgebra
algo = "gct" # ou newton|gct
f(x)=100*(x[2]-x[1]^2)^2+(1-x[1])^2
gradf(x)=[-400*x[1]*(x[2]-x[1]^2)-2*(1-x[1]) ; 200*(x[2]-x[1]^2)]
hessf(x)=[-400*(x[2]-3*x[1]^2)+2  -400*x[1];-400*x[1]  200]
c(x) =  (x[1]^2) + (x[2]^2) -1.5
gradc(x) = [2*x[1] ;2*x[2]]
hessc(x) = [2 0;0 2]
x0 = [1; 0]
options = []
xmin,fxmin,flag,iter,μₖs,λₖs = Lagrangien_Augmente(algo,f,gradf,hessf,c,gradc,hessc,x0,options)
```

#### Tolérances des algorithmes appelés

Pour les tolérances définies dans les algorithmes appelés (Newton et régions de confiance), prendre les tolérances par défaut définies dans ces algorithmes.

"""
function Lagrangien_Augmente(algo,fonc::Function,contrainte::Function,gradfonc::Function,
        hessfonc::Function,grad_contrainte::Function,hess_contrainte::Function,x0,options)

  if options == []
		epsilon = 1e-2
		tol = 1e-5
		itermax = 1000
		λ₀ = 2
		μ₀ = 100
		τ = 2
	else
		epsilon = options[1]
		tol = options[2]
		itermax = options[3]
		λ₀ = options[4]
		μ₀ = options[5]
		τ = options[6]
	end

  n = length(x0)
  xmin = zeros(n)
  fxmin = 0
  flag = 0
  iter = 0
  μₖ = μ₀   
  μₖs = [μ₀]
  λₖ = λ₀   
  λₖs = [λ₀]
  β = 0.9
  α = 0.1
  η = 0.1258925
  ϵ₀ = 1/μ₀
  η₀ = η/(μ₀^α)
  xₖ = x0
  xₖ₊₁ = x0
  ϵₖ = ϵ₀
  ηₖ = η₀

  Lₐ(xₖ) = fonc(xₖ) + λₖ'*contrainte(xₖ) + 0.5*μₖ*norm(contrainte(xₖ)^2)
  ▽Lₐ(xₖ) = gradfonc(xₖ) + λₖ'*grad_contrainte(xₖ) + μₖ*contrainte(xₖ)'*grad_contrainte(xₖ) 
  ▽²Lₐ(xₖ) = hessfonc(xₖ) + λₖ'*hess_contrainte(xₖ) + μₖ*(contrainte(xₖ)'*hess_contrainte(xₖ) + grad_contrainte(xₖ)*grad_contrainte(xₖ)')
 
  ▽Lₐ₀(xₖ) = gradfonc(xₖ) + λₖ'*grad_contrainte(xₖ)

  while norm(▽Lₐ₀(xₖ)) > max(tol*(norm(▽Lₐ₀(x0))), tol) ||
    norm(contrainte(xₖ)) >  max(tol*norm(contrainte(x0)), tol)
      xₖ = xₖ₊₁

      if algo == "newton"
        xₖ₊₁,fxₖ,_,_ = Algorithme_De_Newton(Lₐ,▽Lₐ,▽²Lₐ,xₖ,[itermax,ϵₖ,0,0])
      else
        xₖ₊₁,fxₖ,_,_ = Regions_De_Confiance(algo,Lₐ,▽Lₐ,▽²Lₐ,xₖ,[10,0.5,2,0.25,0.75,2,itermax,ϵₖ,0,0])
      end
 
      if norm(contrainte(xₖ₊₁)) <= ηₖ
        λₖ = λₖ + μₖ*contrainte(xₖ₊₁)
        ϵₖ = ϵₖ/μₖ
        ηₖ = ηₖ/(μₖ^β)
      else  
        μₖ = μₖ*τ
        ϵₖ = ϵ₀/μₖ
        ηₖ = η/(μₖ^α)
      end
      μₖs = [μₖs ; μₖ]
      λₖs = [λₖs ; λₖ]
      iter += 1
  
  if iter >= itermax
      flag = 1
      break
  end
  end 
  xmin = xₖ
  fxmin = fonc(xmin)
        
    return xmin,fxmin,flag,iter, μₖs, λₖs
end
