<?php

namespace MoritzSauer\LinkedPages;

use BucklesHusky\FontAwesomeIconPicker\Forms\FAPickerField;
use SilverStripe\AssetAdmin\Forms\UploadField;
use SilverStripe\Assets\File;
use SilverStripe\Assets\Image;
use SilverStripe\CMS\Model\SiteTree;
use SilverStripe\Core\Config\Config;
use SilverStripe\Dev\Debug;
use SilverStripe\FontAwesome\FontAwesomeField;
use SilverStripe\Forms\CheckboxField;
use SilverStripe\Forms\CompositeField;
use SilverStripe\Forms\DropdownField;
use SilverStripe\Forms\GridField\GridField;
use SilverStripe\Forms\HTMLEditor\HTMLEditorField;
use SilverStripe\Forms\TextField;
use SilverStripe\Forms\ToggleCompositeField;
use SilverStripe\Forms\TreeDropdownField;
use SilverStripe\LinkField\Form\LinkField;
use SilverStripe\ORM\DataObject;

class LinkedPage extends DataObject{

    private static $singular_name = 'Verlinkte Seite';
    private static $plural_name = 'Verlinkte Seiten';

    /*Database*/
    private static $db = [
        'SortOrder' => 'Int',
        'Title' => 'Text',
        'SubTitle' => 'Text',
        'FAIcon' => 'Text',
        'Content' => 'HTMLText',
        'BadgePosition' => 'Text',
        'AutoPlay' => 'Boolean(1)',
        'Loop' => 'Boolean(1)',
        'Muted' => 'Boolean(1)',
        'Controls' => 'Boolean(1)',
    ];

    private static $has_one = [
        'LinkedPagesElement' => LinkedPagesElement::class,
        'LinkedPage' => Link::class,
        'Image' => Image::class,
        'Icon' => Image::class,
        'IconSecondary' => Image::class,
        'Badge' => Image::class,
        'PreviewImage' => Image::class,
        'VideoMP4' => File::class,
        'VideoOGV' => File::class,
        'VideoWEBM' => File::class,
    ];

    private static $has_many = [

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

        $fields->removeByName([
            'SortOrder',
            'LinkedPagesElementID',
            'LinkedPageID',
            'ExternalLink',
            'ButtonCaption',
            'FAIcon',
            'Icon',
            'IconSecondary',
            'Badge',
            'BadgePosition',
            'Links',
            'Video',
        ]);

        /*Get all fields*/
        $schema = DataObject::getSchema();
        $allFields = $schema->fieldSpecs($this);
        $columns = array_keys($allFields);

        $fields->addFieldsToTab('Root.Main', [
            TextField::create('Title', 'Titel'),
            TextField::create('SubTitle', 'Untertitel'),
            HTMLEditorField::create('Content', 'Inhalt')->setRows(6),
            UploadField::create('Image', 'Bild'),
        ]);

        $fields->addFieldsToTab('Root.Video', [
            UploadField::create('PreviewImage', 'Vorschaubild')
                ->setDescription('Vorschaubild für das Video. Dieses wird ausgegeben, bis das Video startet'),
            UploadField::create('VideoMP4', 'Video (.mp4)')
                ->setDescription('Die Videos werden alternativ zu Bild und Galerie ausgegeben.'),
            UploadField::create('VideoOGV', 'Video (.ogv)'),
            UploadField::create('VideoWEBM', 'Video (.webm)'),
            CheckboxField::create('AutoPlay', 'Video - Autoplay?')
                ->setDescription('Soll das Video automatisch abgespielt werden?'),
            CheckboxField::create('Loop', 'Video - Endlosschleife?')
                ->setDescription('Soll das Video automatisch in einer Endlosschleife wiedergegeben werden?'),
            CheckboxField::create('Muted', 'Video - Stumm?')
                ->setDescription('Soll das Video ohne Ton wiedergegeben werden?'),
            CheckboxField::create('Controls', 'Video - Steuerung?')
                ->setDescription('Sollen die Steuerungselemente des Videos angezeigt werden?')
        ]);

        $fields->addFieldsToTab('Root.Links', [
            LinkField::create('LinkedPage', 'Verlinkte Seite'),
        ]);

        $fields->addFieldsToTab('Root.Icon', [
            UploadField::create('Icon', 'Icon'),
            UploadField::create('IconSecondary', 'Zweites Icon')
                ->setDescription('z.B. für einen Hover Effekt'),
            FAPickerField::create('FAIcon', 'Font Awesome Icon')
        ]);

        $fields->addFieldsToTab('Root.Badge', [
            UploadField::create('Badge', 'Badge'),
            DropdownField::create('BadgePosition', 'Badge Position', [
                'TopLeft' => 'Oben links',
                'TopRight' => 'Oben rechts',
                'BottomLeft' => 'Unten links',
                'BottomRight' => 'Unten rechts',
            ]),
        ]);

        if($this->LinkedPagesElement()->ElementStyle == 'AsImageSlider') {
            $fields->addFieldsToTab('Root.Main', [
                UploadField::create('Image', 'Bild')
                    ->setDescription('Wenn hier kein Bild gepflegt ist, wird das "Bild für das Element" der Verlinkten Seite verwendet.')
            ]);
        } else if($this->LinkedPagesElement()->ElementStyle == 'TilesWithoutImage') {
            $fields->addFieldsToTab('Root.Main', [
                TextField::create('SubTitle', 'Untertitel'),
            ], 'ExternalLink');
        }




        $this->extend('updateLinkedPageCMSFields', $fields);


        /*Remove Fields depending on chosen layout and settings in .yml*/
        foreach ($columns as $field) {
            if (!in_array($field, $this->getReservedFields())) {
                if (!$this->getConfigVariable('Layouts', $this->LinkedPagesElement()->ElementStyle)['FieldsVisibleObject'][$field]) {
                    $fields->removeByName($field);
                    $field = str_replace('ID', '', $field);
                    $fields->removeByName($field);
                }
            }
        }

        return $fields;
    }


    /*Getter & Setter*/
    //Write here your getters & setters

    /*Helper - Functions*/
    //Write here your helper-functions

    /*Define array with fields, which need to be shown the hole time*/
    private function getReservedFields(): array
    {
        return [
            'Title',
        ];
    }

    private function getConfigVariable($type, $field){
        return Config::inst()->get('MoritzSauer\LinkedPagesElement')[$type][$field];
    }


    /*Template - Functions*/

    public function showBadge(){
        return $this->getConfigVariable('Layouts', $this->LinkedPagesElement()->ElementStyle)['FieldsVisibleObject']['BadgeID'] && $this->BadgeID > 0;
    }
}
