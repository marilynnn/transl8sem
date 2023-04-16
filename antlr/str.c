#include "str.h"

struct function funcs[MAX_COUNT];
int funcs_count = 0;
struct argument arg_;
struct arguments args_;
static int current = -1;

func_type str_to_enum(char* funct_name){
    
    if (strcmp(funct_name,"sum") == 0){
        return sum;
    }
    else if (strcmp(funct_name,"mul") == 0){
        return mul;
    }
    else {
        printf("Found undefined function!");
        exit(-1);
    }
};

int get_res() {
	
	int res = 0;
    current += 1;
	 function func;
	
	if (funcs_count == 0){
		return res = arg_.value;
		}
        func = funcs[funcs_count - current - 1];
		int i;
		for (i = 0; i < func.args.args_count; ++i) {
			if (func.args.args[i].is_num == 1) {
				switch (func.type){
					case sum:{
						res += func.args.args[i].value;
						break;
					}
					case mul:{
						if (i == 0) {
							res = func.args.args[i].value;
						}
						else {
							res *= func.args.args[i].value;
						}
						break;
					}
				}
			}
			else {
				switch (func.type){
					case sum:{
						res += get_res();
						break;
					}
					case mul:{
						if (i == 0) {
							res = get_res();
						}
						else {
							res *= get_res();
						}
						break;
					}

				}
			}
		}
    //}
	return res;
}
//sum(1,2,mul(sum(1,2,3),3))
