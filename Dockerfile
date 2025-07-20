FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /DockerMVCapp

# Copy csproj and restore as distinct layers
COPY DockerMVCapp/*.csproj .
RUN dotnet restore

# Copy everything else and build website
COPY DockerMVCapp/. .
RUN dotnet publish -c Release -o out

# Final stage / image
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /WebApp
COPY --from=build /DockerMVCapp/out ./
ENTRYPOINT ["dotnet", "DockerMVCapp.dll"]
