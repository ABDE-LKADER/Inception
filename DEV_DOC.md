# Developer Documentation

## Environment Setup
To set up this environment from scratch, follow these three steps:

1. **Prerequisites**: Ensure the host machine has `make`, `docker`, and `docker compose` installed.

2. **Configuration (.env)**:
   The project requires a `.env` file located at `srcs/.env`. This file is **not** committed to Git for security reasons. You must create it manually.
   
   **File Path:** `srcs/.env`
   
   ```ini
       # --- Database Setup ---
       MYSQL_DATABASE=database_name
       MYSQL_HOST=mariadb
       MYSQL_USER=database_user
       MYSQL_PASSWORD=strong_password
       MYSQL_ROOT_PASSWORD=root_secret
       
       # --- WordPress Setup ---
       WP_URL=[https://login.42.fr](https://login.42.fr)
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

3.  **Network Configuration**:
    You must configure the host machine to recognize the project domains. Run this command in your terminal (replace `login` with your 42 username):
    ```bash
    sudo bash -c 'echo "127.0.0.1 login.42.fr adminer.login.42.fr portainer.login.42.fr static.login.42.fr" >> /etc/hosts'
    ```

## Directory Structure

The project uses the following structure:

```text
├── Makefile
├── srcs
│   ├── .env                # Environment variables
│   ├── docker-compose.yml  # Orchestration file
│   └── requirements        # Service definitions
│       ├── mariadb
│       ├── nginx
│       ├── wordpress
│       └── bonus (ftp, redis, adminer, portainer, static)
```

## Building and Launching

The development cycle is automated via the `Makefile`:

  * `make up`: Builds Docker images locally (using `docker compose build`) and starts the containers in detached mode.
  * `make build`: Forces a rebuild of the images even if they exist.
  * `make logs`: Tails the logs of all containers for debugging.

## Managing Containers and Volumes

  * **Inspect Network**: `docker network inspect inception` to see IP assignments.
  * **Access Container Shell**: `docker exec -it <container_name> /bin/sh` (or `/bin/bash` if available).
  * **Volumes**:
      * **Persistence**: Data is persisted on the host machine using bind mounts.
      * **Locations**:
          * Database: `/home/${USER}/data/mariadb`
          * WordPress Files: `/home/${USER}/data/wordpress`
      * **Cleanup**: To remove all data and start fresh, run `make fclean`. **Warning**: This deletes the database and website files permanently.

## Persistence Details

The project uses **Bind Mounts** defined in `srcs/docker-compose.yml` under `driver_opts`. This maps the internal Docker volumes directly to the host filesystem folders listed above. This ensures that even if containers are removed (`docker compose down`), the data remains safe on the host.
