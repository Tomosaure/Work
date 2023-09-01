% Lecture du fichier audio
filename = 'Audio\mpl.wav';
audioData = audioread(filename);

% Conversion des échantillons audio en symboles
symbols = unique(audioData);

% Comptage des fréquences des symboles
frequencies = histcounts(audioData, numel(symbols));

% Construction du dictionnaire de Huffman
huffmanDict = huffmandict(symbols, frequencies);

% Construction de l'arbre de Huffman à partir du dictionnaire
huffmanTree = dict2tree(huffmanDict);

% Attribution des codes de Huffman
huffmanCode = dict2codes(huffmanDict);

% Compression
compressedData = huffmanenco(audioData, huffmanCode);

% Calcul du taux de compression
originalSize = numel(audioData) * 8; % Taille originale en bits
compressedSize = numel(compressedData); % Taille compressée en bits
compressionRatio = originalSize / compressedSize;
fprintf('Taux de compression : %.2f\n', compressionRatio);

% Sauvegarde des données compressées
save('compressed_data.mat', 'compressedData');
