<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Contact Us - GREEN Supermarket</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.js"></script>

    <style>
        .bg-dark-green {
            background-color: #276749;
        }
    </style>
</head>
<body class="bg-gray-100">

<header class="bg-dark-green text-white py-6">
    <div class="container mx-auto text-center">
        <h1 class="text-3xl font-bold">Contact GREEN Supermarket</h1>
    </div>
</header>

<div class="container mx-auto mt-10">
    <div class="flex flex-wrap justify-center">
        <div class="w-full md:w-1/2 bg-white p-6 rounded shadow-md">
            <h2 class="text-xl font-bold mb-4 text-dark-green">Get in Touch</h2>
            <form action="submitContactForm" method="post">
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2" for="name">Name</label>
                    <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="name" name="name" type="text" placeholder="Your Name">
                </div>
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2" for="email">Email</label>
                    <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="email" name="email" type="email" placeholder="Your Email">
                </div>
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2" for="message">Message</label>
                    <textarea class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="message" name="message" rows="4" placeholder="Your Message"></textarea>
                </div>
                <div class="flex items-center justify-between">
                    <button class="bg-dark-green hover:bg-green-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline" type="submit">
                        Send Message
                    </button>
                </div>
            </form>
        </div>
        <div class="w-full md:w-1/2 p-6">
            <h2 class="text-xl font-bold mb-4 text-dark-green">Contact Information</h2>
            <p class="mb-4">Address: 123 Green Avenue, Colombo, Sri Lanka</p>
            <p class="mb-4">Email: contact@greensupermarket.lk</p>
            <p>Phone: +94 12 345 6789</p>
        </div>
    </div>
</div>

<footer class="bg-dark-green text-white py-8 mt-12">
    <div class="container mx-auto text-center">
        <h5 class="text-xl font-semibold mb-4">GREEN Supermarket</h5>
        <p>Address: 123 Green Avenue, Colombo, Sri Lanka</p>
        <p>Email: contact@greensupermarket.lk | Phone: +94 12 345 6789</p>
    </div>
</footer>
</body>
</html>
