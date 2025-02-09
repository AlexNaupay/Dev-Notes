var requestOptions = {
    method: 'GET',
    redirect: 'follow'
  };

  fetch('http://localhost:5001/getMyInfo', requestOptions)
  .then(res => {
    if (!res.ok) {
      alert("HTTP error! status:" + res.status);
    }
    return res.json();
  })
  .then(json => {
	  document.getElementById("facebookLink").href = "https://www.facebook.com/" + json.socialMedia.facebookUser;
    document.getElementById("instagramUser").href = "https://www.instagram.com/" + json.socialMedia.instagramUser;
    document.getElementById("xUser").href = "https://www.x.com/" + json.socialMedia.xUser;
    document.getElementById("githubUser").href = "https://www.github.com/" + json.socialMedia.githubUser;
    document.getElementById("linkedinUser").href = "https://www.linkedin.com/" + json.socialMedia.linkedin;
    document.getElementById("website").href = json.blog;
  })
  .catch(error => alert("error: " + error));