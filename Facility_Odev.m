clc;
clear; 
clear All;

% Yardımcıların hazırlama süreleri
yardimci_1_sure = [5, 6, 4, 7, 5, 3, 5, 4, 7, 2, 4, 4, 3, 3, 3, 5, 4, 5, 3, 4, 4, 3, 3, 5, 3];
yardimci_2_sure = [6, 6, 9, 8, 7, 5, 11, 6, 6, 7, 5, 6, 7, 8, 6, 8, 10, 9, 7, 6, 5, 6, 4, 5, 4];
yardimci_3_sure = ones(1, 50); % 50 tane 1'den oluşan dizi
yardimci_4_sure = ones(1, 50); % 50 tane 1'den oluşan dizi
yardimci_5_sure = [16, 17, 17, 16, 15, 17, 23, 24, 25, 24, 27, 21, 24, 25, 28, 27, 29, 26, 30, 27, 28, 29, 33, 34, 35, 16, 17, 17, 16, 15, 17, 23, 24, 25, 24, 27, 21, 24, 25, 28, 27, 29, 26, 30, 27, 28, 29, 33, 34, 35];

% Standart sapmaları hesaplama
std_dev_1 = std(yardimci_1_sure);
std_dev_2 = std(yardimci_2_sure);
std_dev_5 = std(yardimci_5_sure);

% Alanın boyutları (metre cinsinden)
alan_eni = 3;
alan_boyu = 8;

% Dolapların boyutları (metre cinsinden)
dolap_elektrik_maliyeti = 1.48;
dolap_calisma_suresi = 12;

% Tabak miktarı
istenen_tabak_sayisi = 450; % Örnek olarak 500 tabak hazırlanacak

% Dolap kapasite ve dolap sayısının hesaplanması
dolap_kapasite = 80; % Dolap kapasitesi (örneğin 100 tabaklık)
dolap_sayisi = ceil(istenen_tabak_sayisi / dolap_kapasite); % Gerekli dolap sayısı

% Kısıtlar için alan boyutları
max_alan_eni = 50;
max_alan_boyu = 50;

dolap_eni = 3;
dolap_boyu = 2;

% Alan kontrolü
if dolap_sayisi * dolap_eni > max_alan_eni || dolap_sayisi * dolap_boyu > max_alan_boyu
    disp('Dolapların yerleştirilmesi için yeterli alan yok!');
    return;
end

% Yeni süreleri oluşturma ve tabak/dolap sayılarının hesaplanması
for i = 2:length(yardimci_1_sure)
    % Yeni süre oluşturma standart sapma kullanılarak
    yardimci_1_sure(i) = yardimci_1_sure(i-1) + std_dev_1 * randn();
    yardimci_2_sure(i) = yardimci_2_sure(i-1) + std_dev_2 * randn();
    yardimci_5_sure(i) = yardimci_5_sure(i-1) + std_dev_5 * randn();
end

% Maliyet ve kar hesaplaması
tabak_maliyeti = 60; % Her bir tabağın maliyeti (örneğin 50 TL)
satis_fiyati = 75; % Her bir tabağın satış fiyatı (örneğin 100 TL)

toplam_maliyet = istenen_tabak_sayisi * tabak_maliyeti; % Toplam maliyet
toplam_kar = (satis_fiyati - tabak_maliyeti) * istenen_tabak_sayisi; % Toplam kar

% Asıl dolap sayısının hesaplanması
asil_dolap_sayisi = ceil(istenen_tabak_sayisi / dolap_kapasite);

% Asıl dolap sayısının maliyete etkisi
asil_dolap_maliyeti = asil_dolap_sayisi * (dolap_calisma_suresi * dolap_elektrik_maliyeti);

% Dolap yerleştirme işlemi ve maliyet hesabı
dolap_sayisi = 0;
toplam_tabaklar = 0;
acilma_suresi = 0;
ekstra_odeme = 0;

while true
    dolap_sayisi = dolap_sayisi + 1;
    toplam_tabaklar = toplam_tabaklar + dolap_elektrik_maliyeti * dolap_calisma_suresi;
    acilma_suresi = dolap_sayisi * dolap_calisma_suresi;
    
    if acilma_suresi > 270
        ekstra_odeme = ekstra_odeme + (acilma_suresi - 270) * 3;
        garson_maas = garson_maas + (alma_suresi - 270) * 3;
    end
    
    if toplam_tabaklar > numel(yardimci_1_sure) || toplam_tabaklar > numel(yardimci_3_sure)
        break;
    end
    
    % Dolap kapasitesine ulaşıldığında yeni bir dolap eklenir
    if mod(toplam_tabaklar, dolap_calisma_suresi * dolap_elektrik_maliyeti) == 0
        dolap_sayisi = dolap_sayisi + 1;
    end
end

% Çalışan ve işletme maliyetleri (aynı kalabilir)
calisan_ucreti = 80; % saatlik ücret
calisma_suresi = 8; % çalışma süresi

garson_maas = calisan_ucreti * calisma_suresi * ceil(dolap_sayisi / 3); % garson maaşı (her 3 dolap için bir çalışan)

gecis_suresi = 17; % Dolaplar arası geçiş süresi (saniye cinsinden)

isletme_zarar = dolap_sayisi * gecis_suresi * ceil(dolap_sayisi / 3); % Geç açılma zararı
asil_dolap_maliyeti_zarar = asil_dolap_maliyeti + isletme_zarar + ekstra_odeme; % Asıl dolap maliyeti zarara dahil ediliyor

toplam_zarar = asil_dolap_maliyeti_zarar + garson_maas; % Toplam zarar hesabı

% Toplam kar ve toplam zarar arasındaki farkın hesaplanması (Net Kar)
net_kar = toplam_kar - toplam_zarar;

disp(['Total Profit: ', num2str(toplam_kar), ' TL']);
disp(['Total Loss: ', num2str(toplam_zarar), ' TL']);
disp(['Net profit (Revenue - Expenses): ', num2str(net_kar), ' TL']);
disp(['Cooling-Heating Unit Cost (Including Loss): ', num2str(asil_dolap_maliyeti_zarar), ' TL']);
disp(['Number Of Requested Plates: ', num2str(istenen_tabak_sayisi)]);
disp(['Number of Required Cooling-Heating Units: ', num2str(asil_dolap_sayisi)]);
