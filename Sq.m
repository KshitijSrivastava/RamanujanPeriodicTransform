function [ CNA ] = Sq(L,q)

%Sq(L,q) return an L X phi(q) matrix, whose columns form a basis for the q^th Ramanujan 
%Subspace Sq. The basis vectors are of lenght L.

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



cq = zeros(q,1);
k_orig = 1:q; k = k_orig(gcd(k_orig,q)==1);

for n = 0:(q-1)
    for a = k
    cq(n+1) = cq(n+1) + exp(1j*2*pi*a*(n)/q);
    end
end

cq=real(cq);


    CN_colSize = size(k,2);
    CN=[];
    for j = 1:CN_colSize
        CN = cat(2,CN,circshift(cq,(j-1)));
    end
    
    CNA = repmat(CN,floor(L/q),1);
    CN_cutoff = CN(1:rem(L,q),:);
    CNA =cat(1,CNA,CN_cutoff);

end