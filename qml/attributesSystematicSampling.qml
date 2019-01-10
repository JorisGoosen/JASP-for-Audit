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
            name: "recordNumberVariable"
            title: qsTr("Record numbers")
            singleItem: true
            allowedColumns: ["nominal"]
        }
        AssignedVariablesList {
            name: "rankingVariable"
            title: qsTr("Ranking variable (optional)")
            singleItem: true
            allowedColumns: ["scale"]
            }
        AssignedVariablesList {
            name: "variables"
            title: qsTr("Sampling variables")
            singleItem: false
            allowedColumns: ["scale", "ordinal", "nominal"]
        }
    }

    Flow {
        spacing: 120

        ColumnLayout {

          GroupBox {

          TextField {
              label.text: qsTr("Sample size")
              text: ""
              name: "sampleSize"
              inputType: "integer"
              validator: IntValidator { bottom: 0 }
          }

            TextField {
                label.text: qsTr("Interval starting point")
                text: "1"
                name: "startingPoint"
                inputType: "integer"
                validator: IntValidator { bottom: 1 }
            }

          }

        }

        ColumnLayout {

            GroupBox {
                title: qsTr("Tables")

                CheckBox { text: qsTr("Descriptives") ; name: "showDescriptives" ; id: descriptives}
                CheckBox { text: qsTr("Mean") ; name: "mean"; Layout.leftMargin: 20; enabled: descriptives.checked ; checked: true}
                CheckBox { text: qsTr("Median") ; name: "median"; Layout.leftMargin: 20; enabled: descriptives.checked ; checked: true}
                CheckBox { text: qsTr("Std. deviation") ; name: "sd"; Layout.leftMargin: 20; enabled: descriptives.checked ; checked: true}
                CheckBox { text: qsTr("Variance") ; name: "var"; Layout.leftMargin: 20; enabled: descriptives.checked}
                CheckBox { text: qsTr("Minimum") ; name: "min"; Layout.leftMargin: 20; enabled: descriptives.checked}
                CheckBox { text: qsTr("Maximum") ; name: "max"; Layout.leftMargin: 20; enabled: descriptives.checked}
                CheckBox { text: qsTr("Range") ; name: "range"; Layout.leftMargin: 20; enabled: descriptives.checked}
            }

            GroupBox {
                title: qsTr("Plots")
                CheckBox { text: qsTr("Sampling locations") ; name: "sampleLocations"; id: samplingLocations}
                CheckBox { text: qsTr("Display record numbers") ; name: "markSamples"; Layout.leftMargin: 20; enabled: samplingLocations.checked}
                }

        }

    }

}
