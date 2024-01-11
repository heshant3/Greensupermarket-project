<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - GREEN Supermarket</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/login.css">
    <script src="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.js"></script>

</head>
<body class="bg-gray-100 flex items-center justify-center h-screen">
<div class="w-full max-w-xs">
    <div class="login-container bg-white px-8 pt-6 pb-8 mb-4 rounded">
        <div class="mb-4">
            <h3 class="login-title text-center text-2xl font-bold mb-6">Login</h3>
            <form action="loginPage" method="post" name="login">
                <div class="mb-4">
                    <label for="username" class="block text-gray-700 text-sm font-bold mb-2">Username:</label>
                    <input type="text" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="username" name="username" required>
                </div>
                <div class="mb-6">
                    <label for="password" class="block text-gray-700 text-sm font-bold mb-2">Password:</label>
                    <input type="password" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3 leading-tight focus:outline-none focus:shadow-outline" id="password" name="password" required>
                </div>
                <div class="flex items-center justify-between">
                    <button type="submit" class="btn-login w-full py-2 px-4 rounded focus:outline-none focus:shadow-outline font-bold">Login</button>
                </div>
            </form>
        </div>
    </div>
</div>


</body>
</html>
