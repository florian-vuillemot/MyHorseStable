/**
 * Created by florian on 24/05/17.
 */

// Recept string like '%d/%m/%y' (or with '-' separator) and convert in '%y-%m-%d 00:00:00'
function convertStringToNaiveDate(str)
{
    const tabDate = str.replace(/-/g, '/').split('/');

    if (tabDate.length !== 3){
        return str;
    }

    const day = tabDate[0];
    const month = tabDate[1];
    const year = tabDate[2];

    return year + "-" + month + "-" + day + " 00:00:00";
}

// Get a naive date and convert in date for user.
// str format: '%y-%m-%d 00:00:00'
// Return format: '%d/%m/%y'
function convertNaiveDateToString(str)
{
    const tabDate = str.split(' ')[0].split('-');

    if (tabDate.length !== 3){
        return str;
    }

    const day = tabDate[2];
    const month = tabDate[1];
    const year = tabDate[0];

    return day + "/" + month + "/" + year;
}