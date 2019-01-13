//
// Copyright (C) 2013-2018 University of Amsterdam
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public
// License along with this program.  If not, see
// <http://www.gnu.org/licenses/>.
//
import QtQuick 2.8
import QtQuick.Layouts 1.3
import JASP.Controls 1.0
import JASP.Widgets 1.0

Form {
    id: form

    VariablesForm {
        defaultAssignedVariablesList {
            name: "correctID"
            title: qsTr("Error variable")
            singleItem: true
            allowedColumns: ["nominal"]
        }
    }

    Flow {
        spacing: 90

        ColumnLayout {

            ButtonGroup {
                title: qsTr("<b>Inherent risk</b>")
                name: "IR"

                RadioButton { text: qsTr("High")        ; name: "High" ; checked: true}
                RadioButton { text: qsTr("Medium")      ; name: "Medium" }
                RadioButton { text: qsTr("Low")         ; name: "Low" }
            }
        }

        ColumnLayout {

            ButtonGroup {
                title: qsTr("<b>Control risk</b>")
                name: "CR"

                RadioButton { text: qsTr("High")        ; name: "High" ; checked: true}
                RadioButton { text: qsTr("Medium")      ; name: "Medium" }
                RadioButton { text: qsTr("Low")         ; name: "Low" }
            }
        }
    }

    Divider { }

    GroupBox {
        title: qsTr("<b>Audit risk</b>")

      PercentField {
          label.text: qsTr("Materiality")
          with1Decimal: true
          defaultValue: 5
          name: "materiality"
      }

        PercentField {
            label.text: qsTr("Confidence")
            with1Decimal: true
            defaultValue: 95
            name: "confidence"
        }

    }

    ExpanderButton {
        text: qsTr("<b>Advanced options</b>")

        Flow {
            spacing: 70

            ColumnLayout {

                ButtonGroup {
                    title: qsTr("<b>Ratio</b>")
                    name: "show"

                    RadioButton { text: qsTr("Percentages")         ; name: "percentage" ; checked: true}
                    RadioButton { text: qsTr("Proportions")         ; name: "proportion" }
                }
            }

        }

    }

    Flow {
        spacing: 50

        GroupBox {
            title: qsTr("<b>Plots</b>")
            CheckBox { text: qsTr("Confidence bound") ; name: "plotBounds"}
        }

    }

}
