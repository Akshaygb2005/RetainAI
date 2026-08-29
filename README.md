# Retain AI

Retain AI is an intelligent retention and predictive analytics platform powered by a machine learning pipeline (Logistic Regression), a high-performance FastAPI backend, and a cross-platform Flutter client application.

---

## 🛠 Tech Stack

- **Machine Learning:** Scikit-Learn (Logistic Regression, Data Preprocessing Pipelines)
- **Backend:** Python, FastAPI, Uvicorn
- **Frontend:** Flutter (Dart)
- **API Documentation:** OpenAPI / Swagger UI

---


```

---

## 🚀 Getting Started

### Prerequisites

Ensure you have the following installed on your machine:

- [Python 3.9+](https://www.python.org/)
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (configured with Android Studio / Xcode / Chrome)
- Git

---

### ⚙️ Backend Setup

1. **Navigate to the backend directory:**
   ```bash
   cd backend
   ```

2. **Create and activate a virtual environment:**
   ```bash
   # On macOS/Linux
   python3 -m venv venv
   source venv/bin/activate

   # On Windows
   python -m venv venv
   venv\Scripts\activate
   ```

3. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

4. **Run the backend server:**
   ```bash
   python -m uvicorn main:app --reload --host [IP_ADDRESS] --port 8000
   ```
   > Replace `[IP_ADDRESS]` with your local machine's IP address (e.g., `0.0.0.0` or `192.168.x.x`) to test across devices.

5. **Test and inspect API documentation:**
   - Interactive Swagger UI: [http://localhost:8000/docs](http://localhost:8000/docs)
   - Alternative ReDoc UI: [http://localhost:8000/redoc](http://localhost:8000/redoc)

---

### 📱 Frontend Setup

1. **Navigate to the frontend directory:**
   ```bash
   cd frontend
   ```

2. **Fetch Flutter packages:**
   ```bash
   flutter pub get
   ```

3. **Configure API Base URL:**
   Update your API base endpoint in your Flutter config/constants file to point to your backend server:
   ```dart
   const String baseUrl = "http://<YOUR_IP_ADDRESS>:8000";
   ```

4. **Run the Flutter application:**
   ```bash
   flutter run
   ```

---

## 📡 API & ML Pipeline Overview

- **Model Architecture:** Logistic Regression pipeline with custom feature scaling and categorical encoding.
- **Inference:** Fast real-time customer retention scoring exposed via FastAPI endpoints.
- **Interactive Documentation:** Visit `http://localhost:8000/docs` to test inference payloads, inspect request/response schemas, and execute live API calls.

---

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/NewFeature`)
3. Commit your changes (`git commit -m 'Add NewFeature'`)
4. Push to the branch (`git push origin feature/NewFeature`)
5. Open a Pull Request
