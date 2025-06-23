FROM python:3.11-slim

# סביבה נקייה ומהירה
ENV PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    DEBIAN_FRONTEND=noninteractive

# התקנת תלות בסיס
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential curl wget git python3-dev \
    libglib2.0-0 libnss3 libatk1.0-0 libatk-bridge2.0-0 libcups2 libdrm2 \
    libdbus-1-3 libxcb1 libx11-6 libxcomposite1 libxdamage1 libxext6 libxfixes3 \
    libxrandr2 libgbm1 libpango-1.0-0 libcairo2 libasound2 libatspi2.0-0 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# התקנת Crawl4AI מ־PyPI
RUN pip install crawl4ai==0.6.0 && \
    python -m playwright install --with-deps chromium

# פתיחת פורט API
EXPOSE 11235

# נקודת הרצה: הפעלת ה־API
CMD ["uvicorn", "crawl4ai.api.main:app", "--host", "0.0.0.0", "--port", "11235"]
