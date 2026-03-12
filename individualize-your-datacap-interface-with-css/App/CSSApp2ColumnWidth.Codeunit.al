codeunit 50101 "AGO CSS App 2 (Column Width)"
{
    Permissions = tabledata "AGO DC Setup" = r;
    TableNo = "AGO DC Session";

    trigger OnRun()
    begin
        Screen.Run(Rec);
        Variable.Run(Rec);
        Audio.Run(Rec);

        GetGlobals();
        ShowScreen();
        SetGlobals();
    end;

    var
        Screen: Codeunit "AGO DC Screen Hlp.";
        Variable: Codeunit "AGO DC Variable Hlp.";
        Audio: Codeunit "AGO DC Audio Hlp.";
        CurrSite: Option Site1,Site2,Site3;
        CurrAction: Text[20];
        CurrShowOptions: Boolean;
        ColumnWidthExampleLbl: Label 'Column Width Example', Comment = 'DEU="Spaltenbreitenbeispiel"';
        NextSiteLbl: Label 'Next Site', Comment = 'DEU="Nächste Seite"';
        PrevSiteLbl: Label 'Previous Site', Comment = 'DEU="Vorherige Seite"';
        SiteLbl: Label 'Site', Comment = 'DEU="Seite"';
        SiteNoLbl: Label 'Site %1', Comment = 'DEU="Seite %1"';
        ExitApplicationLbl: Label 'Exit Application', Comment = 'DEU="Anwendung beenden"';

    local procedure ShowScreen()
    begin
        case CurrSite of
            CurrSite::Site1:
                ScreenSite1();
            CurrSite::Site2:
                ScreenSite2();
            CurrSite::Site3:
                ScreenSite3();
        end;
    end;

    local procedure ScreenSite1()
    var
        InputValue: Text;
    begin
        SetCurrentSite(CurrSite::Site1);

        InputValue := Variable.GetText('CurrAction');

        if InputValue <> '' then begin
            case InputValue of
                NextSiteLbl:
                    begin
                        ResetAction();
                        ScreenSite2();
                        exit;
                    end;
                ExitApplicationLbl:
                    begin
                        ResetAction();
                        ScreenEnd();
                        exit;
                    end;
            end;
        end;

        ShowHeader();
        Screen.LabelClass(SiteLbl, StrSubstNo(SiteNoLbl, 1), 'Class25Width');  // defined in Custom.css
        Screen.ButtonValue('CurrAction', NextSiteLbl, NextSiteLbl);
        Screen.ButtonValue('CurrAction', ExitApplicationLbl, ExitApplicationLbl);
    end;

    local procedure ScreenSite2()
    var
        InputValue: Text;
    begin
        SetCurrentSite(CurrSite::Site2);

        InputValue := Variable.GetText('CurrAction');

        if InputValue <> '' then begin
            case InputValue of
                PrevSiteLbl:
                    begin
                        ResetAction();
                        ScreenSite1();
                        exit;
                    end;
                NextSiteLbl:
                    begin
                        ResetAction();
                        ScreenSite3();
                        exit;
                    end;
                ExitApplicationLbl:
                    begin
                        ScreenEnd();
                        exit;
                    end;
            end;
        end;

        ShowHeader();
        Screen.LabelClass(SiteLbl, StrSubstNo(SiteNoLbl, 2), 'Class50Width'); // defined in Custom.css
        Screen.ButtonValue('CurrAction', PrevSiteLbl, PrevSiteLbl);
        Screen.ButtonValue('CurrAction', NextSiteLbl, NextSiteLbl);
        Screen.ButtonValue('CurrAction', ExitApplicationLbl, ExitApplicationLbl);
    end;

    local procedure ScreenSite3()
    var
        InputValue: Text;
    begin
        SetCurrentSite(CurrSite::Site3);

        InputValue := Variable.GetText('CurrAction');

        if InputValue <> '' then begin
            case InputValue of
                PrevSiteLbl:
                    begin
                        ResetAction();
                        ScreenSite2();
                        exit;
                    end;
                ExitApplicationLbl:
                    begin
                        ScreenEnd();
                        exit;
                    end;
            end;
        end;

        ShowHeader();
        Screen.LabelClass(SiteLbl, StrSubstNo(SiteNoLbl, 3), 'Class75Width'); // defined in Custom.css
        Screen.ButtonValue('CurrAction', PrevSiteLbl, PrevSiteLbl);
        Screen.ButtonValue('CurrAction', ExitApplicationLbl, ExitApplicationLbl);
    end;

    local procedure ShowHeader()
    begin
        Screen.Header(ColumnWidthExampleLbl);
    end;

    local procedure ScreenEnd()
    begin
        SetCurrentSite(CurrSite::Site1);
        Variable.DeleteAll();
        Screen.ButtonShowApps(ExitApplicationLbl);
    end;

    local procedure GetGlobals()
    begin
        CurrSite := Variable.GetInt('CurrSite');
        CurrAction := Variable.GetText('CurrAction');
    end;

    local procedure SetGlobals()
    begin
        Variable.SetInt('CurrSite', CurrSite);
        Variable.SetText('CurrAction', CurrAction);
    end;

    local procedure ResetAction()
    begin
        Variable.SetText('CurrAction', '');
    end;

    local procedure SetCurrentSite(NewCurrSite: Option Site1,Site2,Site3)
    begin
        CurrSite := NewCurrSite;
    end;
}