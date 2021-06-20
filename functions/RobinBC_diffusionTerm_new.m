function [A,b]=RobinBC_diffusionTerm_new(A,b,boundary,Node_number_matrix,deltaX,deltaY,T_s,alpha)

% [dimy,dimx]=size(Node_number_matrix);
 lambda_mat= ones(size(Node_number_matrix));
% 
% value_i     =  1   ;
% value_ii    =  -1    ;
% value_iii   =  0    ; 
% 
% switch boundary
%     case 'East'
%         idx=Node_number_matrix(:,dimx);
%         idx_W=Node_number_matrix(:,dimx-1);
%         idx_WW=Node_number_matrix(:,dimx-2);
%         lambda_p=lambda_mat(:,dimx);
%         lambda_W=lambda_mat(:,dimx-1);
%         lambda_WW=lambda_mat(:,dimx-2);
%         
%         
%         for ii=1:length(idx)
%             %This is to prevent multiple BC to be active
%             A(idx(ii),:)=0;
%             
%             A(idx(ii),idx(ii))=value_i*(lambda_p(ii)/(dz)+alpha);
%             A(idx(ii),idx_W(ii))=value_ii*(lambda_p(ii)/(dz));
%             A(idx(ii),idx_WW(ii))=0;
%         end
%         b(idx)=alpha*T_s;
%         
%     case 'West'
%         idx=Node_number_matrix(:,1);
%         idx_E=Node_number_matrix(:,2);
%         idx_EE=Node_number_matrix(:,3);
%         lambda_p=lambda_mat(:,1);
%         lambda_E=lambda_mat(:,2);
%         lambda_EE=lambda_mat(:,3);
%         
%         for ii=1:length(idx)
%             %This is to prevent multiple BC to be active
%             A(idx(ii),:)=0;
%             
%             A(idx(ii),idx(ii))=value_i*(lambda_E(ii)/(dz)+alpha);
%             A(idx(ii),idx_E(ii))=value_ii*(lambda_E(ii)/(dz));
%             A(idx(ii),idx_EE(ii))=0;
%         end
%         b(idx)=alpha*T_s;
%         
%     case 'North'
%         idx=Node_number_matrix(1,:);
%         idx_S=Node_number_matrix(2,:);
%         idx_SS=Node_number_matrix(3,:);
%         lambda_p=lambda_mat(1,:);
%         lambda_W=lambda_mat(2,:);
%         lambda_WW=lambda_mat(3,:);
%         
%         for ii=1:length(idx)
%             %This is to prevent multiple BC to be active
%             A(idx(ii),:)=0;
%             
%             A(idx(ii),idx(ii))=value_i*(lambda_p(ii)/(dr)+alpha);
%             A(idx(ii),idx_S(ii))=value_ii*(lambda_W(ii)/(dr));
%             A(idx(ii),idx_SS(ii))=0;
%         end
%         b(idx)=alpha*T_s;
%         
%     case 'South'
%         idx=Node_number_matrix(dimy,:);
%         idx_N=Node_number_matrix(dimy-1,:);
%         idx_NN=Node_number_matrix(dimy-2,:);
%         lambda_p=lambda_mat(dimy,:);
%         lambda_N=lambda_mat(dimy-1,:);
%         lambda_NN=lambda_mat(dimy-2,:);
%         
%         for ii=1:length(idx)
%             %This is to prevent multiple BC to be active
%             A(idx(ii),:)=0;
%             
%             A(idx(ii),idx(ii))=value_i*(lambda_p(ii)/(dr)+alpha);
%             A(idx(ii),idx_N(ii))=value_ii*(lambda_N(ii)/(dr));
%             A(idx(ii),idx_NN(ii))=0;
%         end
%         b(idx)=alpha*T_s;
%         
%         
%     otherwise
%         msg= 'Error, wrong Boundary Name';
%         error(msg)
% end
% end

[dimy,dimx]=size(Node_number_matrix);

switch boundary
    case 'East'
        idx=Node_number_matrix(:,dimx);
        idx_W=Node_number_matrix(:,dimx-1);
        idx_WW=Node_number_matrix(:,dimx-2);
        lambda_p=lambda_mat(:,dimx);
        lambda_W=lambda_mat(:,dimx-1);
        lambda_WW=lambda_mat(:,dimx-2);
        
        
        for ii=1:length(idx)
            %This is to prevent multiple BC to be active
            A(idx(ii),:)=0;
            
            A(idx(ii),idx(ii))=3*lambda_p(ii)/(2*deltaX)+alpha;
            A(idx(ii),idx_W(ii))=-4*lambda_W(ii)/(2*deltaX);
            A(idx(ii),idx_WW(ii))=lambda_WW(ii)/(2*deltaX);
        end
        b(idx)=alpha*T_s;
        
    case 'West'
        idx=Node_number_matrix(:,1);
        idx_E=Node_number_matrix(:,2);
        idx_EE=Node_number_matrix(:,3);
        lambda_p=lambda_mat(:,1);
        lambda_E=lambda_mat(:,2);
        lambda_EE=lambda_mat(:,3);
        
        for ii=1:length(idx)
            %This is to prevent multiple BC to be active
            A(idx(ii),:)=0;
            
            A(idx(ii),idx(ii))=3*lambda_p(ii)/(2*deltaX)+alpha;
            A(idx(ii),idx_E(ii))=-4*lambda_E(ii)/(2*deltaX);
            A(idx(ii),idx_EE(ii))=lambda_EE(ii)/(2*deltaX);
        end
        b(idx)=alpha*T_s;
        
    case 'North'
        idx=Node_number_matrix(1,:);
        idx_S=Node_number_matrix(2,:);
        idx_SS=Node_number_matrix(3,:);
        lambda_p=lambda_mat(1,:);
        lambda_W=lambda_mat(2,:);
        lambda_WW=lambda_mat(3,:);
        
        for ii=1:length(idx)
            %This is to prevent multiple BC to be active
            A(idx(ii),:)=0;
            
            A(idx(ii),idx(ii))=3*lambda_p(ii)/(2*deltaY)+alpha;
            A(idx(ii),idx_S(ii))=-4*lambda_W(ii)/(2*deltaY);
            A(idx(ii),idx_SS(ii))=lambda_WW(ii)/(2*deltaY);
        end
        b(idx)=alpha*T_s;
        
    case 'South'
        idx=Node_number_matrix(dimy,:);
        idx_N=Node_number_matrix(dimy-1,:);
        idx_NN=Node_number_matrix(dimy-2,:);
        lambda_p=lambda_mat(dimy,:);
        lambda_N=lambda_mat(dimy-1,:);
        lambda_NN=lambda_mat(dimy-2,:);
        
        for ii=1:length(idx)
            %This is to prevent multiple BC to be active
            A(idx(ii),:)=0;
            
            A(idx(ii),idx(ii))=3*lambda_p(ii)/(2*deltaY)+alpha;
            A(idx(ii),idx_N(ii))=-4*lambda_N(ii)/(2*deltaY);
            A(idx(ii),idx_NN(ii))=lambda_NN(ii)/(2*deltaY);
        end
        b(idx)=alpha*T_s;
        
        
    otherwise
        msg= 'Error, wrong Boundary Name';
        error(msg)
end
end