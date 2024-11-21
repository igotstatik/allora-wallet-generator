import re

# Входной файл логов и выходные файлы
log_file = "wallets.log"
address_file = "addresses.txt"
mnemonic_file = "mnemonics.txt"

# Регулярные выражения для поиска адресов и мнемонических фраз
address_pattern = re.compile(r"^-\saddress:\s(allo1[a-z0-9]+)", re.MULTILINE)
mnemonic_pattern = re.compile(
    r"(\b[a-z]+\b(?:\s\b[a-z]+\b){23})\nspawn allorad keys add"
)

# Списки для хранения извлечённых данных
addresses = []
mnemonics = []

# Чтение файла логов
with open(log_file, "r", encoding="utf-8") as file:
    log_content = file.read()

# Извлечение данных
addresses = address_pattern.findall(log_content)
mnemonics = mnemonic_pattern.findall(log_content)

# Проверка корректности извлечения
if len(addresses) != len(mnemonics):
    print("Ошибка: количество адресов и мнемонических фраз не совпадает!")
    print(f"Адресов: {len(addresses)}, мнемоник: {len(mnemonics)}")
else:
    print(f"Успешно извлечено {len(addresses)} записей.")

# Запись адресов в файл
with open(address_file, "w", encoding="utf-8") as file:
    file.write("\n".join(addresses))

# Запись мнемонических фраз в файл
with open(mnemonic_file, "w", encoding="utf-8") as file:
    file.write("\n".join(mnemonics))

print(f"Адреса сохранены в {address_file}")
print(f"Мнемонические фразы сохранены в {mnemonic_file}")
