%import iris dataset
filename = "iris.xls";
A = xlsread(filename)
iris_sertosa = A(1:50,1:4)
iris_versicolor = A(51:100,1:4)
iris_virginica = A(101:150,1:4)
%contruct data matrix
X = horzcat(iris_sertosa.',iris_versicolor.',iris_virginica.')

[r,c]=size(X);
%construct column mean vector
mu = mean(X,2);
d=X-repmat(mu,1,c); 
%contruct covariance matrix and obtaining corresponding eigenvectors and
%eigenvalues
if(r<c)
    cov = (1/c)*d*d.'
    [eigenvector,eigvalues]=eig(cov);
else
%trick if r>>c which occurs in case of high dimensional data like images
    cov =  (1/c)*d.'*d
    [eigenvector,eigvalues]=eig(cov);
    eigenvector = d*eigenvector;
%normalising eigenvectors
for i = 1:c
    eigenvector(:,i) = eigenvector(:,i)/norm(eigenvector(:,i))
end

end
%sorting eigenvalues and eigenvectors in descending order
eigvalues = diag(eigvalues)
[sort_eig, index] = sort(-eigvalues)
eigenvalues = eigvalues(index)
%contruct principal component matrix
for i = 1:size(eigvalues)
    principal_comp(:,i) = eigenvector(:,index(i));
end

% when taking only first two principal components
Y2p = principal_comp(:,1:2).'*d
x2 = Y2p(1,:)
y2 = Y2p(2,:)
c = [repmat(1,1,50),repmat(2,1,50),repmat(3,1,50)];
sz =25;
figure('Name','Projection of datapoints along first two principal components');

scatter(x2,y2,sz,c.','filled')
 grid on;
 title('Projection along two principal components')
xlabel('1st principal component')
 ylabel('2nd principal component')
 %when taking only all principal components
 Y4p = principal_comp(:,:).'*d
%when taking only first three principal components
Y3p = principal_comp(:,1:3).'*d
x3 = Y3p(1,:)
y3 = Y3p(2,:)
z3 = Y3p(3,:)
c = [repmat(1,1,50),repmat(2,1,50),repmat(3,1,50)]; 
figure('Name','Projection of datapoints along first three principal components');
s =25

scatter3(x3,y3,z3,s,c,'filled')
grid on;
title('Projection along three principal components')
 xlabel('1st principal component')
ylabel('2nd principal component')
zlabel('3rd principal component')
% for single principal vector 
 Y1p1 = principal_comp(:,1).'*d
 Y1p2 = principal_comp(:,2).'*d
 Y1p3 = principal_comp(:,3).'*d
 Y1p4 = principal_comp(:,4).'*d
 figure('Name','Projection along single principal components, visualising variance of data points');

 
 subplot(4,1,1)
 sz = 20
 
 ck = repmat(1,1,150)
 scatter(Y1p1 , zeros(1,size(Y1p1,2)),sz,ck,'filled')
 %variation along principal components taken one at a time
 title('Visualising variance of datapoints along principal components')
  xlabel('1st principal component')
 subplot(4,1,2)
  
 scatter(Y1p2, zeros(1,size(Y1p2,2)),sz,ck,'filled')
 xlabel('2nd principal component')
 subplot(4,1,3)
 
 scatter(Y1p3, zeros(1,size(Y1p3,2)),sz,ck,'filled')
 xlabel('3rd principal component')
 subplot(4,1,4)
  
 
 scatter(Y1p4, zeros(1,size(Y1p4,2)),sz,ck,'filled')
 xlabel('4th principal component')

 
 %recontruction error when taking 4 principal components
X_4prime = principal_comp(:,:)*Y4p + mu
error_4 = norm(X_4prime - X)
%recontruction error when taking 3 principal components
X_3prime = principal_comp(:,1:3)*Y3p + mu
error_3 = norm(X_3prime - X)
%recontruction error when taking 2 principal components
X_2prime = principal_comp(:,1:2)*Y2p + mu
error_2 = norm(X_2prime - X)
%recontruction error when taking 1 principal component
X_1prime = principal_comp(:,1)*Y1p1 + mu
error_1 = norm(X_1prime - X);
error = [error_1, error_2 , error_3,error_4]
%visualising the reconstruction error 
figure('Name','recontruction error plot');

plot([1,2,3,4],error)
title ('error plot')
 xlabel('number of principal components')
 ylabel('recontruction error')
%calculating robustness ri when i principal components are taken
r1 = eigenvalues(1)/sum(eigenvalues)
r2 = (eigenvalues(1)+eigenvalues(2))/sum(eigenvalues)
r3 = (eigenvalues(1)+eigenvalues(2)+eigenvalues(3))/sum(eigenvalues)