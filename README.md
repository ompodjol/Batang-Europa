# 🏀 Batang-Europa Basketball Program

A modern, professional website for the Batang Europa Basketball Program built with Flask and responsive design.

## 🌐 Website URL
**http://BatangEuropa.com:1981**

## 📋 Project Overview

Batang Europa is a comprehensive basketball program website featuring:
- **Home Page**: Hero section with program highlights
- **About Us**: Mission, vision, and core values
- **Team Roster**: Player profiles with statistics and coaching staff
- **Schedule & Events**: Upcoming games and important dates
- **Gallery**: Photo highlights from games and events
- **Registration**: Player registration form with eligibility information
- **Contact**: Get in touch with the program

## 🚀 Features

✅ **Responsive Design** - Works perfectly on desktop, tablet, and mobile  
✅ **Professional Styling** - Modern color scheme and smooth animations  
✅ **Multiple Pages** - Comprehensive site structure  
✅ **Player Management** - Roster page with player cards  
✅ **Event Management** - Schedule and events listing  
✅ **Gallery Support** - Photo showcase with hover effects  
✅ **Registration System** - Online player registration form  
✅ **SEO Friendly** - Proper meta tags and structure  

## 📁 Project Structure

```
Batang-Europa/
├── app.py                 # Flask application
├── requirements.txt       # Python dependencies
├── README.md             # Project documentation
├── templates/            # HTML templates
│   ├── base.html         # Base template with navigation
│   ├── index.html        # Home page
│   ├── about.html        # About page
│   ├── roster.html       # Team roster page
│   ├── schedule.html     # Schedule and events page
│   ├── gallery.html      # Photo gallery page
│   ├── register.html     # Registration page
│   └── contact.html      # Contact page
└── static/               # Static files
    └── style.css         # Main stylesheet
```

## 🛠️ Installation

### Prerequisites
- Python 3.7+
- pip package manager

### Setup Steps

1. **Clone the repository:**
   ```bash
   git clone https://github.com/ompodjol/Batang-Europa.git
   cd Batang-Europa
   ```

2. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

3. **Run the application:**
   ```bash
   python app.py
   ```

4. **Access the website:**
   - Open your browser and visit `http://localhost:1981`
   - Or configure your hosts file to access `http://BatangEuropa.com:1981`

## 📝 Available Pages

| Page | Route | Description |
|------|-------|-------------|
| Home | `/` | Welcome page with program highlights |
| About | `/about` | Mission, vision, and values |
| Roster | `/roster` | Team players and coaching staff |
| Schedule | `/schedule` | Upcoming games and events |
| Gallery | `/gallery` | Photo gallery from events |
| Register | `/register` | Player registration form |
| Contact | `/contact` | Contact information and form |

## 🎨 Customization

### Colors
Edit the CSS variables in `static/style.css`:
```css
:root {
    --primary-color: #ff6b35;       /* Orange */
    --secondary-color: #004e89;     /* Blue */
    --accent-color: #f7b801;        /* Yellow */
    --text-color: #333;
    --light-bg: #f9f9f9;
    --border-color: #ddd;
}
```

### Adding New Pages
1. Create a new HTML file in `templates/` directory
2. Add a route in `app.py`:
   ```python
   @app.route('/newpage')
   def newpage():
       return render_template('newpage.html')
   ```
3. Update navigation links in `templates/base.html`

## 🚀 Deployment

### Using Gunicorn (Production)

1. **Install Gunicorn:**
   ```bash
   pip install gunicorn
   ```

2. **Run with Gunicorn:**
   ```bash
   gunicorn --bind 0.0.0.0:1981 --workers 4 app:app
   ```

### Using Docker

1. **Create a Dockerfile:**
   ```dockerfile
   FROM python:3.9-slim
   WORKDIR /app
   COPY requirements.txt .
   RUN pip install -r requirements.txt
   COPY . .
   CMD ["gunicorn", "--bind", "0.0.0.0:1981", "--workers", "4", "app:app"]
   ```

2. **Build and run:**
   ```bash
   docker build -t batang-europa .
   docker run -p 1981:1981 batang-europa
   ```

### Cloud Deployment Options

#### Heroku
```bash
heroku create batang-europa
heroku config:set FLASK_ENV=production
git push heroku main
```

#### AWS (EC2)
1. Launch an EC2 instance
2. Install Python and dependencies
3. Configure Nginx as reverse proxy
4. Run the application with Gunicorn

#### PythonAnywhere
1. Create a free account at pythonanywhere.com
2. Upload the project files
3. Configure WSGI application
4. Set up domain name

#### Google Cloud / Azure
1. Create a container
2. Deploy using Cloud Run or App Service
3. Configure custom domain

## 🔧 Advanced Configuration

### Environment Variables
Create a `.env` file for configuration:
```
FLASK_ENV=production
SECRET_KEY=your_secret_key_here
DATABASE_URL=your_database_url
```

### Database Integration
Add SQLAlchemy for persistent storage:
```bash
pip install flask-sqlalchemy
```

### Contact Form Processing
Add email functionality:
```bash
pip install flask-mail
```

## 📞 Contact Information
- 📧 Email: info@batangeuropa.com
- 📱 Phone: +1 (555) 123-4567
- 📍 Location: Sports Complex, Europa, EU

## 📄 License
This project is open source and available under the MIT License.

## 👥 Contributors
- Batang Europa Basketball Program Team
- Web Development Team

## 🎯 Future Enhancements
- [ ] Live score updates
- [ ] Player statistics tracking
- [ ] Online ticketing system
- [ ] Mobile app
- [ ] Player video highlights
- [ ] News blog
- [ ] Team merchandise store
- [ ] Multi-language support

---

**Last Updated:** April 23, 2026
