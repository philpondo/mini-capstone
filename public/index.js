console.log("Check, check");

axios.get("http://localhost:3000/api/products").then(function (response) {
  console.log(response.data);
}); 