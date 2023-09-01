function y_modifie = add_schroeder_reverb(y, delay, gain)

    y_modifie = y;
    d = delay * 44100;

    for i=1:3
        b=[gain zeros(1,round(d/i)) 1];
        a=[1 zeros(1,round(d/i)) gain];
        y_modifie = filter(b,a,y_modifie);
    end

    y_modifie = y_modifie + y;

    % Normalize the output to prevent clipping
    y_modifie = y_modifie / max(abs(y_modifie));
end
