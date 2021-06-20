function [A,b]=DirechletBC(A,b,boundary,T_D,Node_number_matrix)
[dimy,dimx]=size(Node_number_matrix);

switch boundary
    case 'East'
        %at X=dimX Y=:
        idx=Node_number_matrix(:,dimx);
        for ii=1:length(idx)
            A(idx(ii),:)=0;
            A(idx(ii),idx(ii))=1;
        end
        b(idx)=T_D;
    case 'West'
        idx=Node_number_matrix(:,1);
        for ii=1:length(idx)
            A(idx(ii),:)=0;
            A(idx(ii),idx(ii))=1;
        end
        b(idx)=T_D;
    case 'North'
        idx=Node_number_matrix(1,:);
        for ii=1:length(idx)
            A(idx(ii),:)=0;
            A(idx(ii),idx(ii))=1;
        end
        b(idx)=T_D;
    case 'South'
        idx=Node_number_matrix(dimy,:);
        for ii=1:length(idx)
            A(idx(ii),:)=0;
            A(idx(ii),idx(ii))=1;
        end
        b(idx)=T_D;
    otherwise
        msg= 'Error, wrong Boundary Name';
        error(msg)
end
end