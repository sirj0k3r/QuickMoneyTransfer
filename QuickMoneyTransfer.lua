local QMT_bf = AccountBankPanel.MoneyFrame;

AccountBankPanel:HookScript("OnShow", function()
    if (QMT_bf.btnWithdrawAll == nil) then
        AddWithdrawAll();
    end
    if (QMT_bf.btnDepositAll == nil) then
        AddDepositAll();
    end
end)

function AddDepositAll()
    local frame = QMT_bf.btnWithdrawAll;
    local btn = CreateFrame("Button", "btnDepositAll", frame, "UIPanelButtonTemplate"); 
    btn:SetSize(100, 21);
    btn:SetText("Deposit All"); 
    btn:SetPoint("LEFT", frame, "RIGHT", 1, 0);

    QMT_bf.btnDepositAll = btn;

    btn:SetScript("OnClick", function()
        C_Bank.DepositMoney(2, GetMoney());
    end)
end

function AddWithdrawAll()
    local frame = AccountBankPanel.MoneyFrame;
    local btn = CreateFrame("Button", "btnWithdrawAll", frame, "UIPanelButtonTemplate"); 
    btn:SetSize(100, 21);
    btn:SetText("Withdraw All");
    btn:SetPoint("RIGHT", frame, "LEFT", -235, 1);

    QMT_bf.btnWithdrawAll = btn;

    btn:SetScript("OnClick", function()
        C_Bank.WithdrawMoney(2, C_Bank.FetchDepositedMoney(2));
    end)
end
