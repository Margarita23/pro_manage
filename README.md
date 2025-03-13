# ProManage

A simple **Project Management System** built with **Ruby on Rails**, providing a RESTful API to manage projects and tasks. This system allows users to create, update, and track projects, as well as manage tasks within those projects, with features like task status filtering and optimized database queries.

## Features

- **User Authentication**: Secure user authentication via API using **Devise Token Authentication**.
- **Projects**: Users can create, update, view, and delete projects. Each project has a title and description.
- **Tasks**: Tasks can be created, updated, and tracked with status (New, In Progress, Completed). Tasks are linked to projects.
- **Task Filtering**: Filter tasks based on their status (New, In Progress, Completed).
- **Optimized Database Queries**: Efficient use of `includes`, `select`, and `where` to minimize database queries.
- **Caching**: Cache frequently used queries to improve performance.
- **Clean Code**: Follows best practices in Rails (DRY, SOLID principles) and includes comprehensive tests.

## Installation

### Prerequisites

- Ruby (>= 3.x)
- Rails (>= 8.x)
- PostgreSQL
- Bundler

### Setup

1. **Clone the repository:**
  ```bash
  git clone https://github.com/Margarita23/pro_manage.git
  cd pro_manage
	```


2. **Install the required gems:**
  ```bash
  bundle install
	```

3. **Set up the database:**
  ```bash
  rails db:create
	rails db:migrate
	```

4. **Start the server:**
	```bash
	rails s
	```

5. **Run the tests (if needed):**
	```bash
	rspec
	```