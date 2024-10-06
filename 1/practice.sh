#!/bin/bash
execute_command() {
    local command="$1"
    local description="$2"

    clear
    echo -e "\n=================================================="
    echo -e "$description"
    echo -e "-> $command\n"
    eval $command
    echo -e "\n=================================================="
    echo "Enter для продолжения..."
    read -r
    clear
}

execute_command 'psql -h pg01 -d postgres -U vagrant -c "\du"' 'Посмотрим какие есть пользователи'
execute_command 'psql -h pg01 -d postgres -U vagrant -c "CREATE USER dmitry;"' 'Создадим пользователя Dmitry'

execute_command 'psql -h pg01 -d postgres -U dmitry -c "CREATE DATABASE test;"' 'Попробуем от нового пользователя создать базу'

execute_command 'psql -h pg01 -d postgres -U vagrant -c "CREATE ROLE dba WITH LOGIN SUPERUSER;"' 'Создадим группу DBA'
execute_command 'psql -h pg01 -d postgres -U vagrant -c "GRANT dba TO dmitry;"' 'Добавим dmitry в группу'
execute_command 'psql -h pg01 -d postgres -U vagrant -c "ALTER ROLE dmitry WITH CREATEDB;"' 'Предоставим право на создание баз'
execute_command 'psql -h pg01 -d postgres -U vagrant -c "\du"' 'Проверим'

execute_command 'psql -h pg01 -d postgres -U dmitry -c "CREATE DATABASE test;"' 'Снова пробуем создать'

execute_command 'psql -h pg01 -d postgres -U vagrant -c "DROP DATABASE test;"' 'Удаляем базу'
execute_command 'psql -h pg01 -d postgres -U vagrant -c "DROP USER dba;"' 'Удаляем группу'
execute_command 'psql -h pg01 -d postgres -U vagrant -c "DROP USER dmitry;"' 'Удаляем пользователя'
execute_command 'psql -h pg01 -d postgres -U vagrant -c "\du"' 'Проверим'

echo "Практика завершена. Есть вопросы по данной теме?"
