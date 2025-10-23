const functions = require("firebase-functions");
const admin = require("firebase-admin");
const Razorpay = require("razorpay");

admin.initializeApp();

// --- ZAROORI: Apni Razorpay Keys Yahan Dalni Hongi ---
const razorpay = new Razorpay({
  key_id: "YOUR_RAZORPAY_KEY_ID", 
  key_secret: "YOUR_RAZORPAY_KEY_SECRET", 
});

exports.createRazorpayOrder = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'User must be logged in.');
  }

  const amount = data.amount; 
  if (!amount || amount < 10) { 
      throw new functions.https.HttpsError('invalid-argument', 'Invalid amount. Minimum amount is 10.');
  }

  try {
    const order = await razorpay.orders.create({
      amount: amount * 100, 
      currency: 'INR',
      receipt: `receipt_${context.auth.uid}_${Date.now()}`,
      payment_capture: 1, 
    });
    
    return { order_id: order.id, amount: order.amount / 100, currency: order.currency };
  } catch (error) {
    console.error("Razorpay Order Creation Error:", error);
    throw new functions.https.HttpsError('internal', 'Failed to create Razorpay order.');
  }
});

exports.razorpayWebhook = functions.https.onRequest(async (req, res) => {
    // Iska URL hi Razorpay Webhook mein dalna hai!
    console.log("Webhook received! Logic to verify payment will be here.");
    return res.status(200).send("OK - Webhook Received by GAMERZ ADDA");
});