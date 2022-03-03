Що знадобиться?
1. Встановити https://www.terraform.io/downloads
2. Зареєструватися на https://www.digitalocean.com/

Інструкція

1. Клонуємо цей рупозиторій
2. ssh-keygen -f ~/Downloads/terraform -C "email@example.com"
3. Створюємо DigitalOcean SSH Key тут https://cloud.digitalocean.com/account/security і копіюємо туди вміст terraform.pub
Важливо: імʼя ключа має бути "terraform"
4. Створюємо DigitalOcean токен https://cloud.digitalocean.com/account/api/tokens з правами на читання й запис, копіюємо - він нам знадобиться пізніше
5. У кожному файлі droplet-*.tf редагуємо команду у рядку 30 - підставляємо актуальну ціль, параметри
Пізніше зроблю аргументом.
6. У терміналі, у директорії куди ви склонували репозиторій:

`terraform plan -var "do_token=DigitalOceanToken" -var "pvt_key=terraform" -var "ssh_src_ipv4=PublicIPv4"`

`terraform apply -var "do_token=DigitalOceanToken" -var "pvt_key=terraform" -var "ssh_src_ipv4=PublicIPv4"`

Атака почалась.

По закінченню вилучаємо створену раніше інфраструктуру: 

`terraform destroy -var "do_token=DigitalOceanToken" -var "pvt_key=terraform" -var "ssh_src_ipv4=PublicIPv4"`

За необхідності - змінюємо ціль і починаємо спочатку.



 
