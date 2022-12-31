FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

WORKDIR /source

COPY HelloWorldApp.sln .
COPY HelloWorldLibrary/*.csproj ./HelloWorldLibrary/
COPY HelloWorldTests/*.csproj ./HelloWorldTests/
COPY HelloWorldWeb/*.csproj ./HelloWorldWeb/
RUN dotnet restore

COPY HelloWorldLibrary/. ./HelloWorldLibrary/
COPY HelloWorldTests/. ./HelloWorldTests/
COPY HelloWorldWeb/. ./HelloWorldWeb/
WORKDIR /source/HelloWorldWeb
RUN dotnet publish -c release -o /app --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
COPY --from=build /app ./
EXPOSE 80
ENTRYPOINT ["dotnet", "HelloWorldWeb.dll"]
