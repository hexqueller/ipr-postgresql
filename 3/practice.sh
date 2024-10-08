#!/bin/bash

execute_command() {
    local command="$1"
    local description="$2"

    clear
    echo -e "\n=================================================="
    echo -e "$description"
    echo -e "-> $command\n"
    eval "$command"
    echo -e "\n=================================================="
    echo "Enter для продолжения..."
    read -r
    clear
}

execute_command 'psql -h pg01 -U vagrant -d postgres -c "select profile.take_sample();"' 'Сделаем снимок статистики' 

execute_command 'psql -h pg01 -U vagrant -d postgres -Aqtc "select profile.get_report_latest()" -o report.html' 'Запросим отчет' 

echo "Практика по pg_profile завершена. Есть вопросы по данной теме?"
