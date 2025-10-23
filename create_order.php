<?php
// File: create_order.php
// InfinityFree ke htdocs/ ya public_html/ mein rakhein

// PHP mein Razorpay SDK ki zaroorat hogi
// Aapko 'razorpay-php' folder ko bhi yahan upload karna hoga
require('razorpay-php/Razorpay.php'); 

use Razorpay\Api\Api;

// --- ZAROORI: Apni Test Keys Daalein Yahan ---
// Jab aap Ready honge, toh Test Keys ki jagah Live Keys daalenge
$keyId = "YOUR_RAZORPAY_TEST_KEY_ID"; 
$keySecret = "YOUR_RAZORPAY_TEST_KEY_SECRET"; 

$api = new Api($keyId, $keySecret);

// Flutter App se data (amount aur user_id) aayega
$amount = isset($_POST['amount']) ? $_POST['amount'] : 0;
$user_id = isset($_POST['user_id']) ? $_POST['user_id'] : 'guest_'.time();

if ($amount < 10) { 
    header('Content-Type: application/json');
    echo json_encode(['status' => 'error', 'message' => 'Minimum amount is 10']);
    exit;
}

try {
    $order = $api->order->create([
        'receipt' => 'receipt_'. $user_id . '_' . time(),
        'amount' => $amount * 100, // paise mein convert
        'currency' => 'INR',
        'payment_capture' => 1,
        'notes' => [ // User ID ko notes mein daalna zaroori hai
            'user_id' => $user_id 
        ]
    ]);

    // Order details Flutter App ko wapas bhejte hain
    header('Content-Type: application/json');
    echo json_encode([
        'status' => 'success',
        'order_id' => $order['id'],
        'amount' => $order['amount'] / 100,
        'key' => $keyId 
    ]);

} catch (\Exception $e) {
    header('Content-Type: application/json');
    echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
}
?>