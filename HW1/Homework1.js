const gallery = document.getElementById('gallery')

function section2(data){
   const element = document.getElementById('section2')
   if(!element) {
      return
   }
   element.innerHTML=''
   data.forEach(
      info=>{
         const infoElement = document.createElement('div')
         infoElement.innerHTML = `
         <div class="img" style="background-image: url(images/${info.image})" alt="" ></div>
         <h3>${info.heading}</h3>
         <p>${info.text}</p>`
         element.appendChild(infoElement)
      }
   )
}

function section3(data){
   const element = document.getElementById('section3')
   if(!element) {
      return
   }
   
   element.innerHTML = `<p>${data.text.join('</p><p>')}</p>`
}

function section4(data){
   const element = document.getElementById('section4')
   if(!element) {
      return
   }
   element.innerHTML=''
   data.forEach(
      info=>{
         const infoElement = document.createElement('div')
         infoElement.innerHTML = `
         <img src="images/${info.image}" alt="" />
         <div>
         <h2>${info.heading}</h2>
         <p>${info.text}</p></div>`
         element.appendChild(infoElement)
      }
   )
}

fetch('data.json').then(
   async response => {
      const json = await response.json()
      console.log(json)
      Object.keys(json).forEach(
         name => {
            const data = json[name]
            if(name === 'section2'){
               section2(data)
            }
            if(name === 'section3'){
               section3(data)
            }
            if(name === 'section4'){
               section4(data)
            }
         }
      )
   }
)