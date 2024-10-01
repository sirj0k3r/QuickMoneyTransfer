QMT_TransactionOptions = nil;

AccountBankPanel:HookScript("OnShow", function()
    QMT_CreateTransactionOptions();
    QMT_DrawTransactionOptionsButtons();
    QMT_ToggleButtonAvailability();
    QMT_TransactionOptions:Show();
end)

AccountBankPanel:HookScript("OnHide", function()
    QMT_TransactionOptions:Hide();
end)

AccountBankPanel:HookScript("OnEvent", function(_, event)
    if (event == "ACCOUNT_MONEY") then
       QMT_ToggleButtonAvailability();
    end
end)

function QMT_CreateTransactionOptions()
    if (QMT_TransactionOptions == nil) then
        QMT_TransactionOptions = CreateFrame("Frame", nil, UIParent, "BackdropTemplate");
        QMT_TransactionOptions:SetSize(200, 165);
        QMT_TransactionOptions:SetPoint("TOPRIGHT", BankFrame, "BOTTOMRIGHT", -7.5, 7.5);

        QMT_TransactionOptions:SetBackdrop({
            bgFile = "Interface/BankFrame/Bank-Background",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            tile = true, tileSize = 64, edgeSize = 16,
            insets = { left = 4, right = 4, top = 4, bottom = 4 }
        });
        QMT_TransactionOptions:SetBackdropColor(255, 255, 255, 0.8);
        QMT_TransactionOptions:SetFrameStrata("LOW");
    end
end

function QMT_ToggleButtonAvailability()
    
    
    local bankMoney = C_Bank.FetchDepositedMoney(Enum.BankType.Account) / 100 / 100;
    local bagMoney = GetMoney() / 100 / 100;

    if (bankMoney <= 0) then
        QMT_DisableAllWithdrawButtons();
    else
        QMT_TransactionOptions.btnWithdrawAll:Enable();
        QMT_TransactionOptions.btnWithdrawHalf:Enable();
        if (bankMoney >= 1000) then
            QMT_TransactionOptions.btnWithdraw1K:Enable();
        else
            QMT_TransactionOptions.btnWithdraw1K:Disable();
        end
        if (bankMoney >= 10000) then
            QMT_TransactionOptions.btnWithdraw10K:Enable();
        else
            QMT_TransactionOptions.btnWithdraw10K:Disable();
        end
        if (bankMoney >= 100000) then
            QMT_TransactionOptions.btnWithdraw100K:Enable();
        else
            QMT_TransactionOptions.btnWithdraw100K:Disable();
        end
        if (bankMoney >= 1000000) then
            QMT_TransactionOptions.btnWithdraw1M:Enable();
        else
            QMT_TransactionOptions.btnWithdraw1M:Disable();
        end
    end

    if (bagMoney <= 0) then
        QMT_DisableAllDepositButtons();
    else
        QMT_TransactionOptions.btnDepositAll:Enable();
        QMT_TransactionOptions.btnDepositHalf:Enable();
        if (bagMoney >= 1000) then
            QMT_TransactionOptions.btnDeposit1K:Enable();
        else
            QMT_TransactionOptions.btnDeposit1K:Disable();
        end
        if (bagMoney >= 10000) then
            QMT_TransactionOptions.btnDeposit10K:Enable();
        else
            QMT_TransactionOptions.btnDeposit10K:Disable();
        end
        if (bagMoney >= 100000) then
            QMT_TransactionOptions.btnDeposit100K:Enable();
        else
            QMT_TransactionOptions.btnDeposit100K:Disable();
        end
        if (bagMoney >= 1000000) then
            QMT_TransactionOptions.btnDeposit1M:Enable();
        else
            QMT_TransactionOptions.btnDeposit1M:Disable();
        end
    end
end

function QMT_DisableAllDepositButtons()
    QMT_TransactionOptions.btnDepositAll:Disable();
    QMT_TransactionOptions.btnDepositHalf:Disable();
    QMT_TransactionOptions.btnDeposit1K:Disable();
    QMT_TransactionOptions.btnDeposit10K:Disable();
    QMT_TransactionOptions.btnDeposit100K:Disable();
    QMT_TransactionOptions.btnDeposit1M:Disable();
end

function QMT_DisableAllWithdrawButtons()
    QMT_TransactionOptions.btnWithdrawAll:Disable();
    QMT_TransactionOptions.btnWithdrawHalf:Disable();
    QMT_TransactionOptions.btnWithdraw1K:Disable();
    QMT_TransactionOptions.btnWithdraw10K:Disable();
    QMT_TransactionOptions.btnWithdraw100K:Disable();
    QMT_TransactionOptions.btnWithdraw1M:Disable();
end

function QMT_DrawTransactionOptionsButtons()
    QMT_DrawTransactionOptionsWithdrawButtons();
    QMT_DrawTransactionOptionsDepositButtons();
end

function QMT_DrawTransactionOptionsWithdrawButtons()
    if (QMT_TransactionOptions.btnWithdrawAll == nil) then
        QMT_TransactionOptions.btnWithdrawAll = CreateFrame("Button", nil, QMT_TransactionOptions, "UIPanelButtonTemplate");
        QMT_TransactionOptions.btnWithdrawAll:SetSize(50, 20);
        QMT_TransactionOptions.btnWithdrawAll:SetText("100%");
        QMT_TransactionOptions.btnWithdrawAll:SetPoint("TOPLEFT", QMT_TransactionOptions, "TOPLEFT", 25, -10);

        QMT_TransactionOptions.btnWithdrawAll:SetScript("OnClick", function()
            C_Bank.WithdrawMoney(Enum.BankType.Account, C_Bank.FetchDepositedMoney(Enum.BankType.Account));
        end)
    end
    if (QMT_TransactionOptions.btnWithdrawHalf == nil) then
        QMT_TransactionOptions.btnWithdrawHalf = CreateFrame("Button", nil, QMT_TransactionOptions, "UIPanelButtonTemplate");
        QMT_TransactionOptions.btnWithdrawHalf:SetSize(50, 20);
        QMT_TransactionOptions.btnWithdrawHalf:SetText("50%");
        QMT_TransactionOptions.btnWithdrawHalf:SetPoint("TOP", QMT_TransactionOptions.btnWithdrawAll, "BOTTOM", 0, -5);

        QMT_TransactionOptions.btnWithdrawHalf:SetScript("OnClick", function()
            C_Bank.WithdrawMoney(Enum.BankType.Account, C_Bank.FetchDepositedMoney(Enum.BankType.Account) / 2);
        end)
    end
    if (QMT_TransactionOptions.btnWithdraw1K == nil) then
        QMT_TransactionOptions.btnWithdraw1K = CreateFrame("Button", nil, QMT_TransactionOptions, "UIPanelButtonTemplate");
        QMT_TransactionOptions.btnWithdraw1K:SetSize(50, 20);
        QMT_TransactionOptions.btnWithdraw1K:SetText("1K");
        QMT_TransactionOptions.btnWithdraw1K:SetPoint("TOP", QMT_TransactionOptions.btnWithdrawHalf, "BOTTOM", 0, -5);

        QMT_TransactionOptions.btnWithdraw1K:SetScript("OnClick", function()
            C_Bank.WithdrawMoney(Enum.BankType.Account, 1000*100*100);
        end)
    end
    if (QMT_TransactionOptions.btnWithdraw10K == nil) then
        QMT_TransactionOptions.btnWithdraw10K = CreateFrame("Button", nil, QMT_TransactionOptions, "UIPanelButtonTemplate");
        QMT_TransactionOptions.btnWithdraw10K:SetSize(50, 20);
        QMT_TransactionOptions.btnWithdraw10K:SetText("10K");
        QMT_TransactionOptions.btnWithdraw10K:SetPoint("TOP", QMT_TransactionOptions.btnWithdraw1K, "BOTTOM", 0, -5);

        QMT_TransactionOptions.btnWithdraw10K:SetScript("OnClick", function()
            C_Bank.WithdrawMoney(Enum.BankType.Account, 10000*100*100);
        end)
    end
    if (QMT_TransactionOptions.btnWithdraw100K == nil) then
        QMT_TransactionOptions.btnWithdraw100K = CreateFrame("Button", nil, QMT_TransactionOptions, "UIPanelButtonTemplate");
        QMT_TransactionOptions.btnWithdraw100K:SetSize(50, 20);
        QMT_TransactionOptions.btnWithdraw100K:SetText("100K");
        QMT_TransactionOptions.btnWithdraw100K:SetPoint("TOP", QMT_TransactionOptions.btnWithdraw10K, "BOTTOM", 0, -5);

        QMT_TransactionOptions.btnWithdraw100K:SetScript("OnClick", function()
            C_Bank.WithdrawMoney(Enum.BankType.Account, 100000*100*100);
        end)
    end
    if (QMT_TransactionOptions.btnWithdraw1M == nil) then
        QMT_TransactionOptions.btnWithdraw1M = CreateFrame("Button", nil, QMT_TransactionOptions, "UIPanelButtonTemplate");
        QMT_TransactionOptions.btnWithdraw1M:SetSize(50, 20);
        QMT_TransactionOptions.btnWithdraw1M:SetText("1M");
        QMT_TransactionOptions.btnWithdraw1M:SetPoint("TOP", QMT_TransactionOptions.btnWithdraw100K, "BOTTOM", 0, -5);

        QMT_TransactionOptions.btnWithdraw1M:SetScript("OnClick", function()
            C_Bank.WithdrawMoney(Enum.BankType.Account, 1000000*100*100);
        end)
    end
end

function QMT_DrawTransactionOptionsDepositButtons()
    if (QMT_TransactionOptions.btnDepositAll == nil) then
        QMT_TransactionOptions.btnDepositAll = CreateFrame("Button", nil, QMT_TransactionOptions, "UIPanelButtonTemplate");
        QMT_TransactionOptions.btnDepositAll:SetSize(50, 20);
        QMT_TransactionOptions.btnDepositAll:SetText("100%");
        QMT_TransactionOptions.btnDepositAll:SetPoint("TOPRIGHT", QMT_TransactionOptions, "TOPRIGHT", -25, -10);

        QMT_TransactionOptions.btnDepositAll:SetScript("OnClick", function()
            C_Bank.DepositMoney(Enum.BankType.Account, GetMoney());
        end)
    end
    if (QMT_TransactionOptions.btnDepositHalf == nil) then
        QMT_TransactionOptions.btnDepositHalf = CreateFrame("Button", nil, QMT_TransactionOptions, "UIPanelButtonTemplate");
        QMT_TransactionOptions.btnDepositHalf:SetSize(50, 20);
        QMT_TransactionOptions.btnDepositHalf:SetText("50%");
        QMT_TransactionOptions.btnDepositHalf:SetPoint("TOP", QMT_TransactionOptions.btnDepositAll, "BOTTOM", 0, -5);

        QMT_TransactionOptions.btnDepositHalf:SetScript("OnClick", function()
            C_Bank.DepositMoney(Enum.BankType.Account, GetMoney() / 2);
        end)
    end
    if (QMT_TransactionOptions.btnDeposit1K == nil) then
        QMT_TransactionOptions.btnDeposit1K = CreateFrame("Button", nil, QMT_TransactionOptions, "UIPanelButtonTemplate");
        QMT_TransactionOptions.btnDeposit1K:SetSize(50, 20);
        QMT_TransactionOptions.btnDeposit1K:SetText("1K");
        QMT_TransactionOptions.btnDeposit1K:SetPoint("TOP", QMT_TransactionOptions.btnDepositHalf, "BOTTOM", 0, -5);

        QMT_TransactionOptions.btnDeposit1K:SetScript("OnClick", function()
            C_Bank.DepositMoney(Enum.BankType.Account, 1000*100*100);
        end)
    end
    if (QMT_TransactionOptions.btnDeposit10K == nil) then
        QMT_TransactionOptions.btnDeposit10K = CreateFrame("Button", nil, QMT_TransactionOptions, "UIPanelButtonTemplate");
        QMT_TransactionOptions.btnDeposit10K:SetSize(50, 20);
        QMT_TransactionOptions.btnDeposit10K:SetText("10K");
        QMT_TransactionOptions.btnDeposit10K:SetPoint("TOP", QMT_TransactionOptions.btnDeposit1K, "BOTTOM", 0, -5);

        QMT_TransactionOptions.btnDeposit10K:SetScript("OnClick", function()
            C_Bank.DepositMoney(Enum.BankType.Account, 10000*100*100);
        end)
    end
    if (QMT_TransactionOptions.btnDeposit100K == nil) then
        QMT_TransactionOptions.btnDeposit100K = CreateFrame("Button", nil, QMT_TransactionOptions, "UIPanelButtonTemplate");
        QMT_TransactionOptions.btnDeposit100K:SetSize(50, 20);
        QMT_TransactionOptions.btnDeposit100K:SetText("100K");
        QMT_TransactionOptions.btnDeposit100K:SetPoint("TOP", QMT_TransactionOptions.btnDeposit10K, "BOTTOM", 0, -5);

        QMT_TransactionOptions.btnDeposit100K:SetScript("OnClick", function()
            C_Bank.DepositMoney(Enum.BankType.Account, 100000*100*100);
        end)
    end
    if (QMT_TransactionOptions.btnDeposit1M == nil) then
        QMT_TransactionOptions.btnDeposit1M = CreateFrame("Button", nil, QMT_TransactionOptions, "UIPanelButtonTemplate");
        QMT_TransactionOptions.btnDeposit1M:SetSize(50, 20);
        QMT_TransactionOptions.btnDeposit1M:SetText("1M");
        QMT_TransactionOptions.btnDeposit1M:SetPoint("TOP", QMT_TransactionOptions.btnDeposit100K, "BOTTOM", 0, -5);

        QMT_TransactionOptions.btnDeposit1M:SetScript("OnClick", function()
            C_Bank.DepositMoney(Enum.BankType.Account, 1000000*100*100);
        end)
    end
end