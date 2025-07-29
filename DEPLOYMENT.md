# Student Management System - Deployment Guide

This guide will help you deploy the Student Management System (SMS) to Apache Tomcat.

## Prerequisites

1. **Java JDK 8 or higher**
   - Download from: https://adoptium.net/ or https://www.oracle.com/java/technologies/
   - Set JAVA_HOME environment variable

2. **Apache Maven 3.6+**
   - Download from: https://maven.apache.org/download.cgi
   - Add Maven to your PATH

3. **Apache Tomcat 9.0+**
   - Download from: https://tomcat.apache.org/download-90.cgi
   - Extract to a directory (e.g., `C:\apache-tomcat-9.0.xx`)

## Building the Application

1. **Clone or download the project**
   ```bash
   git clone <repository-url>
   cd Simple-Student-Management-System
   ```

2. **Build the project using Maven**
   ```bash
   mvn clean package
   ```

3. **Verify the WAR file was created**
   - Check that `target/sms.war` exists

## Deploying to Tomcat

### Method 1: Manual Deployment

1. **Copy the WAR file to Tomcat's webapps directory**
   ```bash
   copy target\sms.war C:\apache-tomcat-9.0.xx\webapps\
   ```

2. **Start Tomcat**
   ```bash
   cd C:\apache-tomcat-9.0.xx\bin
   startup.bat
   ```

3. **Access the application**
   - Open your browser and go to: `http://localhost:8080/sms/`
   - Login with username: `admin` and password: `password`

### Method 2: Using Tomcat Manager (if configured)

1. **Access Tomcat Manager**
   - Go to: `http://localhost:8080/manager`
   - Login with admin credentials

2. **Deploy the WAR file**
   - Use the "Deploy" section to upload `sms.war`
   - Or use the "WAR file to deploy" option

## Configuration

### Tomcat Configuration

1. **Memory Settings** (Optional)
   - Edit `C:\apache-tomcat-9.0.xx\bin\setenv.bat`
   - Add: `set JAVA_OPTS=-Xmx512m -Xms256m`

2. **Port Configuration** (Optional)
   - Edit `C:\apache-tomcat-9.0.xx\conf\server.xml`
   - Change port 8080 if needed

### Application Configuration

The application uses in-memory storage, so no database configuration is required. All data is stored in ArrayList and will be reset when the server restarts.

## Troubleshooting

### Common Issues

1. **Port 8080 already in use**
   - Change Tomcat port in `server.xml`
   - Or stop the service using port 8080

2. **Java version issues**
   - Ensure JAVA_HOME points to JDK 8+
   - Verify with: `java -version`

3. **Maven build fails**
   - Check internet connection for dependencies
   - Clear Maven cache: `mvn clean`

4. **Application not accessible**
   - Check Tomcat logs in `logs/catalina.out`
   - Verify WAR file is in `webapps` directory
   - Ensure Tomcat is running

### Logs

- **Tomcat logs**: `C:\apache-tomcat-9.0.xx\logs\`
- **Application logs**: Check Tomcat's `catalina.out`

## Development Setup

### Using IDE (Eclipse/IntelliJ)

1. **Import as Maven project**
2. **Configure Tomcat server**
3. **Run on server**

### Using Command Line

1. **Build**: `mvn clean package`
2. **Deploy**: Copy WAR to Tomcat webapps
3. **Access**: `http://localhost:8080/sms/`

## Features Overview

- ✅ **Login System**: Hardcoded admin/password
- ✅ **Dashboard**: Statistics and navigation
- ✅ **Add Student**: Form with validation
- ✅ **View Students**: Table with all records
- ✅ **Update Student**: Edit existing records
- ✅ **Delete Student**: Remove records
- ✅ **Logout**: Session termination
- ✅ **OOP Implementation**: Inheritance, encapsulation
- ✅ **Server-side Validation**: Comprehensive data validation

## Security Notes

- This is a demo application with hardcoded credentials
- No database persistence (in-memory only)
- Session-based authentication
- Data resets on server restart

## Support

For issues or questions:
1. Check the logs for error messages
2. Verify all prerequisites are installed
3. Ensure proper file permissions
4. Test with a fresh Tomcat installation 