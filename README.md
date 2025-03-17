# Fullstack Final Project - New Era Lissoise (NEL)

## Project Description

New Era Lissoise (NEL) is a fullstack event management platform developed with **Ruby on Rails 8.0.1**. It allows users to create, manage, and register for various events while offering authentication features, role management, and an intuitive user interface. The application follows the **CRUD model (Create, Read, Update, Delete)** for users and events.

## Technologies Used

- **Ruby on Rails 8.0.1**: Main framework
- **Devise**: User authentication (registration, login, logout, email confirmation, etc.)
- **SQLite**: Default database for development
- **Kamal**: Deployment tool
- **Bootstrap / Tailwind CSS**: Frontend design and styling
- **Whimsical**: Wireframing tool
- **JWT** (Optional): API authentication

## Wireframe

The wireframe for the project is available here:

- [User Flow](https://whimsical.com/fullstackfinal-P1XYFdSBXN73n7xRAngMNd)
- [WireFrame](https://whimsical.com/wireframefullstack-TFytgVQdEJAt3t2LC5umit)

## Features

### Frontend

- **Home Page**: Overview of the platform
- **About Page**: Description of the application
- **Contact Page**: Contact form for user inquiries
- **User Authentication**:
  - Registration & Login via Devise
  - Email confirmation for new accounts
  - Secure password reset
- **User Profile Management**:
  - Update personal information
  - Delete account
- **Event Management**:
  - View event listings
  - Create, edit, delete events (full CRUD)
  - Register and unregister for events

### Backend

- **Admin Panel**:
  - Manage users (view, edit, delete)
  - Manage events (create, edit, delete)
  - Manage external APIs (Facebook, Google Maps, Weather, etc.)
- **Deployment with Kamal**:
  - Configure Kamal
  - Build and push Docker image
  - Deploy to production server

## Installation & Usage

1. **Clone the repository**:
   ```bash
   git clone <repo_url>
   cd <project_name>
   ```
2. **Install dependencies**:
   ```bash
   bundle install
   ```
3. **Set up the database**:
   ```bash
   rails db:create db:migrate
   ```
4. **Start the server**:
   ```bash
   rails s
   ```
5. **Access the application**:
   - Frontend: `http://localhost:3000`
   - Backend: `http://localhost:3000/admin`

## External APIs

The application integrates the following external APIs:

- **Facebook**: Authentication and event sharing
- **Google Maps**: Event location mapping
- **Weather API**: Display weather forecasts for events

## Security

- **Devise** is used for user authentication and session management.
- **CSRF Protection** is enabled to prevent cross-site request forgery.
- **JWT Tokens** can be used for API authentication.
- **Secure API Keys**: API keys are not hardcoded and are securely managed.

## Project Members

This project was developed by:

- [Houdheyfa Kaddouri](https://github.com/houdheyfakaddouri)
- [Slingod](https://github.com/Slingod)

## License

This project is licensed under the **MIT License**.
