# Ubuntu 22.04 LTS (Jammy Jellyfish) tabanlı bir imaj kullanın
FROM ubuntu:22.04

# Ortam değişkenlerini ayarlayın (etkileşimli olmayan kurulumlar için)
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1

# Gerekli sistem bağımlılıklarını kurun
# Bu, Frappe Bench ve ERPNext'in çalışması için temel gereksinimleri sağlar.
# build-essential: Derleme araçları
# python3-dev, python3-pip, python3-setuptools, python3-wheel: Python geliştirme ve paket yönetimi
# mariadb-client: MariaDB veritabanı ile iletişim için istemci araçları
# redis-server: Redis önbellek sunucusu
# git: Kaynak kod yönetimi
# curl: URL'lerden veri transferi
# nginx: Web sunucusu (isteğe bağlı, bench start ile gelir)
# supervisor: Süreç yöneticisi (isteğe bağlı, bench start ile gelir)
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    python3-dev \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    mariadb-client \
    redis-server \
    git \
    curl \
    nginx \
    supervisor \
    && rm -rf /var/lib/apt/lists/*

# Node.js ve Yarn'ı kurun (Frappe frontend varlıkları için gereklidir)
# NodeSource'dan daha yeni bir Node.js sürümü almak için
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Frappe için özel bir kullanıcı oluşturun
RUN useradd -m -s /bin/bash frappe

# Frappe kullanıcısına geçin
USER frappe

# Çalışma dizinini Frappe kullanıcısının ana dizinine ayarlayın
WORKDIR /home/frappe

# Frappe Bench CLI'yı kurun
RUN pip3 install frappe-bench

# Yeni bir Frappe Bench başlatın. Bu, 'frappe-bench' dizinini oluşturur.
RUN bench init frappe-bench

# Çalışma dizinini yeni oluşturulan bench dizinine değiştirin
WORKDIR /home/frappe/frappe-bench

# apps.txt dosyasını kopyalayın
# Bu dosya, bench new-site veya bench get-app komutları tarafından kullanılabilir.
COPY apps.txt /home/frappe/frappe-bench/apps.txt

# entrypoint.sh betiğini kapsayıcıya kopyalayın
# entrypoint.sh dosyasının Dockerfile ile aynı dizinde olduğundan emin olun.
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# entrypoint betiğini çalıştırılabilir hale getirin
RUN chmod +x /usr/local/bin/entrypoint.sh

# Varsayılan ERPNext portunu (8000) dışarıya açın
EXPOSE 8000

# Kapsayıcı başladığında çalışacak ana komutu tanımlayın
# entrypoint.sh betiği site oluşturma ve hizmetleri başlatma işlemlerini yönetecek.
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Kapsayıcı başlatıldığında varsayılan olarak çalışacak komut (ENTRYPOINT tarafından geçersiz kılınabilir)
CMD ["bench", "start"]