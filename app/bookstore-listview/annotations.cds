using BookstoreService as service from '../../srv/service';
using from '@sap/cds/common';


annotate service.Books with @(
    UI.FieldGroup #GeneratedGroup  : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: genre_code,
                Label: 'Genre',
            },
            {
                $Type: 'UI.DataField',
                Label: 'Published At',
                Value: publishedAt,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Pages',
                Value: pages,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Price',
                Value: price,
            },
            {
                $Type: 'UI.DataField',
                Value: title,
                Label: 'Title',
            },
            {
                $Type                    : 'UI.DataField',
                Value                    : Status_code,
                Label                    : 'Status Code',
                Criticality              : Status.criticality,
                CriticalityRepresentation: #WithIcon,
            },
            {
                $Type : 'UI.DataField',
                Value : currency_code,
                Label : 'Currency',
            },
        ],
    },
    UI.Facets                      : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneratedFacet1',
            Label : 'General Information',
            Target: '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Entry Information',
            ID    : 'EntryInformation',
            Target: '@UI.FieldGroup#EntryInformation',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Chapters',
            ID    : 'Chapters',
            Target: 'Chapters/@UI.LineItem#Chapters',
        },
    ],
    UI.LineItem                    : [
        {
            $Type: 'UI.DataField',
            Label: 'Book Name',
            Value: title,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Genre',
            Value: genre_code,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Published At',
            Value: publishedAt,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Pages',
            Value: pages,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Price',
            Value: price,
        },
        {
            $Type: 'UI.DataField',
            Value: author_ID,
            Label: 'Author',
        },
        {
            $Type: 'UI.DataField',
            Value: stock,
            Label: 'Stock',
        },
        {
            $Type      : 'UI.DataField',
            Value      : Status_code,
            Label      : 'Status',
            Criticality: Status.criticality,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'BookstoreService.addStock',
            Label : 'Add Stock',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'BookstoreService.EntityContainer/addDiscount',
            Label : '10% Discount',
        },
    ],
    UI.SelectionFields             : [
        price,
        Status.code,
    ],
    UI.HeaderInfo                  : {
        Title         : {
            $Type: 'UI.DataField',
            Value: title,
        },
        TypeName      : 'Book',
        TypeNamePlural: 'Books',
        Description   : {
            $Type: 'UI.DataField',
            Value: genre_code,
        },
        TypeImageUrl  : 'sap-icon://course-book',
    },
    UI.FieldGroup #EntryInformation: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: createdAt,
            },
            {
                $Type: 'UI.DataField',
                Value: createdBy,
            },
            {
                $Type: 'UI.DataField',
                Value: modifiedAt,
            },
            {
                $Type: 'UI.DataField',
                Value: modifiedBy,
            },
        ],
    },
    UI.HeaderFacets                : [{
        $Type : 'UI.ReferenceFacet',
        Label : 'Availability',
        ID    : 'Header',
        Target: '@UI.FieldGroup#Header',
    }, ],
    UI.FieldGroup #Header          : {
        $Type: 'UI.FieldGroupType',
        Data : [{
            $Type                    : 'UI.DataField',
            Value                    : Status.code,
            Criticality              : Status.criticality,
            CriticalityRepresentation: #WithIcon,
        }, ],
    },
    UI.Identification : [
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'BookstoreService.addStock',
            Label : 'Add Stock',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'BookstoreService.changePublishDate',
            Label : 'Change Publish Date',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'BookstoreService.changeStatus',
            Label : 'Change Status',
        },
    ],
);

annotate service.Books with {
    author @Common.ValueList: {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'Authors',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: author_ID,
                ValueListProperty: 'ID',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'name',
            },
        ],
    }
};

annotate service.Books with {
    price @Common.Label: 'Price'
};

annotate service.Chapters with @(UI.LineItem #Chapters: [
    {
        $Type: 'UI.DataField',
        Value: book.Chapters.title,
        Label: 'Title',
    },
    {
        $Type: 'UI.DataField',
        Value: book.Chapters.pages,
        Label: 'Pages',
    },
    {
        $Type: 'UI.DataField',
        Value: book.Chapters.number,
        Label: 'Number',
    },
]);

annotate service.Books with {
    Status @(
        Common.Text                    : Status.displayText,
        Common.Text.@UI.TextArrangement: #TextOnly,
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'BookStatus',
            Parameters    : [{
                    $Type            : 'Common.ValueListParameterOut',
                    LocalDataProperty: Status_ID,
                    ValueListProperty: 'ID',
                },
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: Status_code,
                    ValueListProperty: 'code',
                },
            ],
        },
        Common.ValueListWithFixedValues: true,
    )
};

annotate service.BookStatus with {
    code @(
        Common.Label                   : 'Status',
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'BookStatus',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: code,
                ValueListProperty: 'code',
            }, ],
        },
        Common.ValueListWithFixedValues: true,
        Common.Text                    : displayText,
        Common.Text.@UI.TextArrangement: #TextOnly,
    )
};
annotate service.Books with {
    currency @Common.ValueListWithFixedValues : true
};

annotate service.Currencies with {
    code @(
        Common.Text : name,
        )};

annotate service.Books with {
    genre @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Genres',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : genre_code,
                    ValueListProperty : 'code',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
)};

