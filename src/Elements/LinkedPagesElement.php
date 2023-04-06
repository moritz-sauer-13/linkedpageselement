<?php

namespace MoritzSauer\LinkedPages;

use DNADesign\Elemental\Models\BaseElement;
use SilverStripe\CMS\Model\SiteTree;
use SilverStripe\Control\Director;
use SilverStripe\Core\Config\Config;
use SilverStripe\Core\Manifest\ModuleLoader;
use SilverStripe\Dev\Debug;
use SilverStripe\Forms\CompositeField;
use SilverStripe\Forms\DropdownField;
use SilverStripe\Forms\GridField\GridField;
use SilverStripe\Forms\GridField\GridFieldConfig_RecordEditor;
use SilverStripe\Forms\HTMLEditor\HTMLEditorField;
use SilverStripe\Forms\TextField;
use SilverStripe\Forms\ToggleCompositeField;
use SilverStripe\Forms\TreeDropdownField;
use SilverStripe\ORM\DataObject;
use Symbiote\GridFieldExtensions\GridFieldOrderableRows;
use UncleCheese\Forms\ImageOptionsetField;

class LinkedPagesElement extends BaseElement{
    /*Database*/
    private static $db = [
        'ButtonCaption' => 'Text',
        'SubTitle' => 'Text',
        'ElementStyle' => 'Text',
        'Content' => 'HTMLText',
    ];

    private static $has_one = [
        'ButtonLinkedPage' => SiteTree::class
    ];

    private static $has_many = [
        'LinkedPages' => LinkedPage::class
    ];

    private static $many_many = [

    ];

    private static $many_many_extraFields = [

    ];

    /*CMS*/
    private static $summary_fields = [

    ];

    public function getCMSFields()
    {
        $fields = parent::getCMSFields();

        /*General remove*/
        $fields->removeByName([
            'LinkedPages',
            'ButtonLinkedPageID',
            'ButtonCaption',
            'LinkedPages',
        ]);

        /*Layout field*/
        $layoutField = ImageOptionsetField::create('ElementStyle', 'Layout wählen')->setSource($this->getLayoutOptions());
        $layoutField->setImageHeight($this->getConfigVariable('FieldSettings', 'ImageHeight'));
        $layoutField->setImageWidth($this->getConfigVariable('FieldSettings', 'ImageWidth'));
        $layoutField->setDescription($this->getConfigVariable('FieldSettings', 'FieldDescription'));

        $fields->addFieldToTab('Root.Main', $layoutField, 'MenuTitle');

        /*Get all fields*/
        $schema = DataObject::getSchema();
        $allFields = $schema->fieldSpecs($this);
        $columns = array_keys($allFields);

        $fields->addFieldsToTab('Root.Main', [
            TextField::create('SubTitle', 'Untertitel'),
            HTMLEditorField::create('Content', 'Inhalt')->setRows(6),
            TreeDropdownField::create('ButtonLinkedPageID', 'Verlinkte Seite für den Button', SiteTree::class),
            TextField::create('ButtonCaption', 'Button Beschriftung')
                ->setDescription('Optional. Standardmäßig wird "Mehr" ausgegeben.'),
            GridField::create(
                'LinkedPages',
                'Verlinkte Seiten',
                $this->LinkedPages()->sort('SortOrder ASC'),
                GridFieldConfig_RecordEditor::create(50)
                    ->addComponent(GridFieldOrderableRows::create('SortOrder'))
            )
        ]);


        $this->extend('updateLinkedPagesElementCMSFields', $fields);

        foreach ($columns as $field) {
            if (!in_array($field, $this->getReservedFields())) {
                if ($this->ElementStyle == '') {
                    /*As long as no Layout is selected, all Fields will be removed*/
                    $fields->removeByName($field);
                    if (!$fields->dataFieldByName($field)) {
                        $fields->removeByName($field);
                        $field = str_replace('ID', '', $field);
                        $fields->removeByName($field);
                    }
                } else {
                    if (!$this->getConfigVariable('Layouts', $this->ElementStyle)['FieldsVisibleElement'][$field]) {
                        $fields->removeByName($field);
                        $field = str_replace('ID', '', $field);
                        $fields->removeByName($field);
                    }
                }
            }
        }

        return $fields;
    }

    /*Getter & Setter*/
    //Write here your getters & setters

    /*Helper - Functions*/
    //Write here your helper-functions

    public function getType()
    {
        return 'Verlinkte Seiten Element';
    }

    /*Template - Functions*/
    public function ButtonCaption(){
        if($this->ButtonCaption != ''){
            return $this->ButtonCaption;
        }
        return _t('LinkedPages.READMORE', 'Mehr erfahren');
    }

    public function Title()
    {
        return (str_replace("|", "&shy;", $this->Title));
    }

    public function sortedLinkedPages(){
        return $this->LinkedPages()->sort('SortOrder ASC');
    }

    /*Get Layout options */
    private function getLayoutOptions(): array
    {
        $options = [];
        $configVars = Config::inst()->get('MoritzSauer\LinkedPagesElement')['Layouts'];
        foreach ($configVars as $layoutVar){
            $layoutID = $layoutVar['id'];
            if($this->getLayoutVariableFromConfig($layoutID)){
                if(stristr($layoutVar['imgPath'], 'themes/') !== false){
                    $img = $layoutVar['imgPath'];
                } else {
                    $img = ModuleLoader::getModule('moritz-sauer-13/linkedpageselement')->getResource($layoutVar['imgPath']);
                    if($img){
                        $img->getURL();
                    }
                }
                $options[$layoutID] = [
                    'title' => $layoutVar['title'],
                    'image' => ($img) ? Director::absoluteBaseURL() . 'resources/' . $img : '',
                ];
            }
        }
        return $options;
    }

    private function getLayoutVariableFromConfig($layout){
        return $this->getConfigVariable('Layouts', $layout)['enabled'];
    }

    private function getConfigVariable($type, $field){
        return Config::inst()->get('MoritzSauer\LinkedPagesElement')[$type][$field];
    }

    /*Define array with fields, which need to be shown the hole time*/
    private function getReservedFields(): array
    {
        return [
            'Title',
            'ShowTitle',
            'ElementStyle',
            'ExtraClass',
        ];
    }

    /*render each element-style with it's own template*/
    public function renderElementStyle(){
        $template = $this->owner->ElementStyle;
        if($template != ''){
            return $this->owner->renderWith('MoritzSauer/LinkedPages/ElementStyleTemplates/' . $template);
        }
        return null;
    }
}