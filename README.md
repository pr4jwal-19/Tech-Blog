# TechBlogJSP

TechBlogJSP is a Java web application using JSP and Servlet technologies to create a tech blog platform. It utilizes Jersey for RESTful services and MySQL as the database backend.

## Installation

To run this project locally, follow these steps:

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/pr4jwal-19/Tech-Blog.git
   ```

2. **Build the Project:**
   ```bash
   cd TechBlogJSP
   mvn clean install
   ```

3. **Deploy the WAR File:**
   After a successful build, deploy the generated WAR file (`TechBlogJSP.war`) to your servlet container (e.g., Apache Tomcat).

4. **Set Up MySQL Database:**
   - Create a MySQL database named `myblogdb`.
   - Create the necessary tables in MySql GUI application

5. **Run the Application:**
   Start your servlet container, and access the application at `http://localhost:8080/TechBlogJSP`.

## Usage

- Navigate to `http://localhost:8080/TechBlogJSP` in your web browser.
- Use the TechBlogJSP application to view, create, and manage tech blog posts.

## Features

- **RESTful Services:** Utilizes Jersey for implementing RESTful web services.
- **JSON Support:** Uses Jersey Media JSON Jackson for JSON serialization/deserialization.
- **Database Connectivity:** Integrates MySQL database using `mysql-connector-java`.

## Contributing

We welcome contributions to TechBlogJSP! To contribute:

1. Fork the repository.
2. Create your feature branch (`git checkout -b feature-new-feature`).
3. Commit your changes (`git commit -am 'Add new feature'`).
4. Push to the branch (`git push origin feature-new-feature`).
5. Open a pull request.

## Dependencies

- **Jersey:** Version 3.0.4 for RESTful services and dependency injection.
- **JUnit 5:** Version 5.9.2 for unit testing.
- **Servlet API:** Version 4.0.1 for servlet support.
- **MySQL Connector:** Version 8.0.28 for MySQL database connectivity.
