FROM mcr.microsoft.com/windows/servercore:ltsc2019
SHELL ["powershell"]

WORKDIR /azp

RUN Invoke-WebRequest "https://aka.ms/vs/17/release/vs_community.exe" -OutFile "$env:TEMP/vs_community.exe" -UseBasicParsing
RUN & "$env:TEMP/vs_community.exe" --add Microsoft.VisualStudio.Workload.NetWeb --includeRecommended --quiet --wait --norestart --noUpdateInstaller

# msbuild
RUN & 'C:/Program Files/Microsoft Visual Studio/2022/Community/MSBuild/Current/Bin/MSBuild.exe' /version

# choco
RUN iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))

# 7zip
RUN choco install -y 7zip.install

# git
RUN choco install -y git
RUN git --version --build-options

# nuget
RUN choco install -y nuget.commandline
RUN nuget help

RUN New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" -Name "LongPathsEnabled" -Value 1 -PropertyType DWORD -Force

COPY start.ps1 .

CMD ["powershell"]
ENTRYPOINT ["powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass", "./start.ps1"]