function Lsuccessful = checkSuccessfulJobs(Xobj,ScheckFile)
% check if a job has been successfully executed by looking for a specific
% file in the simulation folder that may exist only when the job is
% successful
%
% $Copyright~1993-2012,~COSSAN~Working~Group,~University~of~Liverpool,~UK$
% $Author: Matteo Broggi$

% =====================================================================
% This file is part of openCOSSAN.  The open general purpose matlab
% toolbox for numerical analysis, risk and uncertainty quantification.
%
% openCOSSAN is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License.
%
% openCOSSAN is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
%  You should have received a copy of the GNU General Public License
%  along with openCOSSAN.  If not, see <http://www.gnu.org/licenses/>.
% =====================================================================

Njobs=length(dir([OpenCossan.getCossanWorkingPath,filesep,Xobj.Sfoldername,'*']));
Lsuccessful = false(Njobs,1);

for irun = 1:Njobs
    SoutFile = fullfile(OpenCossan.getCossanWorkingPath,...
        [Xobj.Sfoldername,'_sim_',num2str(irun)],ScheckFile);
    Lsuccessful(irun) = logical(exist(SoutFile,'file'));
end

end
