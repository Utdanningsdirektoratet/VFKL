#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0-alpine AS base
WORKDIR /app
RUN apk add --no-cache icu-libs
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=false
ENV TZ=Europe/Oslo

FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine AS build
WORKDIR /src
#COPY ["vfkl.Migrator.csproj", "vfkl.Migrator/"]
#RUN dotnet restore "vfkl.Migrator/vfkl.Migrator.csproj"
COPY . .
RUN dotnet restore "vfkl.Migrator.csproj"
RUN dotnet build "vfkl.Migrator.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "vfkl.Migrator.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS vfklmigrator
WORKDIR /app
COPY --from=publish /app/publish .

ENTRYPOINT ["dotnet", "vfkl.Migrator.dll"]
