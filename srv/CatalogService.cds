using {ust.shiva.prasad.db.master, ust.shiva.prasad.db.transaction } from '../db/datamodel';
 
 
service CatalogService @(path: 'CatalogService') {
 
    entity ProductSet as projection on master.product;
    entity BusinessPartnerSet as projection on master.businesspartner;
    entity BusinessAddressSet as projection on master.address;
 
    entity POs @(odata.draft.enabled: true) as projection on transaction.purchaseorder{
        *,
        Items,
        case OVERALL_STATUS
            when 'P' then 'Pending'
            when 'N' then 'New'
            when 'A' then 'Approved'
            when 'X' then 'Rejected'
            end as OverallStatus : String(10),
        case OVERALL_STATUS
            when 'P' then 2
            when 'N' then 2
            when 'A' then 3
            when 'X' then 1
            end as ColorCode : Integer,
    }
   
    entity POItems as projection on transaction.poitems;
   
 
}