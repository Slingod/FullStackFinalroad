# Fullstack Final Project - New Era Lissoise (NEL)

## Project Description

### Nouvelle Ère Lissoise (NEL)

Welcome to the Nouvelle Ère Lissoise (NEL) website!
We offer you the opportunity to discover events happening in our town and view photos and videos made by our members to relive the moments spent together. Each member can, if they wish, register for future events to show their commitment to our intercommunal and municipal activities.
NEL is free with no financial commitments.
We regularly support organizations and associations fighting against cancer and other causes for the common good, such as Secours populaire.

### About NEL

New Era Lissoise (NEL) is a full-stack event management platform developed with Ruby on Rails 8.0.1. It allows users to create, manage, and register for various events while offering authentication features, role management, and an intuitive user interface. The application follows the CRUD model (Create, Read, Update, Delete) for users and events.

### Features

- **Event Management** : Easily create, edit, and delete events.

- **Event Registration**: Users can register for upcoming events to show their commitment.

- **Authentication**: Uses Devise for secure user management.

- **Role Management**: Assign different roles to users to control permissions.

- **Intuitive User Interface**: A user-friendly interface for smooth navigation.

- **Organization Support**: Support local causes and organizations.

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
- [Jira](https://nouvelleerelissoise.atlassian.net/jira/polaris/projects/MPDD/ideas/view/6524202)
- [Powerpoint.pptx](https://github.com/user-attachments/files/19105674/Projet.Site.Web.pptx)

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
