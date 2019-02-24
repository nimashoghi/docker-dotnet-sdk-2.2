FROM buildpack-deps:bionic-scm

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    libc6 \
    libgcc1 \
    libgssapi-krb5-2 \
    libicu60 \
    liblttng-ust0 \
    libssl1.0.0 \
    libstdc++6 \
    zlib1g \
    && rm -rf /var/lib/apt/lists/*

ENV DOTNET_SDK_VERSION 2.2.200-preview-009921

RUN curl -SL --output dotnet.tar.gz https://dotnetcli.blob.core.windows.net/dotnet/Sdk/$DOTNET_SDK_VERSION/dotnet-sdk-$DOTNET_SDK_VERSION-linux-x64.tar.gz \
    && dotnet_sha512='6E51EADF1D0C70101B033A0580191E302EC308C5BC32C903E0DE4A7504793F30E874FF1F4C9FD7054F65E6FC310E24D0D1EED0CCF29BCF55FB0BB24900B12D07' \
    && echo "$dotnet_sha512 dotnet.tar.gz" | sha512sum -c - \
    && mkdir -p /usr/share/dotnet \
    && tar -zxf dotnet.tar.gz -C /usr/share/dotnet \
    && rm dotnet.tar.gz \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet

ENV ASPNETCORE_URLS=http://+:80 \
    DOTNET_RUNNING_IN_CONTAINER=true \
    DOTNET_USE_POLLING_FILE_WATCHER=true \
    NUGET_XMLDOC_MODE=skip
