const setImageOther = ()=> {
    console.log('change other image')

    const imageOther = document.querySelector('.imageOther')

    if(imageOther) imageOther.value = 'change_other'
}

const showModelDeleteSure = (id, name, routeDelete) => {
    const content = document.querySelector('#modelSmallContent')
    const link = document.querySelector('#modelSmallLink')
    
    if(content && link) {
        content.innerHTML = `Are you sure delete <strong>${name}</strong> ?`
        link.setAttribute('href', `${routeDelete}${id}`)
    }


} 