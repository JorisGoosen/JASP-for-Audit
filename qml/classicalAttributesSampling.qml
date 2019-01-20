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
      AssignedVariablesList {
          name: "recordNumberVariable"
          title: qsTr("Record numbers")
          singleItem: true
          allowedColumns: ["nominal", "ordinal", "scale"]
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
        spacing: 220

        ColumnLayout {

        GroupBox {
          title: qsTr("<b>Sample size</b>")

          TextField {
              text: qsTr("Sample size")
              value: "0"
              name: "sampleSize"
              inputType: "integer"
              validator: IntValidator { bottom: 1 }
              Layout.leftMargin: 20
          }
        }

        RadioButtonGroup {
          name: "samplingType"
          title: qsTr("<b>Sampling method</b>")

                RadioButton { text: qsTr("Simple random sampling")                  ; name: "simplerandomsampling" ; id: simplerandomsampling; checked: true}
                CheckBox { text: qsTr("Allow duplicate records")                    ; name: "allowDuplicates"; Layout.leftMargin: 20; enabled: simplerandomsampling.checked }
                RadioButton { text: qsTr("Cell sampling")                           ; name: "cellsampling" ; id: cellsampling}
                RadioButton { text: qsTr("Systematic sampling")                     ; name: "systematicsampling" ; id: systematicsampling}
                TextField {
                    text: qsTr("Interval starting point")
                    value: "1"
                    name: "startingPoint"
                    inputType: "integer"
                    validator: IntValidator { bottom: 1 }
                    Layout.leftMargin: 20
                    enabled: systematicsampling.checked
                }
          }

            RadioButtonGroup {
                title: qsTr("<b>Seed</b>")
                name: "seed"
                enabled: pickSamplingMethod.checked ? true : false

                RadioButton { text: qsTr("Default")         ; name: "seedDefault" ; checked: true}
                RowLayout {
                    RadioButton { text: qsTr("Manual")      ; name: "seedManual"  ; id: manualSeed}
                    TextField {
                        value: "1"
                        name: "seedNumber"
                        enabled: manualSeed.checked
                        validator: IntValidator { bottom: 0 }
                    }
                }
            }
        }

        ColumnLayout {

            GroupBox {
                title: qsTr("<b>Tables</b>")
                enabled: pickSamplingMethod.checked ? true : false

                CheckBox { text: qsTr("Sample descriptives")  ; name: "showDescriptives" ; id: descriptives}
                CheckBox { text: qsTr("Mean")                 ; name: "mean"; Layout.leftMargin: 20; enabled: descriptives.checked ; checked: true}
                CheckBox { text: qsTr("Median")               ; name: "median"; Layout.leftMargin: 20; enabled: descriptives.checked ; checked: true}
                CheckBox { text: qsTr("Std. deviation")       ; name: "sd"; Layout.leftMargin: 20; enabled: descriptives.checked ; checked: true}
                CheckBox { text: qsTr("Variance")             ; name: "var"; Layout.leftMargin: 20; enabled: descriptives.checked}
                CheckBox { text: qsTr("Minimum")              ; name: "min"; Layout.leftMargin: 20; enabled: descriptives.checked}
                CheckBox { text: qsTr("Maximum")              ; name: "max"; Layout.leftMargin: 20; enabled: descriptives.checked}
                CheckBox { text: qsTr("Range")                ; name: "range"; Layout.leftMargin: 20; enabled: descriptives.checked}
            }
        }
    }
}
