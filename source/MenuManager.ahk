#Include TRAYMENU_LAYOUT.ahk
#Include core.ahk

class MenuManager {
    _LAYOUT := [] ; imported definition of the layout
    _traymenu := A_trayMenu

    static TYPES :=
    { ; Enumeration for all types of items
        ACTION: 0,
        /*  - used as DEFAULT
            - type can be omitted
        */
        GROUP: 1,
        /*  - child items listed above each other
            - displays a line before and after the group
            - doesn't show title
        */
        SUBMENU: 2,
        /*  - display title as single item
            - hovering over it expands a new menu with child item
        */
    }

    /** Constructor
    */
    __New(layout) {
        this._LAYOUT := layout
        this._parseLayout()
        this.update()
    }

    /** Rerender the entire traymenu.
    */
    update() {
        this.clear()
        this._attachItem(this._traymenu, this._LAYOUT)
    }


    /** Print the current traymenu layout into a file
        @param {string} [filename=traymenu.txt] - file to override
    recursion internal:
        @param {Object[]} [layer=_LAYOUT] - array of items to recursively iterate through
        @param {int} [layerIndex=0] - position within the current layer
        @param {int} [first=false] - is it the first item of the current layer?
        @param {int} [last=false] - is it the last item of the current layer?
    */
    logAll(filename:="traymenu.txt", layer:=false, layerIndex:=0, first:=false, last:=false) {
        if (!layer)
        { ; start recursion at top level of layout definition
            if (fileExist(filename))
            { ; only delete if it exists
                fileDelete(filename)
            }
            layer := this._LAYOUT
        }

        indent := "" 
        loop layerIndex
        {
            indent  := indent  " "
        }


        if (first && last)
        {
            draw := "└"
        }
        else if (first)
        {
            draw := "├"
        }
        else if (last)
        {
            draw := "└"
        }
        else
        {
            draw := "├"
        }
        
        line := indent draw " " layer.id "`n"
                
        fileAppend(line, filename, "UTF-8")

        if (layer.hasOwnProp("content"))
        {
            max := layer.content.Length
            for i, item in layer.content
            {
                first := (i = 1)
                last := (i = max)
                this.logAll(filename, item, layerIndex + 1, first, last)
            }
        }
    }

    /** Create necessary {Menu} objects for all submenus or groups.
        - to display a submenu, items must be attached to an existing {Menu} object
        @param {Object[]} [layer=_LAYOUT] - array of items to recursively parse through
     */
    _parseLayout(layer:=false)
    {
        if (!layer)
        { ; start recursion at top level of layout definition
            layer := this._LAYOUT
            layer.menu := this._traymenu
        }
        else
        {
            layer.menu := Menu() ; create a new submenu object
        }
        layer.menu.name := layer.id ; name the submenu object to differentiate then

        logIfDebug("parseLayout", "layer:`t" layer.id, "content:`t" layer.content.Length)

        this._dissolveSymbolicLinks(&layer)
    }


    /** Recursively replace all symbolic links with a copy of their referenced content.
        @param {Object[]} [layer=_LAYOUT] - array of items to recursively parse through
     */
    _dissolveSymbolicLinks(&layer) {
        i := 1
        while (i <= layer.content.Length)
        {
            item := layer.content[i]

            if (this._isSymbolicLink(item))
            {
                this._pasteReferencedContent(item, &(layer.content[i]))
                logIfDebug("linked content", "layer:`t" layer.id, "content:`t" layer.content.Length)
                i-- ; iterate through the newly pasted linked items as well
            }
            else if (this._isValidItem(item))
            {
                if (item.hasOwnProp("content"))
                {
                    this._parseLayout(item)
                }
            }
            i++
        }
    }


    _isSymbolicLink(item) {
        return item is string
    }

    _isValidItem(item) {
        return (item is object) && item.hasOwnProp("id")
    }

    _pasteReferencedContent(item, &destination) {
        destination := this._findItem(item)
    }



    /** Get the type of an item.
        - returns a {MenuManager.TYPES} value
        @param {Object} item - item of interest
     */
    _getType(item) {
        itemType := MenuManager.TYPES.ACTION ; default is action

        if (item.hasOwnProp("content"))
        { ; item is a group or submenu
            if (item.hasOwnProp("maxDisplay"))
            { ; a maximum number of displayed child items before using a submenu is set                
                if(item.maxDisplay = 0)
                { ; force to display a submenu
                    return MenuManager.TYPES.SUBMENU
                }

                if (item.maxDisplay != -1 && item.content.Length > item.maxDisplay)
                { ; too many children => display a submenu
                    return MenuManager.TYPES.SUBMENU
                }
                else 
                { ; not too many children => display a group
                    return MenuManager.TYPES.GROUP
                }
            }
            else
            { ; no maximun number of displayed child items before using a submenu is set => display group
                return MenuManager.TYPES.GROUP
            }
        }

    }

    /** Clear the entire traymenu.
        @param {Object[]} [layer=_LAYOUT] - array of items to recursively clear through
    */
    clear(layer:=false) {
        if (!layer)
        { ; start recursion at top level of layout definition
            layer := this._LAYOUT
        }
        layer.menu.delete()
        layer.menu.isEmpty := true

        for item in layer.content
        {
            if (item is object)
            { ; item is a proper item
                if (item.hasOwnProp("content"))
                {
                    this.clear(item)
                }
            }
        }
    }



    /** Attach an item to the traymenu or a submenu.
        @param {Menu} menu - traymenu or submenu to which is attached
        @param {Object} item - group, submenu or action to attach
        @param {string} [icon=false] - icon to inherit from parent group of submenu
    */
    _attachItem(menu, item, icon:=false) {
        if (!icon && item.hasOwnProp("icon"))
        { ; no icon to inherit but this item has it's own icon
            icon := item.icon
        }
        
        ; MsgBox("attachItem`nitem:`t" item.id "`nmenu:`t" menu.name)

        switch this._getType(item)
        {
        case MenuManager.TYPES.GROUP:           
            menu.doLine := true ; remember to add a seperator line before the next item on this submenu level
            for child in item.content
            {
                this._attachItem(menu, child, icon)
            }
            menu.doLine := true ; remember to add a seperator line before the next item on this submenu level

        case MenuManager.TYPES.SUBMENU:
            for child in item.content
            {
                this._attachItem(item.menu, child, icon)
            }

            ; attach and display the submenu to the traymenu or another submenu
            this._drawLine(menu)
            menu.add(item.text, item.menu)
            this._drawIcon(menu, item, icon)
            menu.isEmpty := false ; flag non-empty menus

        default: ; item in a proper action
            ; attach and display the action to the traymenu or a submenu
            this._drawLine(menu)
            menu.add(item.text, handler)
            this._drawIcon(menu, item, icon)
            menu.isEmpty := false ; flag non-empty menus

        }
    }


    /** return an item by id
        @param {string} id - id of the item of interest
        @param {Object[]} [layer=_LAYOUT] - array of items to recursively search through
    */
    _findItem(id, layer:=false) {
        if (!layer)
        { ; recursion starts at the root of the definition
            layer := this._LAYOUT
        }

        for item in layer.content
        {
            if (item is object)
            { ; item is a proper item
                if (item.id = id)
                {
                    return item
                }
                else if (item.hasOwnProp("content"))
                {
                    item := this._findItem(id, item)
                    if (item)
                    { ; found a valid item
                        return item
                    }
                }
            } 
        }
        return false ; couldn't find item
    }


    /** Draw a seperator line if requested previously.
        @param {Menu} menu - traymenu or submenu to which is drawn
    */
    _drawLine(menu) {
        if (menu.hasOwnProp("isEmpty") && !menu.isEmpty)
        { ; menu is not empty
            if (menu.hasOwnProp("doLine") && menu.doLine) {
                menu.add() ; add a seperator line
                menu.doLine := false
            }
        }
        else
        { ; menu is empty
            menu.doLine := false
        }
    }

    /** Display the correct icon for a submenu or action
        @param {Menu} menu - traymenu or submenu to which is drawn
        @param {Object} item - action or submenu to apply the icon to
        @param {string[2]/string} icon - icon to be applied, path or [path, index]
    */
    _drawIcon(menu, item, icon) {
        if (icon is array)
        { ; icon contains a path and index
            menu.setIcon(item.text, icon[1], icon[2]) 
        }
        else if(icon is string)
        { ; icon only contains a path
            menu.setIcon(item.text, icon)
        }
        else
        { ; no icon is set
        }
    }

}

handler(itemName, itemPos, menu) {
    log("Clicked on tray:", "Text:`t" itemName, "Position:`t" itemPos, "Menu:`t" menu.name)
}