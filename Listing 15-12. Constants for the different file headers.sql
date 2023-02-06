l_mollie_headers constant apex_t_varchar2
    := apex_t_varchar2
       ('DATE_'
       ,'PAYMENT_METHOD'
       ,'CURRENCY'
       ,'AMOUNT'
       ,'STATUS'
       ,'ID'
       ,'DESCRIPTION'
       ,'CONSUMER_NAME'
       ,'CONSUMER_BANK_ACCOUNT'
       ,'CONSUMER_BIC'
       ,'SETTLEMENT_CURRENCY'
       ,'SETTLEMENT_AMOUNT'
       ,'SETTLEMENT_REFERENCE'
       ,'AMOUNT_REFUNDED'
       );
l_paypal_headers constant apex_t_varchar2
   := apex_t_varchar2
      ('DATE_'
      ,'TIME'
      ,'TIME_ZONE'
      ,'DESCRIPTION'
      ,'CURRENCY'
      ,'GROSS'
      ,'FEE'
      ,'NET'
      ,'BALANCE'
      ,'TRANSACTION_ID'
      ,'FROM_EMAIL_ADDRESS'
      ,'NAME'
      ,'BANK_NAME'
      ,'BANK_ACCOUNT'
      ,'SHIPPING_AND_HANDLING_AMOUNT'
      ,'SALES_TAX'
      ,'INVOICE_ID'
      ,'REFERENCE_TXN_ID'
      );