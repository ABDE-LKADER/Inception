# Developer Documentation

## Environment Setup
To set up this environment from scratch:

1.  **Prerequisites**: Ensure the host machine has `make`, `docker`, and `docker compose` installed.
2.  **Directory Structure**: The project uses the following structure:
    ```text
    ├── Makefile
    ├── srcs
    │   ├── .env                # Environment variables (MUST BE CREATED)
    │   ├── docker-compose.yml  # Orchestration file
    │   └── requirements        # Service definitions
    │       ├── mariadb
    │       ├── nginx
    │       ├── wordpress
    │       └── bonus (ftp, redis, adminer, portainer, static)
    ```

## Configuration (.env)
The project requires a `.env` file located at `srcs/.env`. This file is **not** committed to Git for security reasons. You must create it manually using the following template.

**File Path:** `srcs/.env`

```ini
    # --- Project Configuration ---
    # Replace 'login' with your 42 login
    DOMAIN_NAME=login.42.fr

    # --- Database Setup (MariaDB) ---
    MYSQL_DATABASE=inception
    MYSQL_USER=user
    MYSQL_PASSWORD=userpass
    MYSQL_ROOT_PASSWORD=rootpass

    # --- WordPress Setup ---
    WP_URL=login.42.fr
    WP_TITLE=Inception
    WP_ADMIN_USER=admin
    WP_ADMIN_PASS=adminpass
    WP_ADMIN_EMAIL=admin@student.42.fr
    WP_USER=author
    WP_USER_PASS=authorpass
    WP_USER_EMAIL=author@student.42.fr

    # --- FTP Server Setup ---
    FTP_USER=ftpuser
    FTP_PASS=ftppass

    # --- FTP Passive Mode ---
    # Vital for connecting from host (e.g. FileZilla/lftp)
    # REPLACE THIS with your VM's IP address (run `hostname -I` to find it)
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