FROM python:3.11-alpine

WORKDIR /app

# Встановлюємо системні залежності для numpy
RUN apk add --no-cache \
    gcc \
    musl-dev \
    gfortran \
    openblas-dev \
    lapack-dev

# Копіюємо та встановлюємо Python залежності
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Видаляємо компілятори (залишаємо тільки runtime бібліотеки)
RUN apk del gcc musl-dev gfortran

# Копіюємо файли застосунку
COPY build/ build/
COPY spaceship/ spaceship/

EXPOSE 8000

CMD ["uvicorn", "spaceship.main:app", "--host", "0.0.0.0", "--port", "8000"]