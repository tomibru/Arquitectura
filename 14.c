void weekday_set(char* c, int n){
    *c = (*c) | (1 << n);
}

void weekday_reset(char* c, int n){
    *c = (*c) & ~(1 << n);
}