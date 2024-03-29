% function H = BuildFilterMatrix_3D(beso,radius,centroids)
% 
% disp(['         Building filter matrix.'])
% cent = centroids(1:beso.nelem,:);
% % Estimating the number of elements in filter matrix: elements within filter
% 
% % area multiplied by the number of elements.
% nfilterel = round(beso.nelem*10);
% 
% % Allocating vectors
% % Element weights
% R = zeros(nfilterel,1);
% % Index vectors
% ifilt = zeros(nfilterel,1);
% jfilt = zeros(nfilterel,1);
% 
% % Selecting coordinates of design nodes
% X_den = cent(:,1);
% Y_den = cent(:,2);
% Z_den = cent(:,3);
% 
% % Auxiliary counter
% k = 0;
% 
% reverseStr = ''; 
% % Looping at the elements inside the design domain
% 
% for i = 1:beso.nelem
% 
%     % Element
%     el = i;
% 
%     % Coordinates of the centroid of the element
%     x = cent(el,1);
%     y = cent(el,2);
%     z = cent(el,3);
% 
%     % Weight function (linear with radial distance)
%     r = max(0,1-(((X_den-x).^2+(Y_den-y).^2+(Z_den-z).^2).^(1/2)/radius));
%     
%     % Auxiliary counter update
%     k = k+nnz(r);
% 
%     % Index vectors building
%     ifilt(k-nnz(r)+1:k) = i*ones(nnz(r),1);
%     jfilt(k-nnz(r)+1:k) = find(r);
% 
%     % Weights update
%     R(k-nnz(r)+1:k) = r(r>0)/sum(r);
%    
%     % Display the progress
%     percentDone = 100 * i / beso.nelem;
%     msg = sprintf('         Progress: %3.1f % ', percentDone);
%     fprintf([reverseStr, msg]);
%     reverseStr = repmat(sprintf('\b'), 1, length(msg));
% end
% ifilt(k+1:end)= [];
% jfilt(k+1:end)=[];
% R(k+1:end)=[];
% 
% % H filter matrix
% H = sparse(ifilt(1:k),jfilt(1:k),R(1:k),beso.nelem,beso.nelem);
% disp(['         Done'])
% end

function H = BuildFilterMatrix_3D(beso, radius, centroids)
    disp('Building filter matrix...');
    
    % Extracting centroid coordinates
    cent = centroids(1:beso.nelem,:);
    
    % Setting number of filter elements as 10% of number of design elements
    nfilterel = round(beso.nelem * 0.1);
    
    % Preallocating vectors for element weights and index values
    R = zeros(nfilterel, 1);
    ifilt = zeros(nfilterel, 1);
    jfilt = zeros(nfilterel, 1);
    
    % Extracting centroid coordinates for design nodes
    X_den = cent(:, 1);
    Y_den = cent(:, 2);
    Z_den = cent(:, 3);
    
    % Initializing auxiliary counter
    k = 0;
    reverseStr = ''; 
    % Looping through each element in the design domain
    for i = 1:beso.nelem
        % Coordinates of the centroid of the element
        x = cent(i, 1);
        y = cent(i, 2);
        z = cent(i, 3);

        % Calculating weight function (linear with radial distance)
        r = max(0, 1 - sqrt((X_den - x).^2 + (Y_den - y).^2 + (Z_den - z).^2) / radius);

        % Updating auxiliary counter
        k = k + nnz(r);

        % Building index vectors
        ifilt(k - nnz(r) + 1:k) = i * ones(nnz(r), 1);
        jfilt(k - nnz(r) + 1:k) = find(r);

        % Updating weights
        R(k - nnz(r) + 1:k) = r(r > 0) / sum(r);

        % Display the progress
        percentDone = 100 * i / beso.nelem;
        msg = sprintf('         Progress: %3.1f % ', percentDone);
        fprintf([reverseStr, msg]);
        reverseStr = repmat(sprintf('\b'), 1, length(msg));
    end
    
    % Removing excess elements from index and weight vectors
    ifilt(k + 1:end) = [];
    jfilt(k + 1:end) = [];
    R(k + 1:end) = [];

    % Creating filter matrix H using sparse function
    H = sparse(ifilt(1:k), jfilt(1:k), R(1:k), beso.nelem, beso.nelem);
    
    disp('Filter matrix built.');
end



