@doc doc"""
#### Objet
Cette fonction calcule une solution approchée du problème

```math
\min_{||s||< \Delta}  q(s) = s^{t} g + \frac{1}{2} s^{t}Hs
```

par l'algorithme du gradient conjugué tronqué

#### Syntaxe
```julia
s = Gradient_Conjugue_Tronque(g,H,option)
```

#### Entrées :   
   - g : (Array{Float,1}) un vecteur de ``\mathbb{R}^n``
   - H : (Array{Float,2}) une matrice symétrique de ``\mathbb{R}^{n\times n}``
   - options          : (Array{Float,1})
      - delta    : le rayon de la région de confiance
      - max_iter : le nombre maximal d'iterations
      - tol      : la tolérance pour la condition d'arrêt sur le gradient

#### Sorties:
   - s : (Array{Float,1}) le pas s qui approche la solution du problème : ``min_{||s||< \Delta} q(s)``

#### Exemple d'appel:
```julia
gradf(x)=[-400*x[1]*(x[2]-x[1]^2)-2*(1-x[1]) ; 200*(x[2]-x[1]^2)]
hessf(x)=[-400*(x[2]-3*x[1]^2)+2  -400*x[1];-400*x[1]  200]
xk = [1; 0]
options = []
s = Gradient_Conjugue_Tronque(gradf(xk),hessf(xk),options)
```
"""
function Gradient_Conjugue_Tronque(g,H,options)

    "# Si option est vide on initialise les 3 paramètres par défaut"
    if options == []
        delta = 2
        max_iter = 100
        tol = 1e-6
    else
        delta = options[1]
        max_iter = options[2]
        tol = options[3]
    end

   n = length(g)
   s = zeros(n)
   j = 0
   g₀ = g
   s₀ = 0
   p₀ = -g
   gⱼ = g₀
   q(s) = g'*s + 0.5*s'*H*s
   sⱼ = s
   pⱼ = p₀

   while j < max_iter && norm(gⱼ) > max(norm(g₀)*tol,tol) 
    kⱼ = pⱼ'*H*pⱼ
    if kⱼ <= 0
        a = norm(pⱼ)^2
        b = 2*sⱼ'*pⱼ
        c = norm(sⱼ)^2 - delta^2
        d = sqrt(b^2 - 4*a*c)
        σ₁ = (-b+d)/(2*a)
        σ₂ = (-b-d)/(2*a)

        if q(sⱼ + σ₁*pⱼ) < q(sⱼ + σ₂*pⱼ)
            σⱼ = σ₁
        else
            σⱼ = σ₂   
        end
        return sⱼ + σⱼ*pⱼ
    end
    αⱼ = (gⱼ'*gⱼ)/kⱼ
    if norm(sⱼ + αⱼ*pⱼ) >= delta
        a = norm(pⱼ)^2
        b = 2*sⱼ'*pⱼ
        c = norm(sⱼ)^2 - delta^2
        d = sqrt(b^2 - 4*a*c)
        σⱼ = (-b+d)/(2*a)
        return sⱼ + σⱼ*pⱼ
    end
    sⱼ = sⱼ + αⱼ*pⱼ
    gⱼ₊₁ = gⱼ + αⱼ*H*pⱼ 
    βⱼ = (gⱼ₊₁'*gⱼ₊₁)/(gⱼ'*gⱼ)
    pⱼ = -gⱼ₊₁ + βⱼ*pⱼ
    gⱼ = gⱼ₊₁
    j = j + 1
    end
    return sⱼ
end
