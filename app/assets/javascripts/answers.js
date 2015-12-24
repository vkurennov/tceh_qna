$(document).ready(function() {
    //$(document).bind('ajax:error', function(e, xhr, status, error){
    //    if (status == 403) {
    //        alert('У вас нет прав!');
    //    }
    //});

    $('form.new_answer').bind('ajax:success',
        function(e, data, status, xhr) {
            console.log(data);
            //response = $.parseJSON(xhr.responseText);
            answer = data.answer;

            //$('.answers-count').html('Answers count: ' + data.answers_count);
            //$('.answers').append('<div class="answer" id="answer_'
            //    + answer.id + '\"><p>' + answer.body + '</p></div>');
            $('#answer_body').val('');
        }).bind('ajax:error',
        function(e, xhr, status, error) {
            errors = $.parseJSON(xhr.responseText);

            $.each(errors, function(index, message) {
                $('.answer-errors').append("<p>" + message + "</p>")
            })
        }).bind('ajax:before', function() {
            $('.answer-errors').html('');
        });

    questionId = $('.question').data('questionId');
    channel = '/questions/' + questionId + '/answers';

    PrivatePub.subscribe(channel, function(data, channel) {
        console.log(data);
        response = data['response'];
        answers_count = response.answers_count;
        answer = response.answer;

        $('.answers-count').html('Answers count: ' + answers_count);
        $('.answers').append('<div class="answer" id="answer_'
            + answer.id + '\"><p>' + answer.body + '</p></div>');
    })
});