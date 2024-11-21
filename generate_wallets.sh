#!/usr/bin/env bash

# Настройки
PASSWORD="<your password>" #введите пароль для кошельков
WALLET_PREFIX="erin_go_"
NUM_WALLETS=550 #введите количество желаемых кошельков
ADDRESS_FILE="addresses.txt"
MNEMONIC_FILE="mnemonics.txt"
LOG_FILE="wallets.log"

# Очистка файлов
> "$ADDRESS_FILE"
> "$MNEMONIC_FILE"
> "$LOG_FILE"

echo "Начинаю генерацию $NUM_WALLETS кошельков..."

for ((i = 1; i <= NUM_WALLETS; i++)); do
  WALLET_NAME="${WALLET_PREFIX}${i}"
  echo "Генерация кошелька $WALLET_NAME..."
  
  # Используем expect для обработки диалогов
  OUTPUT=$(expect << EOF
set timeout -1
spawn allorad keys add $WALLET_NAME --keyring-backend file
expect {
    "Enter keyring passphrase" {
        send "$PASSWORD\r"
        exp_continue
    }
    "Repeat the passphrase" {
        send "$PASSWORD\r"
        exp_continue
    }
    "override the existing name" {
        send "y\r"
        exp_continue
    }
    eof
}
EOF
)

  # Сохраняем вывод в лог
  echo "$OUTPUT" >> "$LOG_FILE"
  
  # Извлекаем адрес и сид-фразу
  ADDRESS=$(echo "$OUTPUT" | grep -oP "(?<=address: ).*")
  MNEMONIC=$(echo "$OUTPUT" | grep -A 2 "Important" | tail -n 1)
  
  if [[ -n "$ADDRESS" && -n "$MNEMONIC" ]]; then
    echo "$ADDRESS" >> "$ADDRESS_FILE"
    echo "$MNEMONIC" >> "$MNEMONIC_FILE"
    echo "Кошелек $WALLET_NAME успешно сгенерирован."
  else
    echo "Ошибка при генерации кошелька $WALLET_NAME. Подробности в $LOG_FILE."
  fi
done

echo "Генерация завершена."
echo "Адреса сохранены в $ADDRESS_FILE"
echo "Сид-фразы сохранены в $MNEMONIC_FILE"
