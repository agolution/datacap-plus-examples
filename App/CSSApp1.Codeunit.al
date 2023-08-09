codeunit 50100 "CSS App 1"
{
    TableNo = "AGO DC Session";

    var
        Screen: Codeunit "AGO DC Screen Hlp.";
        Variable: Codeunit "AGO DC Variable Hlp.";

    trigger OnRun()
    begin
        Screen.Run(Rec);
        Variable.Run(Rec);

        BuildScreen();
    end;

    local procedure BuildScreen();
    var
        Reason: Record "Return Reason";
        Loop: Integer;
        ButtonCaption: Label '%1 - %2', Locked = true;
        Description: Text;
    begin
        Screen.Header('Reklamationsmeldung');

        if not GetSelectedReturnReason(Reason) then begin
            Screen.Input('ReasonValue', 'Reklamationsgrund', '');

            Reason.FindSet();
            repeat
                Loop += 1;

                if Reason."MDE Description" <> '' then
                    Description := Reason."MDE Description"
                else
                    Description := Reason.Description;

                Screen.ButtonClass(
                    'ReasonCode' + Reason.Code,
                    StrSubstNo(ButtonCaption, Loop, Description),
                    Format(Reason."MDE CSS Class"));
            until Reason.Next() = 0;
        end else begin
            Screen.Info('Reklamationsgrund: ' + Reason.Description);
            Screen.ButtonShowApps('Zurück zu den Anwendungen');
        end;
    end;

    local procedure GetSelectedReturnReason(var ReturnReason: Record "Return Reason"): Boolean;
    var
        ReturnValueText: Text;
        ReturnValue: Integer;
        Loop: Integer;
    begin
        Clear(ReturnReason);

        ReturnValueText := Variable.GetText('ReasonValue');
        if ReturnValueText <> '' then
            if Evaluate(ReturnValue, ReturnValueText) then begin
                if ReturnValue > 0 then begin
                    ReturnReason.FindSet();
                    repeat
                        Loop += 1;
                        if Loop = ReturnValue then
                            exit(true);
                    until ReturnReason.Next() = 0;
                end;
            end;

        ReturnReason.FindSet();
        repeat
            if Variable.Exist('ReasonCode' + ReturnReason.Code) then
                exit(true);
        until ReturnReason.Next() = 0;
    end;
}
