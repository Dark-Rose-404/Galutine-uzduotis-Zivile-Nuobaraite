codeunit 77000 "ZINUAuto Rent Management"
{
    procedure ReturnAuto(var AutoRentHeader: Record ZINUAutoRentHeader)
    var
        FinishedAutoRentHeader: Record ZINUFinishedAutoRentHeader;
        FinishedAutoRentLine: Record ZINUFinishedAutoRentLine;
        AutoRentLine: Record ZINUAutoRentLine;
        AutoRentDamage: Record ZINUAutoRentDamage;
        AutoDamage: Record ZINUAutoDamage;
        LineNo: Integer;
        ConfirmReturnQst: Label 'Do you want to return the automobile?';
        ReturnCompletedMsg: Label 'Automobile has been returned successfully.';
    begin
        if not Confirm(ConfirmReturnQst) then
            exit;

        // Create finished rental header
        FinishedAutoRentHeader.Init();
        FinishedAutoRentHeader.TransferFields(AutoRentHeader);
        FinishedAutoRentHeader.Insert();

        // Copy rental lines
        AutoRentLine.SetRange("Document No.", AutoRentHeader."No.");
        if AutoRentLine.FindSet() then
            repeat
                FinishedAutoRentLine.Init();
                FinishedAutoRentLine.TransferFields(AutoRentLine);
                FinishedAutoRentLine.Insert();
            until AutoRentLine.Next() = 0;

        // Transfer damages to auto damage table
        AutoRentDamage.SetRange("Document No.", AutoRentHeader."No.");
        if AutoRentDamage.FindSet() then begin
            AutoDamage.SetRange("Auto No.", AutoRentHeader."Auto No.");
            if AutoDamage.FindLast() then
                LineNo := AutoDamage."Line No." + 10000
            else
                LineNo := 10000;

            repeat
                AutoDamage.Init();
                AutoDamage."Auto No." := AutoRentHeader."Auto No.";
                AutoDamage."Line No." := LineNo;
                AutoDamage.Date := AutoRentDamage.Date;
                AutoDamage.Description := AutoRentDamage.Description;
                AutoDamage.Status := AutoDamage.Status::Active;
                AutoDamage.Insert();
                LineNo += 10000;
            until AutoRentDamage.Next() = 0;
        end;

        // Delete original rental document
        AutoRentLine.DeleteAll();
        AutoRentDamage.DeleteAll();
        AutoRentHeader.Delete();

        Message(ReturnCompletedMsg);
    end;
}
