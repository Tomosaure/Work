function x = moyenne(im)
    im = single(im);
    rvb = im./max(1,sum(im,3));
    rvb_barre = mean(mean(rvb));
    x = rvb_barre(:,:,1:2);
end

