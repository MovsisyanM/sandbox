// define a function that takes argument x and adds 10 to it, then it multiplies that by 20

function addTen(x) {
    return x + 10 * 20;
}

// write the derivative of the function x^4 - x

function derivative(x) {
    return 4 * x * x - 1;
}

//  define a function that takes an argument x
//  and it returns "Kaskaceli" if x is greater than or equal to 1, return "hskvox",
//  and if x is greater than 90, return "standart"
//  if x turns out to be greater than 180, return "kaskaceli"
//  and finally, if x is 270 or greater, return "anhusali"

function whatIsYourName(x) {
    if (x >= 1) {
        return "Kaskaceli";
    } else if (x >= 90) {
        return "standart";
    } else if (x >= 180) {
        return "kaskaceli";
    } else if (x >= 270) {
        return "anhusali";
    }
}