function [A,b]=Aconstruct_diffusiveTerm_new(A,b,Node_number_matrix,Coordinate_R,dz,dr)  
[dimy,dimx]=size(Node_number_matrix);
kk=1;

for ii=2:(dimx-1)
    for jj=2:(dimy-1)
        rad_P(kk)=Coordinate_R(jj,ii);
        rad_N(kk)=Coordinate_R(jj-1,ii);
        rad_S(kk)=Coordinate_R(jj+1,ii);
        rad_W(kk)=Coordinate_R(jj,ii-1);
        rad_E(kk)=Coordinate_R(jj,ii+1);

        idx_P(kk)=Node_number_matrix(jj,ii);
        idx_N(kk)=Node_number_matrix(jj-1,ii);
        idx_S(kk)=Node_number_matrix(jj+1,ii);
        idx_W(kk)=Node_number_matrix(jj,ii-1);
        idx_E(kk)=Node_number_matrix(jj,ii+1);
      
        kk=kk+1;
    end
end

for ii=1:length(idx_P)
    A(idx_P(ii),idx_P(ii))= (-2/(dr*dr)  - 2/(dz*dz))      ;
    A(idx_P(ii),idx_S(ii))=         1/(dr*dr)       ;
    A(idx_P(ii),idx_N(ii))=         1/(dr*dr)       ;
    A(idx_P(ii),idx_W(ii))=         1/(dz*dz)       ;
    A(idx_P(ii),idx_E(ii))=         1/(dz*dz)       ;
end

b=b;

end