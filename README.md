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
This project requires specific network and environment configurations before it can run.

1.  **Configuration (Required):**
    You must set up your environment variables and network domains.
    Please refer to the **[Developer Documentation](DEV_DOC.md)** for both `.env` creation and `/etc/hosts` configuration.

2.  **Execution:**
    Once configured, use the Makefile to run the project:
    ```bash
    make up
    ```

3.  **Cleaning:**
    To stop and clean the environment:
    ```bash
    make fclean
    ```

For a detailed guide on accessing services, credentials, and the FTP server, please refer to the **[User Documentation](USER_DOC.md)**.

## Resources

### Official Documentation
This project relies on the official documentation of the following technologies:

**Core Infrastructure:**
* [Docker Engine](https://docs.docker.com/engine/) - The container runtime.
* [Docker Compose](https://docs.docker.com/compose/) - Orchestration tool.
* [Alpine Linux](https://docs.alpinelinux.org/user-handbook/0.1a/index.html) - Lightweight OS used for all containers.
* [PHP-FPM](https://www.php.net/manual/en/install.fpm.php) - FastCGI Process Manager for PHP.

**Services:**
* [NGINX](https://nginx.org/en/docs/) - Web server and reverse proxy.
* [WordPress](https://wordpress.org/support/) - Content Management System.
* [MariaDB](https://mariadb.com/docs/) - Relational database technical documentation.
* [Redis](https://redis.io/docs/latest/) - In-memory data store (Bonus).
* [vsftpd](https://docs.rockylinux.org/10/guides/file_sharing/secure_ftp_server_vsftpd/) - FTP server (Bonus).
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
* **Scripting Logic:** AI assisted in refining the `start.sh` scripts for WordPress and MariaDB to ensure robust error handling and correct initialization sequences.

## Project Description & Design Choices

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
