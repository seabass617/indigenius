const initCaroussel =() =>{
  const elements = document.querySelectorAll('.icon-cards__content');
  elements.forEach((el)=>{
    el.classList.toggle('step-animation');
  })
}

export {initCaroussel}