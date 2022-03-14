const domAge=document.getElementById("age")
const domWeight=document.getElementById("weight")
const form=document.getElementsByTagName("form")[0]

form.addEventListener("submit",event=>{
   let age = parseInt(domAge.value)
   let weight = parseInt(domWeight.value)
   domAge.parentElement.classList.remove("error")
   domWeight.parentElement.classList.remove("error")
   if(isNaN(age)){
      domAge.parentElement.classList.add("error")
      event.preventDefault()
   }
   if(isNaN(weight)){
      domWeight.parentElement.classList.add("error")
      event.preventDefault()
   }
   return !isNaN(age) && !isNaN(weight)
})