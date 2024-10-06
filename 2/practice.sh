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

execute_command 'psql -h pg01 -d postgres -U vagrant -c "SELECT * FROM pg_locks;"' 'Посмотрим представление pg_locks, которое содержит информацию о текущих блокировках в базе данных'

# execute_command 'psql -h pg01 -d postgres -U vagrant -c "SELECT pg_stat_activity.pid, pg_stat_activity.usename, pg_stat_activity.query, pg_stat_activity.state, pg_locks.locktype, pg_locks.mode, pg_locks.granted FROM pg_stat_activity JOIN pg_locks ON pg_stat_activity.pid = pg_locks.pid WHERE pg_locks.granted = false;"' 'Соединим с pg_stat_activity'

echo "Практика по блокировкам завершена. Есть вопросы по данной теме?"

exit 0

BEGIN;
LOCK TABLE students IN EXCLUSIVE MODE; # Эта команда позволяет заблокировать на уровне таблицы
COMMIT;

SELECT pg_terminate_backend(pid);

BEGIN;
SELECT * FROM students WHERE some_condition FOR UPDATE; # Эта команда позволяет заблокировать строки, которые будут обновлены
-- запрос
COMMIT;

BEGIN;
SELECT * FROM students WHERE some_condition FOR SHARE; # Эта команда позволяет заблокировать строки для чтения, но не для обновления
-- запрос
COMMIT;
