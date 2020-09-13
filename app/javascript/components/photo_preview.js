const previewImageOnFileSelect = () => {
  // select the photo input
  const input = document.getElementById('photo-input');
  if (input) {
    // listener to know when a new picture is uploaded
    input.addEventListener('change', () => {
      displayPreview(input);
    })
  }
}

const displayPreview = (input) => {
  if (input.files && input.files[0]) {
    const reader = new FileReader();
    reader.onload = (event) => {
      document.getElementById('photo-preview').src = event.currentTarget.result;
    }
    reader.readAsDataURL(input.files[0])
    document.getElementById('photo-preview').classList.remove('hidden');
  }
}

export { previewImageOnFileSelect };