escribir_cadena('Este programa imprime la sucesion de fibonacci desde 1 hasta N \n siendo este ultimo un numero ingresado por el usuario \n');

aux := 1;

fib := 0;

escribir_cadena('Ingrese un numero para la sucesion de fibonacci:');

lugar(15,10);

leer(lim);

si (lim > 0) entonces

    para init desde 1 hasta lim hacer

        escribir(fib);

        aux := aux+fib;

        fib := aux - fib;
    fin_para;

si_no

    escribir_cadena('El numero debe ser mayor a cero!!\n');

fin_si;