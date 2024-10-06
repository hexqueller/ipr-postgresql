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

execute_command 'psql -h pg01 -U vagrant -d postgres -c "SELECT xmin, xmax, * FROM students;"' 'Просмотр версий строк'

execute_command 'psql -h pg01 -U vagrant -d postgres -c "SELECT pg_current_wal_lsn();"' 'Просмотр текущего wal'

execute_command 'psql -h pg01 -U vagrant -d postgres -c "SELECT * FROM pg_ls_waldir();"' 'Просмотр всех wal'

execute_command 'psql -h pg01 -U vagrant -d postgres -c "VACUUM VERBOSE;"' 'Пример запуска Vacuum с подробностями процесса'

execute_command 'psql -h pg01 -U vagrant -d postgres -c "CHECKPOINT;"' 'Пример создания контрольной точки'

execute_command 'psql -h pg01 -U vagrant -d postgres -c "SELECT * FROM pg_stat_bgwriter;"' 'Просмотр текущего состояния контрольной точки'

echo "Практика по mvcc, vacuum, wal завершена. Есть вопросы по данной теме?"
