<link href="https://fonts.googleapis.com/css?family=Nunito+Sans&display=swap" rel="stylesheet">
<style type="text/css">
*{
	margin: 0px;
	padding: 0px;
	box-sizing: border-box;
}

body{
	background: #f2f2f2;
	font-family: 'Nunito Sans', sans-serif;
	font-size: 18px;
	padding-top: 100px; /*separacion entre el header y el body*/
}

header{
	background-color: #FFFFFF;/*#0900B5*/
	position: fixed;
	width: 100%;
	top: 0px;
        z-index: 1000;
}

.menu{
	width: 90%;
	max-width: 1000px;
	margin: auto;
	display: flex;
	flex-direction: row;
	justify-content: space-between;
	align-items: center;
} 
.menu .logo{
	display: inline-block;
	margin-right: 1em;
}

.logo img{
	vertical-align: top;
	height: 80px;
	color: white;
}

.menu .btn-menu{/*el icono menú*/
	display: none;
	text-decoration: none;
	font-size: 1em;/*1em = 16px*/
}

.menu .logo:hover{
	background: #ffff; 
} 	

.menu .enlaces{
	display: inline-block;
	text-align: right;
}

.menu .enlaces a{
	color: #0900b5;
	text-decoration: none;
	display: inline-block;
	padding: 1.25em; /*1em = 16px*/
	text-align: center;
}

.menu .enlaces i{
	margin-right: 10px;
}

.menu .enlaces a:hover{
	background-color: #0900b5;
	color: #ffff;
	-webkit-transition:800ms ease;
	-o-transition:all 800ms ease;
	transition:all 800ms ease;
	border-radius: 50px;
	display: inline-block;/*cada menu este al lado del otro*/
	text-decoration: none;
	padding: 10px 20px;
	line-height: normal;
	font-size: 20px;
	font-weight: bold;

}

main{
	width: 90%;
	max-width: 1000px;
	margin: 2px auto;
	background-color: #ffff;
	box-shadow: 0px 2px 5px rgba(0,0,0,0.5);
}
</style>
