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

execute_command 'psql -h pg01 -U vagrant -d postgres -c "SELECT * FROM pg_stat_activity;"' 'Просмотр текущих подключений и активных запросов'

execute_command 'psql -h pg01 -U vagrant -d postgres -c "SELECT * FROM pg_stat_user_tables;"' 'Просмотр статистики таблиц'

execute_command 'psql -h pg01 -U vagrant -d postgres -c "SELECT * FROM pg_stat_user_indexes;"' 'Просмотр статистики индексов'

execute_command 'psql -h pg01 -U vagrant -d postgres -c "CREATE EXTENSION IF NOT EXISTS pg_stat_statements;"' 'Установка расширения pg_stat_statements'

execute_command 'psql -h pg01 -U vagrant -d postgres -c "SELECT query, calls, total_exec_time, rows FROM pg_stat_statements ORDER BY total_exec_time DESC LIMIT 10;"' 'Просмотр статистики выполнения запросов'

execute_command 'psql -h pg01 -U vagrant -d postgres -c "SELECT * FROM pg_stat_bgwriter;"' 'Просмотр статистики фонового писателя'

execute_command 'psql -h pg01 -U vagrant -d postgres -c "SELECT * FROM pg_stat_database;"' 'Просмотр статистики базы данных'

execute_command 'psql -h pg01 -U vagrant -d postgres -c "SELECT * FROM pg_stat_replication;"' 'Просмотр статистики репликации'

execute_command 'psql -h pg01 -U vagrant -d postgres -c "SELECT * FROM pg_stat_ssl;"' 'Просмотр статистики SSL'

echo "Практика по мониторингу базы данных завершена. Есть вопросы по данной теме?"
