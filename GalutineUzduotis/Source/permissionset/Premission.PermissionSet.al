permissionset 77000 ZINUPremission
{
    Assignable = true;
    Permissions =
        tabledata ZINUAutoSetup = RIMD, // Read, Insert, Modify, Delete
        table ZINUAutoSetup = X,
        tabledata ZINUAutoMark = RIMD,
        tabledata ZINUAutoModel = RIMD,
        tabledata ZINUAuto = RIMD,
        tabledata ZINUAutoReservation = RIMD,
        tabledata ZINUAutoDamage = RIMD,
        tabledata ZINUAutoRentHeader = RIMD,
        tabledata ZINUAutoRentLine = RIMD,
        tabledata ZINUAutoRentDamage = RIMD,
        tabledata ZINUFinishedAutoRentHeader = RIMD,
        tabledata ZINUFinishedAutoRentLine = RIMD;
}
