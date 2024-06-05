var boughty;
var sold=[];
function handleClickSold(i) {
  console.log(i);
  if(sold.includes(i)){
  }else{
    sold.push(i);
  }
}
function handleClickBought(i){
  console.log(i)
  boughty=i;
  
  if(sold.length===0){
   return; 
  }
  var url=window.location.href+"?";
  const params = new URLSearchParams({
    bought: boughty,
    sold: sold
  });
  url+=params.toString()
  console.log(params.toString());
  window.location.replace(url);
}
