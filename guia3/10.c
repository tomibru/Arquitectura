 int main(){
    int n=-1,i,j, a, v[50]={0};
    fscanf("%d", &a);
    while(i >= 0){
        n++;
        v[n]= a;
        fscanf("%d", &a);
    }

    for(i=0; i<n-1; i++){
        fscanf("%d", &a);
        j=0;
        while(j<n && v[j] != a)
            j++;
        v[j]=-1;
    }
    i=0;
    while(i<n-1 && v[i] == -1)
        i++;
    printf("%d",i);
}