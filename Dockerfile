# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy csproj and restore dependencies
COPY ["HelloWorld.Console/HelloWorld.Console.csproj", "HelloWorld.Console/"]
RUN dotnet restore "HelloWorld.Console/HelloWorld.Console.csproj"

# Copy all the source code and build
COPY . .
RUN dotnet build "HelloWorld.Console/HelloWorld.Console.csproj" -c Release -o /app/build

# Publish stage
FROM build AS publish
RUN dotnet publish "HelloWorld.Console/HelloWorld.Console.csproj" -c Release -o /app/publish /p:UseAppHost=false

# Final stage
FROM mcr.microsoft.com/dotnet/runtime:8.0 AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "HelloWorld.Console.dll"]