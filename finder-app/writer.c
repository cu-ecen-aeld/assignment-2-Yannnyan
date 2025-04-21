#include <syslog.h>
#include <sys/stat.h>
#include <libgen.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>

int main(int argc, char** argv) {
    if (argc != 3) {
        openlog("writer_app", LOG_PERROR, LOG_USER);
        syslog(LOG_ERR,"Error, found more or less than 2 arguments for writer app. argc=%d", argc);
        closelog();
        return 1;
    }
    struct stat stats;
    char * dir = malloc(strlen(argv[1]));
    strcpy(dir, argv[1]);
    dir = dirname(dir);
    stat(dir, &stats);
    if (!S_ISDIR(stats.st_mode)) {
        openlog("writer_app", LOG_PERROR, LOG_USER);
        syslog(LOG_ERR, "Error, couldn't find the target directory %s", dir);
        closelog();
        return 1;
    }
    
    FILE * fp = fopen(argv[1], "w+");
    int len = strlen(argv[2]);

    char * formatted_msg = malloc(len + 10 * sizeof(char) + strlen(argv[1]));
    sprintf(formatted_msg, "Writing %s to %s", argv[2], argv[1]);
    openlog("writer_app", LOG_PERROR, LOG_USER);
    syslog(LOG_INFO, formatted_msg);
    closelog();

    size_t written_size = fwrite(argv[2],len , sizeof(char), fp);
    // if (written_size != len ) {
    //     openlog("writer_app", LOG_PERROR, LOG_USER);
    //     syslog(LOG_ERR, "Error, couldn't write full text to file");
    //     closelog();
    //     return 1;
    // }
    return 0;
}
