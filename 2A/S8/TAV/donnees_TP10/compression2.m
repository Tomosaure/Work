function [Y_modifie, compression_rate] = compression2(Y, window_size, valeurs_f)
    Y = passe_bas(Y, valeurs_f, 5000);
    Y_mod = abs(Y);
    [num_freq, num_frames] = size(Y_mod);
    Y_modifie = zeros(num_freq, num_frames);

    for i = 1:num_frames
        for j = 1:num_freq
            window_start = max(1, j - window_size);
            window_end = min(num_freq, j + window_size);

            [~, max_index] = max(Y_mod(window_start:window_end, i));
            max_index = max_index + window_start - 1;

            Y_modifie(max_index, i) = Y(max_index, i);
        end
    end
    
    num_nonzero_values = numel(Y_modifie)-nnz(Y_modifie);
    total_values = numel(Y);
    compression_rate = (num_nonzero_values / total_values) * 100;
end
