<html>
    <jsp:useBean id="account_info" scope="session" class="Controllers.AccountController" />
    <% account_info.logout();%>
<head>
  
    <title>IoTBay logout page</title>
    <link rel="stylesheet" href="landing.css" type="text/css"/>
    <style>
        .welcome-container {
            perspective: 1000px;
            opacity: 0;
            animation: fadeIn 3s forwards;
        }

        .progress-bar-container {
            width: 400px;
            height: 20px;
            background-color: #ddd;
            border-radius: 10px;
            overflow: hidden;
            margin: 50px auto;
        }

        .progress-bar {
            height: 100%;
            background-color: #4CAF50;
            width: 0%;
            transition: width 2s ease-in-out;
            animation: progress-bar-fill 7s linear forwards;
        }

        .thank-you-message {
            text-align: center;
            font-size: 24px;
            opacity: 0;
        }

        body {
            animation: backgroundAnimation 10s infinite;
        }

        @keyframes fadeIn {
            0% {
                opacity: 0;
            }
            100% {
                opacity: 1;
            }
        }

        @keyframes progress-bar-fill {
            from {
                width: 0%;
            }
            to {
                width: 100%;
            }
        }

        @keyframes backgroundAnimation {
            0% {
                background-color: #f5f5f5;
            }
            50% {
                background-color: #e0e0e0;
            }
            100% {
                background-color: #f5f5f5;
            }
        }
    </style>

    <script>
        function redirectToLandingPage() 
        {
            var progressBar = document.querySelector('.progress-bar');
            var thankYouMe = document.querySelector('.thank-you-message');
            progressBar.addEventListener('animationend', function() 
            {
                thankYouMe.style.opacity = '1';
                setTimeout(function() {
                    window.location.href = 'index.jsp';
                }, 3000);
            });
        }
    </script>
</head>
<body onload="redirectToLandingPage()">
    <header>
       
        <h1>IoTBay</h1>
    </header>
    <div class="welcome-container">
        <h1>Thank you for shopping at our IoTBay store. Come back and shop again next time, we look forward to providing you with great service!</h1>
    </div>
    <div class="progress-bar-container">
        <div class="progress-bar"></div>
    </div>
    <div class="thank-you-message">See you soon! LoGOut For Now</div>
    <footer>
    <p>&copy; 2023 IoTBay All Rights Reserved</p>
    </footer>
</body>
</html>
