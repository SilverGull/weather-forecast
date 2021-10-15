FROM mcr.microsoft.com/dotnet/aspnet:3.1 as build-env
# FROM mcr.microsoft.com/dotnet/aspnet:3.1 as build-env
# FROM microsoft/dotnet:3.1-aspnetcore-runtime
# FROM microsoft/dotnet:latest
# FROM mcr.microsoft.com/dotnet/sdk:3.1


WORKDIR /app

#COPY . /app

COPY *.csproj .
# restore dependencies
RUN dotnet restore

COPY . /app

# build
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:3.1

WORKDIR /app

COPY --from=build-env /app/out .

EXPOSE 80

ENTRYPOINT ["dotnet", "weather-forecast.dll"]
