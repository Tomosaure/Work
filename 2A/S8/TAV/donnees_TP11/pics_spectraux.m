function [pics_t, pics_f] = pics_spectraux(S, eta_t, eta_f, epsilon)
    SE = strel("rectangle",[eta_t eta_f]);
    dilatedS = imdilate(S,SE);
    [pics_f, pics_t] = find(S==dilatedS & S > epsilon);
end