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

execute_command 'psql -h pg01 -U vagrant -d postgres -c "CREATE TABLE test (id SERIAL PRIMARY KEY, n INT, s TEXT);"' 'Создаем таблицу'

execute_command "psql -h pg01 -U vagrant -d postgres -c \"INSERT INTO test (n, s) SELECT generate_series(1, 1000000), 'some text' || generate_series(1, 1000000);\"" 'Заполняем ее значениями'

execute_command 'psql -h pg01 -U vagrant -d postgres -c "EXPLAIN ANALYZE SELECT * FROM test WHERE n = 500000;"' 'Анализ плана запроса'

execute_command 'psql -h pg01 -U vagrant -d postgres -c "CREATE INDEX idx_test_n ON test (n);"' 'Создаем индекс для оптимизации'

execute_command 'psql -h pg01 -U vagrant -d postgres -c "EXPLAIN ANALYZE SELECT * FROM test WHERE n = 500000;"' 'Повторяем запрос и смотрим его план'

execute_command 'psql -h pg01 -U vagrant -d postgres -c "DROP TABLE test;"' 'Удаляем таблицу'

echo "Практика по qpt завершена. Есть вопросы по данной теме?"
