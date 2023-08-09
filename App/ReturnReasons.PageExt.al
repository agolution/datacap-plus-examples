pageextension 50100 "Return Reasons" extends "Return Reasons"
{
    layout
    {
        addlast(Control1)
        {
            field("MDE CSS Class"; rec."MDE CSS Class")
            {
                ApplicationArea = All;
            }
            field("MDE Description"; rec."MDE Description")
            {
                ApplicationArea = All;
            }
        }
    }
}