report 77000 "ZINUAuto Rent Contract"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem("Auto Rent Header"; ZINUAutoRentHeader)
        {
            column(No_; "No.")
            {
                IncludeCaption = true;
            }
            column(Customer_No_; "Customer No.")
            {
                IncludeCaption = true;
            }
            column(Auto_No_; "Auto No.")
            {
                IncludeCaption = true;
            }
            column(Reserved_From_Date; "Reserved From Date")
            {
                IncludeCaption = true;
            }
            column(Reserved_To_Date; "Reserved To Date")
            {
                IncludeCaption = true;
            }
            column(Rental_Amount; RentalAmount)
            {
            }
            column(Services_Amount; ServicesAmount)
            {
            }
            column(Total_Amount; TotalAmount)
            {
            }
            column(AutoMarkDescription; AutoMarkDescription)
            {
            }
            column(AutoModelDescription; AutoModelDescription)
            {
            }
            column(CustomerName; CustomerName)
            {
            }

            dataitem("Auto Rent Line"; ZINUAutoRentLine)
            {
                DataItemLink = "Document No." = field("No.");
                column(Type; Type)
                {
                    IncludeCaption = true;
                }
                column(No_Line; "No.")
                {
                    IncludeCaption = true;
                }
                column(Description; Description)
                {
                    IncludeCaption = true;
                }
                column(Quantity; Quantity)
                {
                    IncludeCaption = true;
                }
                column(Unit_Price; "Unit Price")
                {
                    IncludeCaption = true;
                }
                column(Amount; Amount)
                {
                    IncludeCaption = true;
                }
                column(IsFirstLine; IsFirstLine)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IsFirstLine := ("Line No." = 10000);
                end;
            }

            trigger OnAfterGetRecord()
            var
                Auto: Record ZINUAuto;
                AutoMark: Record ZINUAutoMark;
                AutoModel: Record ZINUAutoModel;
                Customer: Record Customer;
                AutoRentLine: Record ZINUAutoRentLine;

            begin
                // Get auto details
                if Auto.Get("Auto No.") then begin
                    if AutoMark.Get(Auto.Mark) then
                        AutoMarkDescription := AutoMark.Description;
                    if AutoModel.Get(Auto.Mark, Auto.Model) then
                        AutoModelDescription := AutoModel.Description;
                end;

                // Get customer name
                if Customer.Get("Customer No.") then
                    CustomerName := Customer.Name;

                // Calculate amounts
                AutoRentLine.SetRange("Document No.", "No.");
                AutoRentLine.SetRange("Line No.", 10000);
                if AutoRentLine.FindFirst() then
                    RentalAmount := AutoRentLine.Amount;

                AutoRentLine.SetRange("Line No.");
                AutoRentLine.SetFilter("Line No.", '>%1', 10000);
                AutoRentLine.CalcSums(Amount);
                ServicesAmount := AutoRentLine.Amount;

                CalcFields(Amount);
                TotalAmount := Amount;
            end;
        }
    }

    requestpage
    {
        AboutTitle = 'title';
        AboutText = 'about text';

        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }
    }
    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'rdl/AutoRentCardList.rdl';
        }
    }

    labels
    {
        ReportName = 'Auto Rent Card';
        RentalAmountCap = 'Rental Amount:';
        ServicesAmountCap = 'Services Amount:';
        TotalAmountCap = 'Total Amount:';
        CustomerNameCap = 'Customer Name:';
        AutoMarkCap = 'Mark:';
        AutoModelCap = 'Model:';
    }

    var
        CustomerName: Text[100];
        RentalAmount: Decimal;
        ServicesAmount: Decimal;
        TotalAmount: Decimal;
        IsFirstLine: Boolean;
        AutoMarkDescription: Text[100];
        AutoModelDescription: Text[100];

}
