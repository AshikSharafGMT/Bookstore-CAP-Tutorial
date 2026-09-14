using {tutorial.db as db} from '../db/schema';

service BookstoreService {
    entity Books      as projection on db.Books
        actions {
            @(Common.SideEffects: {TargetProperties: ['stock']})
            action addStock();
            @(Common.SideEffects: {TargetProperties: ['publishedAt']})
            action changePublishDate(newDate: Date);
            @(Common.SideEffects: {TargetEntities: ['in']})
            action changeStatus( @(Common: {

                                     ValueListWithFixedValues: true,
                                     Label                   : 'New Status',
                                     ValueList               : {
                                         $Type         : 'Common.ValueListType',
                                         CollectionPath: 'BookStatus',
                                         Parameters    : [
                                             {
                                                 $Type            : 'Common.ValueListParameterOut',
                                                 LocalDataProperty: newStatusID,
                                                 ValueListProperty: 'ID',
                                             },
                                             {
                                                 $Type            : 'Common.ValueListParameterInOut',
                                                 LocalDataProperty: newStatus,
                                                 ValueListProperty: 'code',
                                             },
                                         ],
                                     },
                                 })
                                 newStatus: String,
                                 @(Common: {Label: 'New Status ID'})
                                 newStatusID: String);
        };

    @(Common.SideEffects: {TargetEntities: ['/BookstoreService.EntityContainer/Books']})
    action addDiscount();

    entity Authors    as projection on db.Authors;
    entity Chapters   as projection on db.Chapters;
    entity BookStatus as projection on db.BookStatus;
    entity Genres     as projection on db.Genres
}


annotate BookstoreService.Books with @odata.draft.enabled;
