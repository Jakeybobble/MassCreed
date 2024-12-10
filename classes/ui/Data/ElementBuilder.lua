-- ElementBuilder: Builds elements from a called build method rather than from the elements tree
inherit("Element")

function class:init(options, elements)
    self.super.init(self, options, elements)
    self.build_func = assert(options.build_func, "ElementBuilder is missing a build func")

end

function class:build(args)
    self.elements = {}
    self:add_child(self.build_func(self, args))

end