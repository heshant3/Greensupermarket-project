package com.example.supermarket;

import com.paypal.api.payments.*;
import com.paypal.base.rest.APIContext;
import com.paypal.base.rest.PayPalRESTException;

import java.util.ArrayList;
import java.util.List;

public class PaymentService {

    private static final String CLIENT_ID = "AWGjv11Yxg4K1pzexVRF7w-Rnz1cYg3CjIGcfZa30-oCdQFDfytBDWKRZt7MbB-E_xtrRgbg80RV3Zuc";
    private static final String CLIENT_SECRET = "EGq_KOfmvB9sjBvqDJX68FZPkrFQz7Zit8HsQExwVhA9IcFZwYOwTW2sBefz3ofFpcFZQvRMbtLrgowR";
    private static final String MODE = "sandbox"; // or "live"

    public String createPayment(Double total) throws PayPalRESTException {
        APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);

        Amount amount = new Amount();
        amount.setCurrency("USD");
        amount.setTotal("10.00");
        ;

        Transaction transaction = new Transaction();
        transaction.setAmount(amount);

        List<Transaction> transactions = new ArrayList<>();
        transactions.add(transaction);

        Payment payment = new Payment();
        payment.setIntent("sale");
        payment.setPayer(new Payer().setPaymentMethod("paypal"));
        payment.setTransactions(transactions);
        payment.setRedirectUrls(new RedirectUrls()
                .setReturnUrl("http://localhost:8082/supermarket_war/thankyou")
                .setCancelUrl("http://localhost:8082/supermarket_war/cancel"));

        Payment createdPayment = payment.create(apiContext);
        String approvalLink = createdPayment.getLinks().stream()
                .filter(link -> link.getRel().equals("approval_url"))
                .findFirst()
                .orElseThrow(() -> new IllegalStateException("Approval link not found"))
                .getHref();

        return approvalLink;
    }
}