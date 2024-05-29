<!DOCTYPE html>
<html>
<head>
    <style>
        .im {
            border-radius: 50%;
            height: 180px;
            animation: myAnim 7s ease-in 2s infinite normal forwards;
        }
        
        @keyframes myAnim {
            0% {
                transform: rotate(0);
            }
            100% {
                transform: rotate(360deg);
            }
        }
    </style>
</head>
<body>
    <img class="im" src="" id="rotatingImage" />

    <script>
        
        const imageUrls = [
            './p1.jpg',
            './p2.jpg', 
            './p3.jpg', 
            './p4.jpg'
              
        ];

        // Function to rotate the images
        function rotateImages() {
            const rotatingImage = document.getElementById('rotatingImage');
            let currentImageIndex = 0;

            function nextImage() {
                rotatingImage.src = imageUrls[currentImageIndex];
                currentImageIndex = (currentImageIndex + 1) % imageUrls.length;
            }

            // Trigger nextImage function on every animation iteration
            rotatingImage.addEventListener('animationiteration', nextImage);
            nextImage(); // Show the first image immediately
        }

        // Call the rotateImages function when the page loads
        window.onload = rotateImages;
    </script>
</body>
</html>
