----#include root\coffinkeeper
warriors = 0
wait_id = 0

function onLoad(save_state)
    createButtons()
    wait_id = Wait.time(updateButtons, 1, -1)
end

function onDestroy()
    Wait.stop(wait_id)
end

function nothing()
end

function addWarrior(name)
    name = name:lower()
	if string.match(name, "warrior") then
		warriors = warriors + 1
    end
end

function createButtons()
  self.createButton({
      click_function = "nothing",
      function_owner = self,
      label = '0',
	  position = {0.21, 1.7, 0.98}, 
	  rotation = {14, 90, -90}, 
	  scale = {0.5, 0.5, 0.5}, 
	  width = 0,
      height = 0,
	  font_size = 450
  })
end

function updateButtons()
    warriors = 0
    items = Physics.cast({
        origin       = self.positionToWorld({0, 0, 0.1}),
        direction    = self.getTransformUp(),
		orientation  = Vector(self.getRotation()) + Vector({0, 87, 0}), --{0, 87, 0},
        type         = 3,
        size         = {11.5, 7, 7},
        max_distance = 2
    })
    for _, item in ipairs(items) do
        if item.hit_object.tag == "Figurine" then
            addWarrior(item.hit_object.getName())
        end
    end

    self.editButton({index=0,label=tostring(math.floor(warriors/5))})
end
----#include root\coffinkeeper