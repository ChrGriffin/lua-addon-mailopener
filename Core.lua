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
	-- set the button text
	button:SetText("Open Mail")
	-- set the frame level of the button
	-- currently not 100% clear on what this does
	-- context, however, would indicate that it's essentially the 'z-axis' position
	-- I would imagine this is simply to position it ABOVE certain elements that might cover it otherwise
	button:SetFrameLevel(button:GetFrameLevel() + 1)
	-- set a script to be called on click
	-- SetScript has two arguments
	-- the first argument is the handler (essentially, which event calls the script)
	-- in this case, that would be 'OnClick'
	-- the second argument is the actual script to be run
	-- in this case, the script to be run simply calls another function
	-- but it would be entirely possible to have an 'inline' or 'embedded' function instead
	-- the script can also be set to nil to remove the handler
	-- (for example, if there is default behaviour you want to remove)
	-- a good example of common usage of removing default behaviour is:
	-- PartyMemberFrame1:SetScript("OnShow", nil)
	-- this would prevent the default party frame from displaying...
	-- ...allowing you to display your own custom one
	button:SetScript("OnClick", function() MailOpener:TestAlert() end)
end

function MailOpener:OnDisable()
	-- when the addon is disabled
end

-- test function to determine if the button is registering clicks and calling the function
function MailOpener:TestAlert()
	-- we're gonna paint a happy little message to let us known the button is working
	MailOpener:Print('The button is working!')
	-- GetInboxNumItems returns two numbers
	-- the first number is the amount of messages currently being displayed in the inbox
	-- (the max is 50 if memory serves? I might be wrong, test it later)
	-- the second number is the total amount of messages in the inbox
	-- if you have more than the maximum showable messages in your mailbox, there will be a...
	---...small delay for the mailbox to refresh and display the next set of messages once you've...
	-- ...cleared out the first batch
	shownItems, totalItems = GetInboxNumItems()
	-- some more happy little messages to display some debug information
	MailOpener:Print('shownItems: ' .. shownItems)
	MailOpener:Print('totalItems: ' .. totalItems)
	-- using shownItems as the index, loop through every message
	-- for my own reference: note the syntax of the for loop, slightly different than PHP or JS
	-- in particular, note that the middle value (the 'ceiling', if you will) differs functionally
	-- in PHP or JS, the 'middle' section must evaluate to true for the loop to continue
	-- ie, for(i=0, i<=shownItems, 1++)
	-- whereas in Lua the middle value is the maximum value i can be before it stops running
	-- notably, it's the maximum value INCLUSIVELY
	-- so if you have two items in your mailbox, this will run twice, not once as it might in PHP
	-- this caused great confusion initially as I was trying to set the maximum to shownItems+1
	for i=1, shownItems, 1 do
		-- get information about this message
		packageIcon, stationeryIcon, sender, subject, money, CODAmount, daysLeft, hasItem, wasRead, wasReturned, textCreated, canReply, isGM = GetInboxHeaderInfo(i);
		
		-- MailOpener:Print('Message ' .. i .. ', packageIcon: ' .. tostring(packageIcon)) -- texture path for package icon if it contains a package (nil otherwise)
		-- MailOpener:Print('Message ' .. i .. ', stationeryIcon: ' .. stationeryIcon) -- texture path for mail message icon
		-- MailOpener:Print('Message ' .. i .. ', sender: ' .. sender) -- name of the player who sent the message
		-- MailOpener:Print('Message ' .. i .. ', subject: ' .. subject) -- the message subject
		-- MailOpener:Print('Message ' .. i .. ', money: ' .. money) -- the amount of money attached (inc. 0)
		-- MailOpener:Print('Message ' .. i .. ', CODAmount: ' .. CODAmount) -- the amount of COD payment required to receive the package (inc. 0)
		-- MailOpener:Print('Message ' .. i .. ', daysLeft: ' .. daysLeft) -- The number of days before the message expires (fractional)
		-- MailOpener:Print('Message ' .. i .. ', hasItem: ' .. tostring(hasItem)) -- either the number of attachments or nil if no items are present
		-- MailOpener:Print('Message ' .. i .. ', wasRead: ' .. tostring(wasRead)) -- 1 if the mail has been read, nil otherwise
		-- MailOpener:Print('Message ' .. i .. ', wasReturned: ' .. tostring(wasReturned)) -- 1 if the mail was returned, nil otherwise
		-- MailOpener:Print('Message ' .. i .. ', textCreated: ' .. tostring(textCreated)) -- 1 if a letter object has been created from this mail, nil otherwise
		-- MailOpener:Print('Message ' .. i .. ', canReply: ' .. tostring(canReply)) -- 1 if this letter can be replied to, nil otherwise
		-- MailOpener:Print('Message ' .. i .. ', isGM: ' .. tostring(isGM)) -- 1 if this letter was sent by a GameMaster
		
		-- display a single message in chat about this message
		MailOpener:Print('Message ' .. i .. '; From: ' .. sender .. '; Subject: ' .. subject .. '; Attached Items: ' .. tostring(hasItem))
	end
end