# Inception

## Description
This project is a System Administration exercise designed to broaden knowledge of **Docker**. It involves virtualizing several Docker images to create a personal virtual machine infrastructure. The goal is to set up a multi-service architecture where each service runs in a dedicated container, orchestrated by **docker compose**.

The infrastructure includes:
- **NGINX**: The entry point with TLSv1.3 security.
- **WordPress + PHP-FPM**: The CMS.
- **MariaDB**: The database.
- **Redis**: For cache management (Bonus).
- **FTP Server**: For file transfer (Bonus).
- **Adminer**: For database management (Bonus).
- **Portainer**: For container monitoring (Bonus).
- **Static Website**: A custom static page (Bonus).

## Instructions

### Prerequisites
- Docker Engine
- Docker Compose
- Make

### Compilation & Execution
This project uses a `Makefile` to automate the build and deployment process.

1. **Clone the repository:**
   ```bash
   git clone <repository_url>
   cd Inception
   ```

2.  **Launch the infrastructure:**
    Build and start all containers in the background.

    ```bash
    make up
    ```

    *Note: This command automatically creates the required data directories at `/home/${USER}/data/`.*

3.  **Stop the services:**
    Stop and remove containers and networks.

    ```bash
    make down
    ```

4.  **Clean everything:**
    Stop containers and remove all Docker images, volumes, and networks.

    ```bash
    make fclean
    ```

5.  **View Logs:**

    ```bash
    make logs
    ```

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

## Resources

  * **AI Usage:** AI tools were used during this project to:
      * **Debug Configuration:** resolving syntax errors in `vsftpd.conf` and `nginx.conf`.
      * **Version Compatibility:** Identifying mismatch issues between Portainer versions and the 42 VM Docker Engine.
      * **Documentation:** Generating drafts for the required documentation files.
      * **Scripting:** Refining the `start.sh` logic to handle permissions and service startup sequences correctly.