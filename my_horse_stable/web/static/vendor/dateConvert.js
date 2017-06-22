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

    return year + "-" + day + "-" + month + " 00:00:00";
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

    const day = tabDate[1];
    const month = tabDate[2];
    const year = tabDate[0];

    return day + "/" + month + "/" + year;
}


function date_manager(id_date, name_submit = "submit"){
    let date_to_manage = document.getElementById(id_date);
    date_to_manage.value = convertNaiveDateToString(date_to_manage.value);

    let submit_event = document.getElementById(name_submit);

    function validateForm(){
        date_to_manage.value = convertStringToNaiveDate(date_to_manage.value);
    }

    submit_event.addEventListener('click', validateForm, false);

    $(function() {
        $(date_to_manage).daterangepicker({
                singleDatePicker: true,
                showDropdowns: true
            },
            function(start, end, label) {
                console.log("ok");
            });
    });
}