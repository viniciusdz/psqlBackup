# psqlBackup


A PostgreSQL backup script with telegram notifications.

## Installation

Clone this repository.

```bash
#clone git repo

git clone https://github.com/viniciusdz/psqlBackup.git

#create backup-dir

mkdir -p /var/backups/psqlBackup

#copy backup script to the backup folder

cp psqlBackup/backup.sh /var/backups/psqlBackup/

```

## Configuration

```bash

cd /var/backups/psqlBackup/

chmod 0700 backup.sh

crontab -l | { cat; echo "0 0 * * * /var/backups/psqlBackup/backup.sh"; } | crontab -l

```


## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)
