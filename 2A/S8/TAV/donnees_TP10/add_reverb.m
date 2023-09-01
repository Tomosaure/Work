function y_modified = add_reverb(y, reverb_time, reverb_gain)

    reverb_length = round(reverb_time * 44100);
    reverb_IR = randn(reverb_length, 1);

    % Apply the reverb effect
    y_reverb = conv(y, reverb_IR, 'same');

    y_modified = (1-reverb_gain) * y + reverb_gain * y_reverb;

    % Normalize the output to prevent clipping
    y_modified = y_modified / max(abs(y_modified));

end
