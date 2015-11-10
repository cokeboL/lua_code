local template = {}

function template:actLoading()
	-- ex.loadingAnimation()
end

-- init module 
function template:initVars()
	self.scene = nil
	self.layer = nil
	self.widget = nil
	self.isAllDataGot = nil

	self.loadFrameCount = 0
end

function template:getData()
	local err = "err"
	--callback self.setData onNetMessage comming
	--net:request("template", self.setData)
	self.setData(3)
end

-- setData should be called when net message requested by getData is comming
function template.setData(data_)
	local self = template
	if(self.err)then
		self:errHandler(self.err)
	end
	
    self.unlockNodes = {}
    for i=1, 10 do
        self.unlockNodes[i] = 1
    end

	self.isAllDataGot = true;
	if(self.isAllDataGot)then
		self:loadScene()
	end
end

function template:loadResource()
	self.loadFrameCount = self.loadFrameCount + 1

	if self.loadFrameCount == 2 then

	elseif self.loadFrameCount == 4 then

	elseif self.loadFrameCount == 6 then

	elseif self.loadFrameCount == 8 then

	elseif self.loadFrameCount == 10 then
		self.loadNode:removeFromParent()
	end
end

function template:onEnter()
	util.enableCurrSceneTouch()
	
	self.widget = ccs.GUIReader:getInstance():widgetFromJsonFile(res.ccs_main)
	self.layer:addChild(self.widget)
    self.layer:addChild(statusBar.getLayer(), 1)

    --[[
    local function startLoadResource()
    	schedule(self.loadNode, self.loadResource, 0)
    end
    startLoadResource()
    --]]
    schedule(self.loadNode, self.loadResource, 0)
end

function template:onExit()
	
end

function template:loadScene()
	self.scene = util.Scene()
	
	self.layer = util.Layer()
    self.scene:addChild(self.layer)

	self.layer:registerScriptHandler(function(eventType)
	    if "enter" == eventType then
	        self:onEnter()
	    elseif "exit" == eventType then
	    	self:onExit()
	    end
	end)    

	self.loadNode = util.Node()
	self.layer:addChild(self.loadNode)

    director.runScene(self.scene, self.clear)
end

function template:resetLanguage()	

end

function template:errHandler(err)

end

function template.clear()
	util.clearModule(template)
end

function template:run()	
	-- push loading UI to the running scene
	util.disableCurrSceneTouch()

	self:actLoading()
	
	-- init module base data
	self:initVars()
	
	-- get server data by net
	self:getData()
end

-- ************************************

-- ************************************

return template
