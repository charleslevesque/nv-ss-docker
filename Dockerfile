FROM node:16.9-alpine3.14 AS node-builder

COPY ./ClientApp/*.json /home/ClientApp/
WORKDIR /home/ClientApp
RUN npm ci

COPY ./ClientApp/ /home/ClientApp/
RUN npm run build

FROM mcr.microsoft.com/dotnet/sdk:5.0-alpine3.13 AS dotnet-builder

COPY ./*.csproj /home/src/
WORKDIR /home/src
RUN dotnet restore

COPY . /home/src/
COPY --from=node-builder /home/ClientApp/ /home/src/ClientApp/
RUN dotnet publish -c Release -o bin/Release

FROM mcr.microsoft.com/dotnet/aspnet:5.0-alpine3.13

COPY --from=dotnet-builder /home/src/bin/Release/ /home/app/
WORKDIR /home/app
EXPOSE 80 443
ENTRYPOINT [ "dotnet", "nv-ss-docker.dll" ]
