#include <stdio.h>
#define MAXSIZE 4096

/**
 * You can use this recommended helper function
 * Returns true if partial_line matches pattern, starting from
 * the first char of partial_line.
 */
int matches_leading(char *partial_line, char *pattern) {
  // Implement if desire
	if(partial_line[0] != '\0') {
		if(pattern[0] != '\0') {
			if(pattern[0] == '\\' && pattern[1] != '+') {
				if(pattern[1] == '.' || pattern[1] == '+' || pattern[1] == '?') {
					int c = 0, count = 0;
					while(pattern[1] == '?' && partial_line[c] != '\0') {
						if(partial_line[c] == '?') {
							count++;
							c++;
						} if(count < 1) {
							return 0;
						}
					} if (pattern[2] == '?') {
						return matches_leading(partial_line, pattern + 1);
					}
					return matches_leading(partial_line + 1, pattern + 2);
				}
				return matches_leading(partial_line, pattern + 1);
			} else if(pattern[0] == '?') {
				return matches_leading(partial_line, pattern - 1);
			} else if(pattern[1] == '?') {
				if(pattern[0] == '.' && pattern[-1] != '\\') {
					if(matches_leading(partial_line, pattern + 2)) {
						return 1;
					} else if(matches_leading(partial_line + 1, pattern + 2)) {
						return 1;
					} else {
						return 0;
					}
				} else if(partial_line[0] == pattern[2]) {
					 if(matches_leading(partial_line, pattern +2)) {
						return 1;
					}
				} else if(pattern[0] == partial_line[0]) {
					return matches_leading(partial_line + 1, pattern + 2);
				} else if(pattern[0] == partial_line[0]) {
					return matches_leading(partial_line + 1, pattern + 2);
				} else if(pattern[0] == pattern[2]) {
					pattern = pattern + 2;
					return matches_leading(partial_line, pattern);
				} else if(pattern[0] != partial_line[0]) {
					return 0;
				}
			} else if(pattern[1] == '+') {
				int i = 0, j = 0;
				if(pattern[0] == '\\' && pattern[-1] != '\\') {
					while(partial_line[0] == '\\') {
						partial_line++;
						if(partial_line[0] == '\0') {
							return 0;
						}
					}
					return matches_leading(partial_line, pattern + 1);
				} if(pattern[0] == '.') {
					if(pattern[2] == '\0') {
						return 1;
					} while(partial_line[j] != pattern[2]) {
						j++;
						if(partial_line[j] == '\0') {
							return 0;
						}
					}
					return matches_leading(partial_line + j, pattern + 2);
				} while(partial_line[i] == pattern[0]) {
					i++;
				} if(i > 0) {
					pattern = pattern + 2;
					return matches_leading(partial_line + i, pattern);
				} else {
					return 0;
				}
			} else if(pattern[0] == '.') {
				if(pattern[-1] == '\\') {
					return 0;
				return matches_leading(partial_line + 1, pattern + 1);
			} else if(partial_line[0] == pattern[0]) {
				return matches_leading(partial_line + 1, pattern + 1);
			} else {
				return 0;
			}
		}
		return 1;
	}
  return 0;
}

/**
 * You may assume that all strings are properly null terminated 
 * and will not overrun the buffer set by MAXSIZE 
 *
 * Implementation of the rgrep matcher function
 */
int rgrep_matches(char *line, char *pattern) {

    //
    // Implement me
    //

	int i = 0;
	while(line[i] != '\0') {
		if(matches_leading(line + i, pattern)) {
			return 1;
		}
		i++;
	}
	if(pattern[0] == '\0') {
		return 1;
	}

    return 0;
}

int main(int argc, char **argv) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <PATTERN>\n", argv[0]);
        return 2;
    }

    /* we're not going to worry about long lines */
    char buf[MAXSIZE];

    while (!feof(stdin) && !ferror(stdin)) {
        if (!fgets(buf, sizeof(buf), stdin)) {
            break;
        }
        if (rgrep_matches(buf, argv[1])) {
            fputs(buf, stdout);
            fflush(stdout);
        }
    }

    if (ferror(stdin)) {
        perror(argv[0]);
        return 1;
    }

    return 0;
}
