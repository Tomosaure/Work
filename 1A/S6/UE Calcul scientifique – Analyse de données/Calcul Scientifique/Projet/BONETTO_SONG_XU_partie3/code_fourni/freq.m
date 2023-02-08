function m_freq = freq(liste)

a = mode(liste);

if length(find(liste == a)) == length(find(liste == liste(1)))
    m_freq = liste(1)
else
    m_freq = a
end

    
end
