#!/bin/bash

# Bu betik, bir Docker kapsayıcısı içinde ERPNext'i başlatmak ve gerekirse kurmak için tasarlanmıştır.

# site_config.json dosyasının yolunu tanımlayın
SITE_CONFIG_PATH="/home/frappe/frappe-bench/sites/site1.local/site_config.json"

echo "ERPNext başlangıç betiği başlatılıyor..."

# site_config.json dosyasının varlığını kontrol edin
if [ ! -f "$SITE_CONFIG_PATH" ]; then
    echo "Site yapılandırma dosyası ($SITE_CONFIG_PATH) bulunamadı."
    echo "Yeni bir ERPNext sitesi oluşturuluyor: site1.local"
    echo "MariaDB root şifresi: root"
    echo "Yönetici şifresi: admin"
    echo "ERPNext uygulaması kuruluyor..."

    # bench new-site komutunu belirtilen parametrelerle çalıştırın.
    # --mariadb-root-password ve --admin-password otomatik kurulum için sağlanmıştır.
    # --install-app erpnext, ERPNext uygulamasının yeni siteye kurulmasını sağlar.
    bench new-site site1.local \
        --mariadb-root-password root \
        --admin-password admin \
        --install-app erpnext

    # Önceki komutun çıkış durumunu kontrol edin
    if [ $? -eq 0 ]; then
        echo "ERPNext sitesi 'site1.local' başarıyla oluşturuldu."
    else
        echo "Hata: 'site1.local' ERPNext sitesi oluşturulamadı."
        exit 1 # Site oluşturma başarısız olursa hata koduyla çıkın
    fi
else
    echo "Site yapılandırma dosyası ($SITE_CONFIG_PATH) bulundu."
    echo "'site1.local' zaten mevcut olduğu için yeni site oluşturma atlanıyor."
fi

echo "bench start ile ERPNext hizmetleri başlatılıyor..."
# ERPNext hizmetlerini başlatın. Bu komut kapsayıcıyı çalışır durumda tutacaktır.
# Ana süreç ise, betikteki son komutun bu olması önemlidir.
bench start

<<<<<<< HEAD
echo "ERPNext hizmetleri başlatıldı."
=======
echo "ERPNext services started."
>>>>>>> 80c329d680b03f47a2604dbf0e43bcf693622936
