import QtQuick 2.0
import QtQuick.Controls 2.2

Rectangle
{
    id:root
    width: 480
    height: 300
    color: clr_gray2
    state: "inactive"

    property string myLang

    property Item surface: parent

    y: surface.height

    signal sigOKClicked();

    function show()
    {
        root.state = "active";
    }

    function hide()
    {
        root.state = "inactive";
    }

    states: [
        State {
            name: "active"
            PropertyChanges { target: root; y: (surface.height - root.height ); z:1}
        },
        State {
            name: "inactive"
            PropertyChanges { target: root; y: surface.height;z:0}
        }

    ]

    transitions: Transition {
        NumberAnimation {
            target: root
            property: "y"
            easing.type: "OutQuad"
            duration: 250
        }
    }

    Selector_Language
    {
        id:languageSelector
        anchors.fill: parent
        visible: true;

        languageModel: mylanguageModel

        onSigLanguageIndex:
        {
          myLanguage = mylanguageModel.get(index).lang
        }

        onSigConfirmOK:
        {
            root.myLang =   myLanguage;
            root.sigOKClicked();
            root.state = "inactive";
        }

        onSigCancel:
        {
           // console.log("cancel");
            root.state = "inactive";
        }
    }

}
