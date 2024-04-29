
function doLike(pId,uId,likeBtnRef){

    console.log(pId+" , "+uId);
    console.log("Like Button:", likeBtnRef);

    const d = {
        uId:uId,
        pId:pId,
        operation: 'like'
    }

    $.ajax({
        url: "like",
        type: "POST",
        data: d,
        success:function(data,textStatus,jqXHR){
            console.log(data);
            if (data.trim()==="true"){
                let count = $(likeBtnRef).find('.like-counter').html();
                count++;
                $(likeBtnRef).find('.like-counter').html(count);
            }
        },
        error:function(jqXHR,textStatus,errorThrown){
            console.log(errorThrown);
        }
    })

}
