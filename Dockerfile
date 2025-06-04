FROM python:3.11-alpine

# Встановлюємо робочу директорію
WORKDIR /app

# Встановлюємо системні залежності для компіляції Python пакетів
RUN apk add --no-cache gcc musl-dev

# Копіюємо та встановлюємо Python залежності
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Видаляємо компілятори після встановлення залежностей
RUN apk del gcc musl-dev

# Копіюємо статичні файли
COPY build/ build/

# Копіюємо код застосунку
COPY spaceship/ spaceship/

EXPOSE 8000

CMD ["uvicorn", "spaceship.main:app", "--host", "0.0.0.0", "--port", "8000"]