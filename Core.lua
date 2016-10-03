MailOpener = LibStub("AceAddon-3.0"):NewAddon('MailOpener', "AceConsole-3.0")

MailOpener:Print('Greetings!')

function MailOpener:OnInitialize()
	-- when the addon is first loaded
end

function MailOpener:OnEnable()
	-- create a frame called 'button'
	-- CreateFrame has four arguments
	-- the first argument is the type of frame being created (in this case, 'Button')
	-- the second argument is the name of the frame (in this case, 'MailOpenerButton')
	-- due to my current inexperience, I'm not certain what purpose the name serves
	-- it nonetheless seems wise to give it a descriptive and unique identifier
	-- the third argument is the parent frame (in this case, we want the button...
	-- ...to appear in the mail inbox, so the parent is 'InboxFrame')
	-- the fourth argument is what virtual frame, if any, this new frame inherits from
	-- (in this case, we're inheriting from the pre-existing UI button template, 'UIPanelButtonTemplate')
	button = CreateFrame("Button", "MailOpenerButton", InboxFrame, "UIPanelButtonTemplate")
	-- set the width and height of the button
	-- appears to NOT be pixel values, but is definitely a hard value
	button:SetWidth(100)
	button:SetHeight(30)
	-- position the button where we want it inside the InboxFrame
	-- SetPoint (a function of created frames) has five arguments
	-- the first argument is which point we are anchoring (in this case, "CENTER")
	-- the second argument is what the object is positioned relative TO
	-- if omitted it defaults to its parent element, if explicitly passed nil it positions relative to the screen
	-- we want it positioned relative to the mail inbox, so we've passed it InboxFrame
	-- the third argument is WHICH point on the parent frame the new frame is positioned relative to
	-- so, for example, we want to position our button RELATIVE to the TOP RIGHT CORNER of the mail inbox...
	-- ...so, we pass it "TOPRIGHT"
	-- the fourth and fifth arguments are Offset X and Offset Y, respectively
	-- these are the same hard values as before
	button:SetPoint("TOPRIGHT", InboxFrame, "TOPRIGHT", -55, -25)
	button:SetText("Open Mail")
	--button:SetScript("OnClick", function() Postal_OpenAll:OpenAll() end)
	button:SetFrameLevel(button:GetFrameLevel() + 1)
end

function MailOpener:OnDisable()
	-- when the addon is disabled
end