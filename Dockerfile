FROM python:3.11-bullseye

# Встановлюємо робочу директорію
WORKDIR /app

# Спочатку копіюємо та встановлюємо залежності (шар, що змінюється рідко)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Копіюємо статичні файли
COPY build/ build/

# Копіюємо код застосунку (шар, що змінюється часто)
COPY spaceship/ spaceship/

EXPOSE 8000

CMD ["uvicorn", "spaceship.main:app", "--host", "0.0.0.0", "--port", "8000"]