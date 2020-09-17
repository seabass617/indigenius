import curDot from "cursor-dot"

//colors
// $dark_green: #797D62;
// $light_green: #9B9B7A;
// $pink: #D9AE94;
// $dark_yellow: #FFCB69;
// $light_yellow: #F1DCA7;
// $orange: #D08C60;
// $brown: #997B66;
// $brown-black: #1c1a17; 
// $off-white: #fffffa;

const cursor = curDot({
//   zIndex: 2,
//   diameter: 80,
//   borderWidth: 1,
//   borderColor: 'transparent',
//   easing: 4,
//   background: '#ddd'
// })
    background: "#997B66",
    borderColor: '#transparent',
    diameter: 20,
    easing: 3,
});

cursor.over(".workshop-image", {
    background: '#797D62',
    borderColor: '#D9AE94',
    scale: .5,
});

cursor.over("h1", {
    background: "#fff",
    scale: 3,
});

cursor.over("p", {
    background: "#fff",
    scale: 3,
});

cursor.over("a", {
    borderWidth: 1,
    borderColor: 'transparent',
    background: '#D9AE94',
    scale: 2,
});

export { curDot };
