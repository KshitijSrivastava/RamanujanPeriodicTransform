function [ A ] = Create_A(N,method)
%Create_A(N,method) Returns an NXN Nested Periodicity Matrix A. 
%method = 'random' or 'Ramanujan' or 'NaturalBasis' or 'DFT'.
%'random' gives a random NPM.
%'Ramanujan' gives the Ramanujan Periodicity Transform Matrix.
%'NaturalBasis' gives the Natural Basis NPM.
%'DFT' gives the column permuted DFT matrix, where columns are arranged in
%increasing order of their periods.


% Copyright (c) 2016, California Institute of Technology. [Based on
% research sponsored by ONR.] All rights reserved.
% Based on work from the lab of P P Vaidyanathan.
% Code developed by Srikanth V. Tenneti.

% No-endorsement clause: Neither the name of the California Institute 
% of Technology (Caltech) nor the names of its contributors may be used to 
% endorse or promote products derived from this software without specific 
% prior written permission.

% Disclaimer: THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND 
% CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, 
% BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
% FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT 
% HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
% SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED 
% TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR 
% PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
% LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING 
% NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
% EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.



if(strcmp(method,'DFT')==0)
A=[];
for n=1:N
    if(rem(N,n)==0)
      k_orig=1:n;k=k_orig(gcd(k_orig,n)==1);Cn_colSize = size(k,2);
      if(strcmp(method,'random'))
       c1 = randi(500,n,1); % For a periodic random dictionary
       
      elseif(strcmp(method,'Ramanujan'))
       c1 = Cq(n); % For Ramanujan Dictionary
      elseif(strcmp(method,'NaturalBasis'))
       c1 = zeros(n,1);c1(1)=1;
      end
      
      Cn=[];
      for j = 1:Cn_colSize
        Cn = cat(2,Cn,circshift(c1,(j-1)));
      end
      CnA = repmat(Cn,floor(N/n),1);
      
      A=cat(2,A,CnA);
    end
end
end
if(strcmp(method,'DFT'))
    A=[];
    A_dft = dftmtx(N);
    a = 0:N-1;a(1)=N; a=N./gcd(a,N);
    [Y,I]=sort(a);
    A=A_dft(:,I);
end

end

