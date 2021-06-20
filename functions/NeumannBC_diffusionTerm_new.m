function [A,b]=NeumannBC_diffusionTerm_new(A,b,boundary,Node_number_matrix,dz,dr)
 
[dimy,dimx]=size(Node_number_matrix);

value_i     = -1    ;
value_ii    = 1    ;
value_iii   = 0    ; 

switch boundary
    case 'East'
        idx=Node_number_matrix(:,dimx);
        idx_W=Node_number_matrix(:,dimx-1);
        idx_WW=Node_number_matrix(:,dimx-2);
 
        
        
        for ii=1:length(idx)
            %This is to prevent multiple BC to be active
            A(idx(ii),:)=0;
            
            A(idx(ii),idx(ii))=value_i/(dz);
            A(idx(ii),idx_W(ii))=value_ii/(dz);
            A(idx(ii),idx_WW(ii))=value_iii/(dz);
        end
        b(idx)=0;
        
    case 'West'
        idx=Node_number_matrix(:,1);
        idx_E=Node_number_matrix(:,2);
        idx_EE=Node_number_matrix(:,3);
 
        
        for ii=1:length(idx)
            %This is to prevent multiple BC to be active
            A(idx(ii),:)=0;
            
            A(idx(ii),idx(ii))=value_i/(dz);
            A(idx(ii),idx_E(ii))=value_ii/(dz);
            A(idx(ii),idx_EE(ii))=value_iii/(dz);
        end
        b(idx)=0;
        
    case 'North'
        idx=Node_number_matrix(1,:);
        idx_S=Node_number_matrix(2,:);
        idx_SS=Node_number_matrix(3,:);

        
        for ii=1:length(idx)
            %This is to prevent multiple BC to be active
            A(idx(ii),:)=0;
            
            A(idx(ii),idx(ii))=value_i/(dr);
            A(idx(ii),idx_S(ii))=value_ii/(dr);
            A(idx(ii),idx_SS(ii))=value_iii/(dr);
        end
        b(idx)=0;
        
    case 'South'
        idx=Node_number_matrix(dimy,:);
        idx_N=Node_number_matrix(dimy-1,:);
        idx_NN=Node_number_matrix(dimy-2,:);
 
        
        for ii=1:length(idx)
            %This is to prevent multiple BC to be active
            A(idx(ii),:)=0;
            
            A(idx(ii),idx(ii))=value_i/(dr);
            A(idx(ii),idx_N(ii))=value_ii/(dr);
            A(idx(ii),idx_NN(ii))=value_iii/(dr);
        end
        b(idx)=0;
        
        
    otherwise
        msg= 'Error, wrong Boundary Name';
        error(msg)
   end
end