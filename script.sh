#!/bin/bash

echo "1.1 Инициализируем локальный репозиторий в lab0"

сd ~
mkdir -p ~/lab0
cd ~/lab0
git init

echo "1.2 Создаём каталоги с подкаталогами в lab0"

mkdir -p ~/lab0/claude_monet/kitchen
mkdir -p ~/lab0/claude_monet/chef_office
mkdir -p ~/lab0/claude_monet/tasting_room
mkdir -p ~/lab0/arcobaleno/kitchen
mkdir -p ~/lab0/arcobaleno/office
mkdir -p ~/lab0/arcobaleno/archive

echo "1.3 Наполняем файлы в каталогах"

cd ~/lab0
cat > critic_visit << 'EOF'
Ресторанный критик посетит оба ресторана
Сначала он зайдёт в Claude Monet
После этого отправится в Arcobaleno
EOF
cd ~/lab0/claude_monet/kitchen
cat > old_menu << 'EOF'
Утиная ножка от Виктора Баринова
Луковый суп Claude Monet
Фирменный салат от шефа
Десерт Луи с карамелью
EOF
cat > duck_recipe << 'EOF'
Подготовить утиную ножку
Добавить овощи и соус от Баринова
Перед подачей проверить температуру
EOF
cd ~/lab0/claude_monet/chef_office
cat > barinov_notes << 'EOF'
Не повторять блюда конкурентов
Катю допустить к общей дегустации
Лёва записывает замечания шефа
Последнее решение принимает Баринов
EOF
cd ~/lab0/claude_monet/tasting_room
cat > tasting_scores << 'EOF'
Блюдо Баринова получило девять баллов
Паста Кати получила восемь баллов
Десерт Луи получил десять баллов
EOF
cat > leva_comment << 'EOF'
Лёва проверил порядок подачи блюд
Меню обоих ресторанов готово к сравнению
Результаты переданы Виктору Петровичу
EOF
cd ~/lab0/arcobaleno/kitchen
cat > italian_menu << 'EOF'
Домашняя паста от Елены Павловны
Ризотто с белыми грибами
Итальянский рыбный суп
Десерт по рецепту Кати
EOF
cat > katya_recipe << 'EOF'
Катя приготовила молекулярную закуску
Для блюда использованы знакомые продукты
Елена Павловна одобрила новую подачу
EOF
cd ~/lab0/arcobaleno/office
cat > elena_plan << 'EOF'
Елена Павловна встречает критика
Катя представляет новое блюдо
Команда Arcobaleno готовит итальянское меню
EOF
cd ~/lab0/arcobaleno/archive 
cat > review_archive << 'EOF'
Критик похвалил пасту в прошлый визит
Гости отметили спокойную работу кухни
Елена сохранила отзыв для нового меню
EOF
cd ~/lab0
find ~/lab0

echo "1.4 Численно и символьно устанавливаем права доступа к каталогам и файлам"

chmod u=rwx,g=rx,o=rx ~/lab0/claude_monet
chmod 750 ~/lab0/claude_monet/kitchen
chmod 644 ~/lab0/claude_monet/kitchen/old_menu
chmod u=rw,g=r,o= ~/lab0/claude_monet/kitchen/duck_recipe
chmod 710 ~/lab0/claude_monet/chef_office
chmod 600 ~/lab0/claude_monet/chef_office/barinov_notes
chmod u=rwx,g=rwx,o= ~/lab0/claude_monet/tasting_room
chmod 640 ~/lab0/claude_monet/tasting_room/tasting_scores
chmod u=r,g=r,o= ~/lab0/claude_monet/tasting_room/leva_comment
chmod 755 ~/lab0/arcobaleno
chmod u=rwx,g=rx,o= ~/lab0/arcobaleno/kitchen
chmod 644 ~/lab0/arcobaleno/kitchen/italian_menu
chmod u=rw,g=r,o= ~/lab0/arcobaleno/kitchen/katya_recipe
chmod 750 ~/lab0/arcobaleno/office
chmod u=r--,g=r--,u= ~/lab0/arcobaleno/office/elena_plan
chmod u=rwx,g=rx,o= ~/lab0/arcobaleno/archive
chmod 640 ~/lab0/arcobaleno/archive/review_archive
chmod u=rw-,g=r--,o=r-- ~/lab0/critic_visit
ls -lR ~/lab0

echo "1.5 Связываем локальный и удаленный репозитории, пушим всё созданное дерево"

git remote add origin https://github.com/pavlovass/avs_lab0.git
git status
git add .
git commit -m "Создано дерево каталогов и файлов, настроены права к ним"
git push origin master

echo "2.1 Копируем файлы и каталоги"

cp ~/lab0/arcobaleno/kitchen/katya_recipe ~/lab0/claude_monet/kitchen/new_recipe
cp -r ~/lab0/arcobaleno/archive ~/lab0/claude_monet/chef_office/reviews_copy

echo "2.2 Создаем ссылки" 

cd ~/lab0/arcobaleno/office
ln -s ../kitchen/katya_recipe chef_recipe
cd ~/lab0
ln -s ~/lab0/arcobaleno/kitchen rival_kitchen
ln ~/lab0/critic_visit claude_monet/tasting_room/critic_copy

echo "2.3 Работаем с содержимым файлов и перемещаем, переименовываем их"

cat < ~/lab0/claude_monet/kitchen/old_menu > ~/lab0/claude_monet/tasting_room/menu_comparison
cat < ~/lab0/arcobaleno/kitchen/italian_menu >> ~/lab0/claude_monet/tasting_room/menu_comparison
cat < ~/lab0/claude_monet/tasting_room/leva_comment >> ~/lab0/critic_visit
mv ~/lab0/claude_monet/chef_office/barinov_notes ~/lab0/claude_monet/tasting_room
mv ~/lab0/claude_monet/tasting_room/barinov_notes ~/lab0/claude_monet/tasting_room/chef_verdict

echo "2.4 Коммитим изменения и пушим в репозиторий GitHub"

git add .
git status
git commit -m "Добавены ссылки и копии, перемещены и дописаны файлы"
git push origin master

echo "3.1 Выполняем поиск и сортировку файлов, их содержимого"

ls -lR lab0 | grep '^-' | grep -v 'copy' | sort -k5,5nr | head -n 5
grep -RihE 'баринов|катя' ~/lab0/claude_monet ~/lab0/arcobaleno | grep -v 'десерт' | sort | head -n 6
grep -lR 'блюд' ~/lab0/claude_monet/kitchen ~/lab0/arcobaleno/kitchen | wc -l
cat ./claude_monet/kitchen/*_menu ./arcobaleno/kitchen/*_menu | tail -n 2 | grep -Ei 'десерт|суп' | sort -r
grep -v 'десерт' ./claude_monet/tasting_room/menu_comparison | sort -r | head -n 4 | wc -w
ls -ilR | grep '^[0-9]* -.* 2' | sort -k1,1n
grep -RihE 'гост|меню' ./claude_monet/chef_office/reviews_copy | grep -v 'Елена' | sort | wc -l

echo "3.2 Удаление файлов, каталогов, ссылок"

rm ./arcobaleno/kitchen/katya_recipe
rm ./arcobaleno/office/chef_recipe
rm ./rival_kitchen
rm ./critic_visit
rm ./claude_monet/tasting_room/critic_copy
rm ./arcobaleno/archive/review_archive
rmdir ./arcobaleno/archive
rm -r ./claude_monet/chef_office/reviews_copy

echo "3.3 Фиксируем изменения, пушим в удаленный репозиторий"

git add .
git status
git commit -m "Дерево lab0 после удаления файлов, каталогов и ссылок"
git push origin master

echo "3.4 Просматриваем историю коммитов, состояние дерева и добавляем shell-скрипт"

git log
ls -lR
mv ~/script.sh ~/lab0
git add script.sh
git status
git commit -m 'Добавление shell-скрипта'
git push origin master