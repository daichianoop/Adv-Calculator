#!/bin/bash

# Function to calculate exponentiation
exponent() {
    echo "Exponentiation: $1^$2 = $(echo "$1^$2" | bc)"
}

# Function to calculate LCM
lcm() {
    a=$1
    b=$2
    # Calculate LCM using formula: LCM(a, b) = (a * b) / GCD(a, b)
    gcd() {
        if [ $b -eq 0 ]; then
            echo $a
        else
            a=$b
            b=$(($a % $b))
            gcd $a $b
        fi
    }
    gcd_result=$(gcd $a $b)
    lcm_result=$(($a * $b / $gcd_result))
    echo "LCM of $a and $b is: $lcm_result"
}

# Function to convert decimal to BCD (Binary Coded Decimal)
bcd() {
    number=$1
    echo -n "BCD of $number is: "
    while [ $number -gt 0 ]; do
        digit=$((number % 10))
        printf "%04d " $(echo "obase=2; $digit" | bc)
        number=$((number / 10))
    done
    echo
}

# Function to calculate log (base 10)
log10() {
    echo "log10($1) = $(echo "scale=4; l($1) / l(10)" | bc -l)"
}

# Function to show menu
show_menu() {
    echo "Shell Calculator"
    echo "1. Exponentiation"
    echo "2. Least Common Multiple (LCM)"
    echo "3. Binary Coded Decimal (BCD)"
    echo "4. Logarithm (base 10)"
    echo "5. Exit"
}

# Main program loop
while true; do
    show_menu
    read -p "Enter your choice: " choice
    case $choice in
        1)
            read -p "Enter base: " base
            read -p "Enter exponent: " exp
            exponent $base $exp
            ;;
        2)
            read -p "Enter first number: " num1
            read -p "Enter second number: " num2
            lcm $num1 $num2
            ;;
        3)
            read -p "Enter number to convert to BCD: " num
            bcd $num
            ;;
        4)
            read -p "Enter number for log base 10: " num
            log10 $num
            ;;
        5)
            echo "Exiting calculator."
            break
            ;;
        *)
            echo "Invalid choice. Please select a valid option."
            ;;
    esac
    echo
done
