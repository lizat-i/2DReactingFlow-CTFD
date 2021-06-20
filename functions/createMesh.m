function [Node_matrix,Coordinate_R,Coordinate_Z] = createMesh(dimR,dimZ,R,L)

%
%         r=0 -------------------------
% /\ 
%
% | 
% |
% ---->           r=R -------------------------
%
%
%
%
%


% this is a vector, that contains all node numbers
Node_number_vec=zeros(dimR*dimZ,1);
for ii=1:dimR*dimZ
    Node_number_vec(ii)=ii;
end
%this is a matrix, that represents the mesh and contains all node numbers
Node_matrix=reshape(Node_number_vec,[dimR,dimZ]);


deltaR=R/(dimR-1);
deltaZ=L/(dimZ-1);


for ii=1:dimR
    Coordinate_R(ii,1:dimZ)=(ii)*deltaR;
end

for jj=1:dimZ
    Coordinate_Z(1:dimR,jj)=(jj-1)*deltaZ;
end

Node_matrix=flip(Node_matrix);
Coordinate_R=flip(Coordinate_R);

end

