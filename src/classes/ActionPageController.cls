public with sharing class ActionPageController {

    public String valueOne { get; set; }
    public String valueTwo { get; set; }
    
    public PageReference iWantMyJSValues() {
        valueOne = Apexpages.currentPage().getParameters().get('one');
        valueTwo = Apexpages.currentPage().getParameters().get('two');
        return null;
    }
}