tableextension 50100 "Return Reason" extends "Return Reason"
{
    fields
    {
        field(50100; "MDE CSS Class"; Enum "CSS Class")
        {
            DataClassification = SystemMetadata;
            Caption = 'MDE CSS Class';
        }
        field(50101; "MDE Description"; Text[100])
        {
            DataClassification = SystemMetadata;
            Caption = 'MDE Description';
        }
    }
}