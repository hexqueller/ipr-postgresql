# Репозиторий практик по ИПР PostgreSQL

1. Пользователи, привилегии, азы SQL.
2. Понимание блокировок, поиск и способы разрешение.
3. Настройка и формирование отчётности в pg_profile
4. Понимание MVCC, vacuum, wal-файлы, checkpoint.
5. План запроса, построение планов, анализов планов (QPT).
6. Настройка логирования запросов.
7. Понятие репликации логическая и физическая, настройка репликаций, понимание master-slave узлов.
8. Резервное копирование и восстановление.
9. Мониторинг БД - базовая настройка, поиск проблем, инструменты для мониторинга.
10. Liquibase - развертывание, принципы работы, написать небольшой

### vagrant box [download (VPN requred)](https://vagrantcloud-files-production.s3-accelerate.amazonaws.com/archivist/boxes/e11a3fd9-c492-4473-ad74-6e49652cf586?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIA6NDPRW4BVIXR5ODC%2F20241003%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20241003T040138Z&X-Amz-Expires=900&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEGwaCXVzLWVhc3QtMSJHMEUCIFqt41H1fNBtQltYXnhasPhjDWPCdy63%2FAlz305RO2lFAiEArvR%2BTsApVMaUSsVYfDuhb03tLCxy3dfRIQCBDfPTOeYqqQIItf%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FARAEGgw5OTAyMjM5MDY1NjMiDCilFszqQD21EGN0Syr9AY%2F9leKcNOBlmgXtWew8bbpdw3ddz4nBLM1V97cK74pX2e7k%2BV2vZvaIS%2BmoG%2Bc5xLGKX7Z8yr5e9JSDpM%2Bnc%2Bs6aiLLZQZeujRKxHFFMIk0HIyh2%2BLUmZ7gC6s%2BqlVK8JnVGGxQ5XrZ1KpOGwH8cUyQzcW8rq5DeLmeda42bt4Pfw7seAsyiRVlM28VwZg3%2FSj%2Ft4mARjrROjGRHwJimnCGaC%2BBmi81HulXnrigm7EEI41pANkZImbzor1ZETtVJ9NC1KlRicnHhdwmErMS50i5hG1q2EPLvc3%2BB8MJiGPmROcsLuUa1Jm3TVLKqHQztDRAvfo3Bj%2BT4FNPNdEwv6r4twY6nQEAtbrT30JVVpoRxU2rmqwSOVnLi9e6x8QhTnEmb8ZuQQfEbSPSfOGBnAwzSR9hWVHdiyrxmoXY%2BuT5KzGXuxnD601t2oASYpNnFvjXJd9BgfZnL3QepQGsSGG5TYHZS0jmLcxkeRq0DKTq7JKgTNQo4rEaMINYoWQaVv8%2BiG8wFYsHbo5Qv%2F8teRwE9SR7QvsC8S5qXpryBI5CPNhI&X-Amz-SignedHeaders=host&X-Amz-Signature=1fe4ef8abefcac5d78fdc78e3a06475cfabfa0f6e5d723564f81c3b4868aa1f3) 
```bash
vagrant box add ./e11a3fd9-c492-4473-ad74-6e49652cf586 --name=almalinux/9
```