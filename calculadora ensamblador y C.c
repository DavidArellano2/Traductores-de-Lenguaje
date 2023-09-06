#include <stdio.h> // para printf()
#include <stdlib.h> // para exit()
#include <iostream> 

int suma(int num1, int num2){
	int result;
	asm(
	"movl %1, %%eax\n"
    "addl %2, %%eax\n"
    "movl %%eax, %0\n"
    : "=r" (result)      // Output: resultado
    : "r" (num1), "r" (num2)     // Inputs: a, b
    : "%eax"             // Clobbered register: eax
    );
	return result; //Se retorna el resultado
}

int resta(int num1, int num2) {
    int result;
    asm (
        "movl %1, %%eax\n"
        "subl %2, %%eax\n"
        "movl %%eax, %0\n"
        : "=r" (result)      // Output: resultado
        : "r" (num1), "r" (num2)     // Inputs: a, b
        : "%eax"               // Clobbered register: eax
    );
    return result;
}

int mult(int num1, int num2) {
    int result;
    asm(
        "movl %1, %%eax\n"
        "imull %2, %%eax\n"
        "movl %%eax, %0\n"
        : "=r" (result)      // Output: resultado
        : "r" (num1), "r" (num2)     // Inputs: a, b
        : "%eax"               // Clobbered register: eax
    );
    return result;
}

int division(int num1, int num2) {
    int result;
    asm (
        "movl %1, %%eax\n"      // Mueve el dividendo a eax
        "cdq\n"                 // Extiende el signo de eax a edx
        "idivl %2\n"            // Divide edx:eax por el divisor
        "movl %%eax, %0\n"      // Guarda el cociente en la variable resultado
        : "=r" (result)      // Output: resultado
        : "r" (num1), "r" (num2)      // Inputs: a (dividendo), b (divisor)
        : "%eax", "%edx"        // Clobbered registers: eax, edx
    );
    return result;
}

int potencia(int num1, int num2) {
    int result;

    asm (
        "movl $1, %%eax\n"          // Inicializa el resultado en 1
        "movl %1, %%ecx\n"          // Mueve la base a ecx
        "movl %2, %%edx\n"          // Mueve el exponente a edx
        "cmp $0, %%edx\n"           // Compara el exponente con 0
        "je fin\n"                  // Salta al final si el exponente es 0
        "cmp $1, %%edx\n"           // Compara el exponente con 1
        "je fin\n"                  // Salta al final si el exponente es 1
        "loop_start:\n"
        "imull %%ecx, %%eax\n"      // Multiplica el resultado parcial por la base
        "subl $1, %%edx\n"          // Decrementa el exponente
        "cmp $1, %%edx\n"           // Compara el exponente con 1
        "jg loop_start\n"           // Salta al inicio del ciclo si el exponente es mayor que 1
        "fin:\n"
        "movl %%eax, %0\n"          // Guarda el resultado en la variable resultado
        : "=r" (result)          // Output: resultado
        : "r" (num1), "r" (num2)   // Inputs: base, exponente
        : "%eax", "%ecx", "%edx"    // Clobbered registers: eax, ecx, edx
    );
    return result;
}

double seno(double num1) {
    double result;

    asm (
        "fldl %1\n"       // Carga el ángulo en el coprocesador de punto flotante
        "fsin\n"          // Calcula el seno
        "fstpl %0\n"      // Almacena el resultado en la variable resultado
        : "=m" (result)   // Output: resultado
        : "m" (num1)          // Input: x (ángulo)
    );
    return result;
}

double coseno(double num1) {
    double result;

    asm (
        "fldl %1\n"       // Carga el ángulo en el coprocesador de punto flotante
        "fcos\n"          // Calcula el coseno
        "fstpl %0\n"      // Almacena el resultado en la variable resultado
        : "=m" (result) // Output: resultado
        : "m" (num1)          // Input: x (ángulo)
    );
    return result;
}

double tangente(double num1) {
    double result;

    asm (
        "fldl %1\n"       // Carga el ángulo en el coprocesador de punto flotante
        "fptan\n"         // Calcula la tangente
        "fstp %%st(0)\n"  // Descarta el valor del coseno
        "fstpl %0\n"      // Almacena el resultado en la variable resultado
        : "=m" (result) // Output: resultado
        : "m" (num1)          // Input: x (ángulo)
    );
    return result;
}

float raiz(float num1) {
    float result;

    asm (
        "fld %1\n"        // Carga el valor en el coprocesador de punto flotante
        "fsqrt\n"         // Calcula la raíz cuadrada
        "fstp %0\n"       // Almacena el resultado en la variable resultado
        : "=m" (result) // Output: resultado
        : "m" (num1)          // Input: x (valor)
    );
    return result;
}

int main() {
	int num1, num2, opc; //Se definen variables
	float res;
	//inicializamos num1 y num2
	num1 = 0;
	num2 = 0;
	opc = 0;
	res = 0;

	printf("\n\n\t+-------------------------------------------+ \n");
	printf("\t|  Calculadora en lenguaje C y Ensamblador  | \n");
	printf("\t+-------------------------------------------+ \n");
	printf("\t|                   AUTOR:                  | \n");
	printf("\t|  RICARDO DAVID LOPEZ ARELLANO / 217136143 | \n");
	printf("\t|                                           | \n");
	printf("\t+-------------------------------------------+ \n\n");

	system("PAUSE()");

	do {
		system("cls");
		system("COLOR 0F");
		printf("\n\t< PRODUCTO INGREADOR >\n\tCalculadora C & ASM\n\nLas opciones a elegir son las siguientes:\n\n");
		printf("1) Suma \n");
		printf("2) Resta \n");
		printf("3) Multiplicacion \n");
		printf("4) Division \n");
		printf("5) Potencia \n");
		printf("6) Funcion Senoidal \n");
		printf("7) Funcion Cosenoidal \n");
		printf("8) Funcion Tangente\n");
		printf("9) Funcion Raiz Cuadrada\n");
		printf("10) Salir \n\n");
		printf("---> Opcion: ");
		scanf("%d", &opc);
		system("cls");
		switch (opc) {
		case 1:
			printf("\n\t< Elegiste la opcion de SUMA >\n\n");
			printf("Ingrese el valor de num1:");
			scanf("%d", &num1);
			printf("Ingrese el valor de num2:");
			scanf("%d", &num2);
			res = suma(num1, num2);
			system("cls");
			printf("\n\tEl resultado es el siguiente:\n\n");
			system("COLOR 01");
			printf("\n(%d + %d) = %.2f \n\n\r", num1, num2, res); //imprimimos el resultado de la suma
			system("pause");
			break;
		case 2:
			printf("\n\t< Elegiste la opcion de RESTA >\n\n");
			printf("Ingrese el valor de num1:");
			scanf("%d", &num1);
			printf("Ingrese el valor de num2:");
			scanf("%d", &num2);
			res = resta(num1, num2);
			system("cls");
			printf("\n\tEl resultado es el siguiente:\n\n");
			system("COLOR 02");
			printf("\n(%d - %d) = %.2f \n\n\r", num1, num2, res); //imprimimos el resultado de la resta
			system("pause");
			break;
		case 3:
			printf("\n\t< Elegiste la opcion de MULTIPLICACION >\n\n");
			printf("Ingrese el valor de num1:");
			scanf("%d", &num1);
			printf("Ingrese el valor de num2:");
			scanf("%d", &num2);
			res = mult(num1, num2);
			system("cls");
			printf("\n\tEl resultado es el siguiente:\n\n");
			system("COLOR 03");
			printf("\n(%d x %d) = %.2f \n\n\r", num1, num2, res); //imprimimos el resultado de la multiplicacion
			system("pause");
			break;
		case 4:
			printf("\n\t< Elegiste la opcion de DIVISION >\n\n");
			printf("Ingrese el valor de num1:");
			scanf("%d", &num1);
			printf("Ingrese el valor de num2:");
			scanf("%d", &num2);
			res = division(num1, num2);
			system("cls");
			printf("\n\tEl resultado es el siguiente:\n\n");
			system("COLOR 04");
			printf("\n(%d / %d) = %.2f \n\n\r", num1, num2, res); //imprimimos el resultado de la division
			system("pause");
			break;
		case 5:
			printf("\n\t< Elegiste la opcion de POTENCIA >\n\n");
			printf("Ingrese el valor de num1:");
			scanf("%d", &num1);
			printf("Ingrese el valor de num2:");
			scanf("%d", &num2);
			res = potencia(num1, num2+1);
			system("cls");
			printf("\n\tEl resultado es el siguiente:\n\n");
			system("COLOR 05");
			printf("\n(%d ^ %d) = %.2f \n\n\r", num1, num2, res); //imprimimos el resultado de la potencia
			system("pause");
			break;
		case 6:
			printf("\n\t< Elegiste la opcion de Sen(x) >\n\n");
			printf("Ingrese el valor de x:");
			scanf("%d", &num1);
			res = seno(num1);
			system("cls");
			printf("\n\tEl resultado es el siguiente:\n\n");
			printf("\n(%d) = %.2f \n\n\r", num1, res); //imprimimos el resultado de seno
			system("COLOR 06");
			system("pause");
			break;
		case 7:
			printf("\n\t< Elegiste la opcion de Cos(x) >\n\n");
			printf("Ingrese el valor de x:");
			scanf("%d", &num1);
			res = coseno(num1);
			system("cls");
			printf("\n\tEl resultado es el siguiente:\n\n");
			printf("\n(%d) = %.2f \n\n\r", num1, res); //imprimimos el resultado de coseno 
			system("COLOR 09");
			system("pause");
			break;
		case 8:
			printf("\n\t< Elegiste la opcion de Tan(x) >\n\n");
			printf("Ingrese el valor de x:");
			scanf("%d", &num1);
			res = tangente(num1);
			system("cls");
			printf("\n\tEl resultado es el siguiente:\n\n");
			printf("\n(%d) = %.2f \n\n\r", num1, res); //imprimimos el resultado de tangente
			system("COLOR 08");
			system("pause");
			break;
		case 9:
			printf("\n\t< Elegiste la opcion de Raiz Cuadrada >\n\n");
			printf("Ingrese el valor de x:");
			scanf("%d", &num1);
			res = raiz(num1);
			system("cls");
			printf("\n\tEl resultado es el siguiente:\n\n");
			printf("\n(%d) = %.2f \n\n\r", num1, res); //imprimimos el resultado de la raiz
			system("COLOR 03");
			system("pause");
			break;
		default:
			printf("\n\t< Saliendo del programa... >\n");
			system("COLOR 10");
				break;
		}
	} while (opc != 9);
	return 0;
}

