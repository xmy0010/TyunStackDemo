function setAllImagesWidth (wids,placeImage,images) {
    var imglen = document.getElementsByTagName("img").length;
    for (var i=0;i<imglen;++i) {
        var objImg = document.getElementsByTagName("img")[i];
        objImg.id = "img"+i;
    }
    var imagesWidthsArray = wids.split(",;;;");
    var imagesArray = images.split(",;;;");
    for (var i=0;i<imglen;i++) {
        var objImg = document.getElementById("img"+i);
        var imgstr = imagesArray[i];
        var newoA = document.createElement("a");
        if(objImg.parentNode.nodeName == 'A' && objImg.parentNode.href) {
            newoA.href = objImg.parentNode.href;
        } else {
            newoA.href = "imgClick|"+imgstr+"|"+i;
        }
        var newoImg = document.createElement("img");
        newoImg.alt = objImg.alt;
        var tmpArray = imgstr.split("/");
        var name = tmpArray[tmpArray.length-1];
        newoImg.id = name+"_index_"+i;
        var div=document.createElement("div");
        if (parseInt(objImg.style.width) > 0 && parseInt(objImg.style.height) > 0) {
            newoImg.width = imagesWidthsArray[i];
            var height=imagesWidthsArray[i]*objImg.height/objImg.width;
            newoImg.height=height;
            div.setAttribute('style',"background-color:#f0f0f0;background-image:url(" + placeImage + ");background-size:80px 56px; background-repeat: no-repeat; background-position: center center; width:" + imagesWidthsArray[i] + "px;height:" + height + "px;font-size:0; margin:0 auto;");
        } else {
            newoImg.setAttribute('style', "max-width: 100%; height: auto;");
        }
        div.appendChild(newoImg);
        newoA.appendChild(div);
        objImg.parentNode.replaceChild(newoA,objImg);
    }
}

function displayImage(url,strId,idx) {
    var imgId = strId + "_index_" + idx;
    document.getElementById(imgId).src = url;
//    if(!document.getElementById(imgId).href || document.getElementById(imgId).href == "") {
//        document.getElementById(imgId).href = "imgClick|" + url + "|" + idx;
//    }
}

