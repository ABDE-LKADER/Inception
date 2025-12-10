# User Documentation

## Services Overview
This infrastructure provides the following services:
* **Website**: A WordPress site served over HTTPS.
* **Database**: MariaDB storing the website's data.
* **Management**: Adminer for database management and Portainer for container monitoring.
* **File Transfer**: FTP server to access WordPress files.
* **Caching**: Redis cache to improve WordPress performance.

## ⚠️ Important: Host Configuration (First Step)
Before accessing the services, you must configure your computer to recognize the project domains.
1.  Open your machine's `/etc/hosts` file (on Linux/macOS) or `C:\Windows\System32\drivers\etc\hosts` (on Windows).
2.  Add the following line (replace `login` with your 42 username):
    ```text
    127.0.0.1 login.42.fr adminer.login.42.fr portainer.login.42.fr static.login.42.fr
    ```
    *(If you are running this in a VM, use the VM's IP address instead of 127.0.0.1)*

## How to Start and Stop the Project
All commands must be run from the root of the repository.

* **Start**: Run `make up`. This builds images and starts the containers.
* **Stop**: Run `make down`. This stops the containers.
* **Restart**: Run `make restart`.

## Accessing the Services
Once the project is running (`make up`) and you have configured your hosts file, you can access the services via your browser:

| Service | URL | Description |
| :--- | :--- | :--- |
| **WordPress** | `https://login.42.fr` | Main website |
| **Adminer** | `https://adminer.login.42.fr` | Database management tool |
| **Portainer** | `https://portainer.login.42.fr` | Container monitoring dashboard |
| **Static Site** | `https://static.login.42.fr` | Bonus static HTML page |

## Locate and Manage Credentials
For security reasons, this project does not use default passwords. All usernames, passwords, and configuration variables are stored in a secure environment file.

**File Location:** `srcs/.env`

To find your login details, open this file and look for the following variables:
* **Database Access**: `MYSQL_USER` and `MYSQL_PASSWORD`
* **WordPress Admin**: `WP_ADMIN_USER` and `WP_ADMIN_PASS`
* **FTP Access**: `FTP_USER` and `FTP_PASS`

*Warning: Never commit the `.env` file to a public repository.*

## Checking Service Status
To check if the services are running correctly:
1.  Run `docker ps` to see the status of all containers. They should all be "Up".
2.  Use `make logs` to view real-time logs from the services to check for errors.