*This project has been created as part of the 42 curriculum by abadouab.*
# Inception

## Description
This project is a System Administration exercise designed to broaden knowledge of **Docker**. It involves virtualizing several Docker images to create a personal virtual machine infrastructure. The goal is to set up a multi-service architecture where each service runs in a dedicated container, orchestrated by **docker compose**.

The infrastructure includes:
- **NGINX**: The entry point with TLSv1.3.
- **WordPress + PHP-FPM**: The CMS.
- **MariaDB**: The database.
- **Redis**: For cache management (Bonus).
- **FTP Server**: For file transfer (Bonus).
- **Adminer**: For database management (Bonus).
- **Portainer**: For container monitoring (Bonus).
- **Static Website**: A custom static page (Bonus).

## Instructions

### Prerequisites
To run this project, you must have the following installed:
- **Docker**
- **Make**

### Installation & Configuration
Follow these steps to set up the environment before running the project.

1. **Clone the repository:**
   ```bash
   git clone https://github.com/ABDE-LKADER/Inception.git
   cd Inception
    ```

2.  **Create the Environment File:**
    Create a `.env` file in the `srcs/` directory:

    ```bash
      nano srcs/.env
    ```

    Paste the following content (these are placeholders, change them to your needs):

    ```ini
        # --- Database Setup ---
        MYSQL_DATABASE=database_name
        MYSQL_HOST=mariadb
        MYSQL_USER=database_user
        MYSQL_PASSWORD=strong_password
        MYSQL_ROOT_PASSWORD=root_secret
      
        # --- WordPress Setup ---
        WP_URL=https://login.42.fr
        WP_ADMIN_USER=admin_username
        WP_ADMIN_PASS=admin_password
        WP_ADMIN_EMAIL=admin@email.com
        WP_USER=subscriber_username
        WP_USER_PASS=subscriber_password
        WP_USER_EMAIL=subscriber@email.com
      
        # --- FTP Setup ---
        FTP_USER=ftp_username
        FTP_PASS=ftp_password
    ```

3.  **Configure Network:**
    Add your domain to the host file:

    ```bash
      # Replace 'login' with your actual 42 username
      sudo bash -c 'echo "127.0.0.1 login.42.fr" >> /etc/hosts'
    ```

### Execution

This project uses a `Makefile` to automate the build and deployment process.

1.  **Launch the infrastructure:**
    Build and start all containers in the background.

    ```bash
     make up
    ```

    *Note: This command automatically creates the required data directories at `/home/${USER}/data/`.*

2.  **Stop the services:**
    Stop and remove containers and networks.

    ```bash
     make down
    ```

3.  **View Logs:**

    ```bash
     make logs
    ```

4.  **Clean everything:**
    Stop containers and remove all Docker images, volumes, and networks.

    ```bash
     make fclean
    ```

## Accessing Services

Once the infrastructure is running, you can access the services via the following URLs.

**⚠️ Prerequisite:** Ensure you have configured your `/etc/hosts` file (as shown in Step 3 above).

| Service | URL | Description |
| :--- | :--- | :--- |
| **WordPress** | [https://login.42.fr](https://login.42.fr) | Main Website |
| **Adminer** | [https://adminer.login.42.fr](https://adminer.login.42.fr) | Database Management |
| **Portainer** | [https://portainer.login.42.fr](https://portainer.login.42.fr) | Container Monitoring |
| **Static Site** | [https://static.login.42.fr](https://static.login.42.fr) | Bonus Static Page |
| **FTP Server** | `lftp -u <user>,<pass> 127.0.0.1` | File Transfer (CLI) |

*(Replace `login` with your 42 username in the URLs)*

## Resources

### Official Documentation
This project relies on the official documentation of the following technologies:

**Core Infrastructure:**
* [Docker Engine](https://docs.docker.com/engine/) - The container runtime.
* [Docker Compose](https://docs.docker.com/compose/) - Orchestration tool.
* [Alpine Linux](https://wiki.alpinelinux.org/wiki/Main_Page) - Lightweight OS used for all containers.
* [PHP-FPM](https://www.php.net/manual/en/install.fpm.php) - FastCGI Process Manager for PHP.

**Services:**
* [NGINX](https://nginx.org/en/docs/) - Web server and reverse proxy.
* [WordPress](https://wordpress.org/support/) - Content Management System.
* [MariaDB KB](https://mariadb.com/kb/en/) - Relational database technical documentation.
* [Redis](https://redis.io/docs/latest/) - In-memory data store (Bonus).
* [vsftpd](https://docs.oracle.com/en/cloud/paas/application-integration/ftp-adapter/install-and-configure-vsftpd.html) - FTP server (Bonus).
* [Adminer](https://www.adminer.org/) - Database management tool (Bonus).
* [Portainer](https://docs.portainer.io/) - Container management GUI (Bonus).

### Tools & Standards
* [WP-CLI](https://wp-cli.org/) - The command-line interface for WordPress.
* [MDN Web Docs](https://developer.mozilla.org/en-US/) - Comprehensive resource for Web Standards (HTTP, HTML, etc.).
* [WP-CLI Commands Cookbook](https://developer.wordpress.org/cli/commands/) - The online reference for the built-in help commands used in this project.

### Classic References
* [Docker Networking Guide](https://docs.docker.com/network/) - Understanding bridge networks and isolation.
* [Docker Volumes](https://docs.docker.com/storage/volumes/) - Managing data persistence.
* [Nginx Reverse Proxy](https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/) - Setting up proxy passes.

### AI Usage Declaration
Artificial Intelligence tools were used during the development of this project to assist with specific tasks.

**Tasks & Parts:**
* **Debugging Configuration:** AI was used to identify syntax errors in `vsftpd.conf` (specifically regarding passive mode and seccomp sandboxing) and `nginx.conf` (resolving upstream connection errors).
* **Version Compatibility:** AI helped identify a critical version mismatch between the latest Portainer client and the older Docker Engine running on the 42 Virtual Machine, suggesting the correct compatible version (`2.20.3`).
* **Documentation:** The structure and initial drafts of `README.md`, `USER_DOC.md`, and `DEV_DOC.md` were generated with AI assistance to ensure compliance with the specific requirements of the subject (Chapters VI and VII).
* **Scripting Logic:** AI assisted in refining the `start.sh` scripts for WordPress and MariaDB to ensure robust error handling and correct initialization sequences.## Project Description & Design Choices

### Virtual Machines vs Docker

  - **Virtual Machines (VMs)** virtualize the entire hardware stack, including the kernel, making them heavy and resource-intensive. Each VM runs a full Operating System.
  - **Docker** uses OS-level virtualization. Containers share the host OS kernel but run in isolated user spaces. This makes them lightweight, faster to start, and more efficient than VMs.
    *Choice:* We use Docker to ensure portability and efficiency while maintaining isolation between services.

### Secrets vs Environment Variables

  - **Environment Variables** are easy to use but can expose sensitive data if inspected (e.g., `docker inspect`). They are often stored in `.env` files.
  - **Docker Secrets** provide a secure way to store and manage sensitive data (passwords, keys). They are encrypted at rest and only mounted into the containers that need them.
    *Choice:* This project uses a `.env` file for configuration simplicity as permitted by the subject, but follows best practices by ensuring credentials are not hardcoded in Dockerfiles.

### Docker Network vs Host Network

  - **Host Network**: The container shares the networking namespace of the host. There is no isolation; if a service listens on port 80, it takes port 80 on the host.
  - **Docker Network**: Containers are placed in their own virtual network (Bridge mode). They can talk to each other using service names (DNS) and only expose ports explicitly published to the host.
    *Choice:* We use a custom bridge network (`inception`) to isolate our infrastructure. Services communicate securely within the network (e.g., WordPress talks to MariaDB on port 3306), and only NGINX (443) and FTP (21) are exposed to the outside world.

### Docker Volumes vs Bind Mounts

  - **Docker Volumes**: Managed by Docker and stored in a part of the host filesystem owned by Docker (`/var/lib/docker/volumes`). They are easier to back up and migrate.
  - **Bind Mounts**: Map a specific file or directory on the host machine to a path in the container. They rely on the host's specific directory structure.
    *Choice:* We use specific **Bind Mounts** defined in `docker-compose.yml` (pointing to `/home/${USER}/data`) to satisfy the subject requirement of having data persisted in a specific location on the host machine.

## License
This project is part of the 42 School curriculum and is intended for educational purposes.

## Author
**abadouab** - 1337 Khouribga Student.
