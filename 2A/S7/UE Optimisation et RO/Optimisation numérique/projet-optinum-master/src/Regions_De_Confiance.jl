@doc doc"""

#### Objet

Minimise une fonction de ``\mathbb{R}^{n}`` à valeurs dans ``\mathbb{R}`` en utilisant l'algorithme des régions de confiance. 

La solution approchées des sous-problèmes quadratiques est calculé 
par le pas de Cauchy ou le pas issu de l'algorithme du gradient conjugue tronqué

#### Syntaxe
```julia
xmin, fxmin, flag, nb_iters = Regions_De_Confiance(algo,f,gradf,hessf,x0,option)
```

#### Entrées :

   - algo        : (String) string indicant la méthode à utiliser pour calculer le pas
        - "gct"   : pour l'algorithme du gradient conjugué tronqué
        - "cauchy": pour le pas de Cauchy
   - f           : (Function) la fonction à minimiser
   - gradf       : (Function) le gradient de la fonction f
   - hessf       : (Function) la hessiene de la fonction à minimiser
   - x0          : (Array{Float,1}) point de départ
   - options     : (Array{Float,1})
     - Δmax       : utile pour les m-à-j de la région de confiance
                      ``R_{k}=\left\{x_{k}+s ;\|s\| \leq \Delta_{k}\right\}``
     - γ₁, γ₂ : ``0 < \gamma_{1} < 1 < \gamma_{2}`` pour les m-à-j de ``R_{k}``
     - η₁, η₂     : ``0 < \eta_{1} < \eta_{2} < 1`` pour les m-à-j de ``R_{k}``
     - Δ₀         : le rayon de départ de la région de confiance
     - max_iter       : le nombre maximale d'iterations
     - Tol_abs        : la tolérence absolue
     - Tol_rel        : la tolérence relative
     - ϵ       : ϵ pour les tests de stagnation

#### Sorties:

   - xmin    : (Array{Float,1}) une approximation de la solution du problème : 
               ``\min_{x \in \mathbb{R}^{n}} f(x)``
   - fxmin   : (Float) ``f(x_{min})``
   - flag    : (Integer) un entier indiquant le critère sur lequel le programme s'est arrêté (en respectant cet ordre de priorité si plusieurs critères sont vérifiés)
      - 0    : CN1
      - 1    : stagnation du ``x``
      - 2    : stagnation du ``f``
      - 3    : nombre maximal d'itération dépassé
   - nb_iters : (Integer)le nombre d'iteration qu'à fait le programme

#### Exemple d'appel
```julia
algo="gct"
f(x)=100*(x[2]-x[1]^2)^2+(1-x[1])^2
gradf(x)=[-400*x[1]*(x[2]-x[1]^2)-2*(1-x[1]) ; 200*(x[2]-x[1]^2)]
hessf(x)=[-400*(x[2]-3*x[1]^2)+2  -400*x[1];-400*x[1]  200]
x0 = [1; 0]
options = []
xmin, fxmin, flag, nb_iters = Regions_De_Confiance(algo,f,gradf,hessf,x0,options)
```
"""
function Regions_De_Confiance(algo,f::Function,gradf::Function,hessf::Function,x0,options)

    if options == []
        Δmax = 10
        γ₁ = 0.5
        γ₂ = 2.00
        η₁ = 0.25
        η₂ = 0.75
        Δ₀ = 2
        max_iter = 1000
        Tol_abs = sqrt(eps())
        Tol_rel = 1e-15
        ϵ = 1.e-2
    else
        Δmax = options[1]
        γ₁ = options[2]
        γ₂ = options[3]
        η₁ = options[4]
        η₂ = options[5]
        Δ₀ = options[6]
        max_iter = options[7]
        Tol_abs = options[8]
        Tol_rel = options[9]
        ϵ = options[10]
    end


    n = length(x0)
    xmin = zeros(n)
    fxmin = f(xmin)
    flag = 0
    nb_iters = 0
    xₖ = x0
    xₖ₋₁ = x0
    
    decroissances = []

    while norm(gradf(xₖ)) > max(Tol_rel*(norm(gradf(x0))), Tol_abs)
        actu = false
        xₖ₋₁ = xₖ
        if algo == "gct"
            sₖ = Gradient_Conjugue_Tronque(gradf(xₖ),hessf(xₖ),[Δ₀;max_iter;Tol_rel])
        elseif algo == "cauchy"
            sₖ,_ = Pas_De_Cauchy(gradf(xₖ),hessf(xₖ),Δ₀)
        end
        mₖ_sₖ = f(xₖ) + gradf(xₖ)'*sₖ + 0.5*sₖ'*hessf(xₖ)*sₖ
        mₖ₀ = f(xₖ)
        ρₖ = (f(xₖ) - f(xₖ+sₖ))/(mₖ₀ - mₖ_sₖ)

        # print(f(xₖ) - f(xₖ+sₖ))
        decroissances = [decroissances ; (f(xₖ) - f(xₖ+sₖ))]
        
        if ρₖ >= η₁
            actu = true
            xₖ = xₖ₋₁ + sₖ
        end
        if ρₖ >= η₂
            Δ₀ = min(γ₂*Δ₀, Δmax)
        elseif ρₖ >= η₁
            Δ₀ = Δ₀
        else 
            Δ₀ = γ₁*Δ₀
        end
        nb_iters += 1
    if norm(gradf(xₖ)) <= max(Tol_rel*(norm(gradf(x0))), Tol_abs)
        flag = 0
        break
    elseif norm(xₖ - xₖ₋₁) <= ϵ*max(Tol_rel*norm(xₖ), Tol_abs) && actu
        flag = 1
        break
    elseif abs(f(xₖ₋₁) - f(xₖ)) <= ϵ*max(Tol_rel*abs(f(xₖ₋₁)), Tol_abs) && actu
        flag = 2
        break
    elseif nb_iters >= max_iter
        flag = 3
        break
    end
    end 
    xmin = xₖ
    fmin = f(xmin)

    # decroissance_moy = sum(decroissances)/length(decroissances)
    # print("La decroissance moyenne pour "*algo*" est de : ", decroissance_moy, "")

    return xmin, fxmin, flag, nb_iters, decroissances
end
