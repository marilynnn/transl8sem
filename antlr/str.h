#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#ifndef str_h
#define str_h

#define MAX_COUNT 1000

enum func_type {
	sum = 0,
	mul = 1
};

struct argument {
	unsigned char is_num;
	int value;
};

struct arguments {
	int args_count;
	struct argument args[MAX_COUNT];
};

struct function {
	enum func_type type;
	struct arguments args;
};
	
int get_res();
func_type str_to_enum(char* funct_name);
#endif
