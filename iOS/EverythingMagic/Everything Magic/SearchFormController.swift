//
//  NewSearchFormController.swift
//  Everything Magic
//
//  Created by Spencer McWilliams on 11/25/15.
//  Copyright © 2015 Spencer McWilliams. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class SearchFormController: UITableViewController {
    enum field: Int { case Cardtype, Subtype, Supertype, Set, Rarity, Color, Multicolor, Format, Status, Default }
    var currentField: field = field.Default
    var params = [String: String]()
    let picker = UIPickerView()
    
    @IBOutlet weak var nameField:       UITextField!
    @IBOutlet weak var typeField:       UITextField!
    @IBOutlet weak var subtypeField:    UITextField!
    @IBOutlet weak var supertypeField:  UITextField!
    @IBOutlet weak var oracleField:     UITextField!
    @IBOutlet weak var setField:        UITextField!
    @IBOutlet weak var rarityField:     UITextField!
    @IBOutlet weak var colorField:      UITextField!
    @IBOutlet weak var multicolorField: UITextField!
    @IBOutlet weak var formatField:     UITextField!
    @IBOutlet weak var statusField:     UITextField!
    
    @IBAction func search(sender: AnyObject) {
        Alamofire.request(.GET, "https://api.deckbrew.com/mtg/cards", parameters: params).responseData { response in
            QueryManager.instance.cards = JSON.init(data: response.result.value!)
            print(response.request)
            self.performSegueWithIdentifier("resultsSegue", sender: self)
        }
    }
    
    override func viewDidLoad() {
        self.typeField.inputView        = picker
        self.subtypeField.inputView     = picker
        self.supertypeField.inputView   = picker
        self.setField.inputView         = picker
        self.rarityField.inputView      = picker
        self.colorField.inputView       = picker
        self.multicolorField.inputView  = picker
        self.formatField.inputView      = picker
        self.statusField.inputView      = picker

        self.picker.delegate = self
        self.picker.dataSource = self
        
        self.tableView.backgroundColor = UIColor.clearColor()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bkg2")!)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        if !QueryManager.instance.currentSet.isEmpty {
            self.setField.text = QueryManager.instance.currentSet
            params["set"] = self.setField.text!
        }
        QueryManager.instance.clean(false, cards: true, singleCard: true)
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.clearColor()
    }
}

extension SearchFormController: UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {
        if      textField.isEqual(typeField)        { currentField = .Cardtype   }
        else if textField.isEqual(subtypeField)     { currentField = .Subtype    }
        else if textField.isEqual(supertypeField)   { currentField = .Supertype  }
        else if textField.isEqual(setField)         { currentField = .Set        }
        else if textField.isEqual(rarityField)      { currentField = .Rarity     }
        else if textField.isEqual(colorField)       { currentField = .Color      }
        else if textField.isEqual(multicolorField)  { currentField = .Multicolor }
        else if textField.isEqual(formatField)      { currentField = .Format     }
        else if textField.isEqual(statusField)      { currentField = .Status     }
        
        if (!textField.isEqual(nameField) && !textField.isEqual(oracleField)) {
            picker.selectRow(0, inComponent: 0, animated: false)
            picker.reloadAllComponents()
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        var fieldString = String()
        if textField.isEqual(nameField)             { fieldString = "name"       }
        else if textField.isEqual(typeField)        { fieldString = "type"       }
        else if textField.isEqual(subtypeField)     { fieldString = "subtype"    }
        else if textField.isEqual(supertypeField)   { fieldString = "supertype"  }
        else if textField.isEqual(oracleField)      { fieldString = "oracle"     }
        else if textField.isEqual(setField)         { fieldString = "set"        }
        else if textField.isEqual(rarityField)      { fieldString = "rarity"     }
        else if textField.isEqual(colorField)       { fieldString = "color"      }
        else if textField.isEqual(multicolorField)  { fieldString = "multicolor" }
        else if textField.isEqual(formatField)      { fieldString = "format"     }
        else if textField.isEqual(statusField)      { fieldString = "status"     }
        
        if (textField.text!.isEmpty || textField.text! == "-"){
            if params[fieldString] != nil {
                self.params.removeAtIndex(params.indexForKey(fieldString)!)
            }
            textField.text = "-"
            QueryManager.instance.clean(false, cards: true, singleCard: true)
        }
        else {
            self.params[fieldString] = textField.text!
            if fieldString == "set" {
                QueryManager.instance.currentSet = textField.text!
                print(QueryManager.instance.currentSet)
            }
        }
        currentField = .Default
        resignFirstResponder()
    }
}

extension SearchFormController: UIPickerViewDataSource, UIPickerViewDelegate {
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch currentField {
        case .Cardtype:   return CardMetaData.types      .count
        case .Subtype:    return CardMetaData.subtypes   .count
        case .Supertype:  return CardMetaData.supertypes .count
        case .Set:        return CardMetaData.sets       .count
        case .Rarity:     return CardMetaData.rarities   .count
        case .Color:      return CardMetaData.colors     .count
        case .Multicolor: return CardMetaData.multicolor .count
        case .Format:     return CardMetaData.formats    .count
        case .Status:     return CardMetaData.statuses   .count
        default: assert(false)
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch currentField {
        case .Cardtype:   return CardMetaData.types      [row]
        case .Subtype:    return CardMetaData.subtypes   [row]
        case .Supertype:  return CardMetaData.supertypes [row]
        case .Set:        return CardMetaData.sets[row].0
        case .Rarity:     return CardMetaData.rarities   [row]
        case .Color:      return CardMetaData.colors     [row]
        case .Multicolor: return CardMetaData.multicolor [row]
        case .Format:     return CardMetaData.formats    [row]
        case .Status:     return CardMetaData.statuses   [row]
        default: assert(false)
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch currentField {
        case .Cardtype:   self.typeField.text       = CardMetaData.types      [row]
        case .Subtype:    self.subtypeField.text    = CardMetaData.subtypes   [row]
        case .Supertype:  self.supertypeField.text  = CardMetaData.supertypes [row]
        case .Set:        self.setField.text        = CardMetaData.sets[row].1
        case .Rarity:     self.rarityField.text     = CardMetaData.rarities   [row]
        case .Color:      self.colorField.text      = CardMetaData.colors     [row]
        case .Multicolor: self.multicolorField.text = CardMetaData.multicolor [row]
        case .Format:     self.formatField.text     = CardMetaData.formats    [row]
        case .Status:     self.statusField.text     = CardMetaData.statuses   [row]
        default: assert(false)
        }
    }
}