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

    // Expander button for the Audit type phase
    ExpanderButton {
        text: optionPhase.expanded ? qsTr("<b>1. Audit type</b>") : qsTr("1. Audit type")
        expanded: true
        enabled: true
        id: optionPhase

        Flow {
          Layout.leftMargin: 20
          spacing: 180
            RadioButtonGroup{
              name: "auditType"
              title: qsTr("<b>Statement level</b>")
              id: auditProcedure

              RadioButton { text: qsTr("Percentages")           ; name: "attributes" ; checked: true; id: attributes}
              RadioButton { text: qsTr("Monetary Units")        ; name: "mus"; id: mus}
            }
            GroupBox {
                title: qsTr("<b>Explanatory text</b>")

                RowLayout {
                  CheckBox { text: qsTr("Turn on")     ; name: "interpretation"; checked: true}
                  MenuButton
                  {
                    width:				20
                    iconSource:			"qrc:/images/info-button.png"
                    toolTip:			"Show explanatory text at each step in the analysis"
                    radius:				20
                    Layout.alignment: Qt.AlignRight
                  }
                }
            }
          }

        Divider { }

        Text {
            text: qsTr("<b>Variable selection</b>")
            font.family: "SansSerif"
            font.pointSize: 12
            Layout.leftMargin: 200
        }
        // Variables form for preparation
        VariablesForm {
            availableVariablesList.name: "variablesFormPreparation"
            id: variablesFormPreparation
            implicitHeight: 100

            AssignedVariablesList {
                name: "recordNumberVariable"
                title: qsTr("Record numbers")
                singleItem: true
                allowedColumns: ["nominal", "ordinal", "scale"]
                id: recordNumberVariable
            }
            AssignedVariablesList {
                name: "monetaryVariable"
                title: qsTr("Book values")
                singleItem: true
                allowedColumns: ["scale"]
                id: monetaryVariable
            }
        }

        Item {
          height: toPlanning.height
          Layout.fillWidth: true

          CheckBox {
            id: planningChecked
            anchors.right: toPlanning.left
            width: visible ? height : 0
            visible: false
            name: "planningChecked"
            checked: false
          }
          Button {
            id: toPlanning
            anchors.right: parent.right
            text: qsTr("<b>To Planning</b>")
            enabled: (recordNumberVariable.count > 0 && monetaryVariable.count > 0)

            onClicked: {
              optionPhase.expanded = false
              planningPhase.expanded = true
              planningPhase.enabled = true
              planningChecked.checked = true
            }
          }
      }
    }

    // Expander button for the Planning phase
    ExpanderButton {
        text: planningPhase.expanded ? qsTr("<b>2. Planning</b>") : qsTr("2. Planning")
        expanded: false
        enabled: false
        id: planningPhase

        Flow {
          spacing: 25
            GroupBox {
                title: qsTr("<b>Audit risk</b>")
                id: auditRisk
                PercentField {
                    label.text: qsTr("Confidence")
                    with1Decimal: true
                    defaultValue: 95
                    name: "confidence"
                }
                PercentField {
                    label.text: qsTr("Materiality")
                    with1Decimal: true
                    defaultValue: 5
                    name: "materiality"
                }
            }
            RadioButtonGroup {
                title: qsTr("<b>Inherent risk</b>")
                name: "IR"
                id: ir
                  RadioButton { text: qsTr("High")        ; name: "High" ; checked: true}
                  RadioButton { text: qsTr("Medium")      ; name: "Medium" }
                  RadioButton { text: qsTr("Low")         ; name: "Low" }
            }
            RadioButtonGroup {
                title: qsTr("<b>Control risk</b>")
                name: "CR"
                id: cr
                  RadioButton { text: qsTr("High")        ; name: "High" ; checked: true}
                  RadioButton { text: qsTr("Medium")      ; name: "Medium" }
                  RadioButton { text: qsTr("Low")         ; name: "Low" }
            }
            RadioButtonGroup {
                name: "expected.errors"
                id: expectedErrors
                title: qsTr("<b>Allowed errors</b>")

                RowLayout {
                    RadioButton { text: qsTr("Percentage")            ; name: "kPercentage" ; checked: true; id: expkPercentage}
                    PercentField {
                        with1Decimal: true
                        defaultValue: 0
                        name: "kPercentageNumber"
                        enabled: expkPercentage.checked
                    }
                }

                RowLayout {
                    RadioButton { text: qsTr("Number")              ; name: "kNumber"       ; id: expkNumber}
                    TextField {
                        value: "0"
                        name: "kNumberNumber"
                        enabled: expkNumber.checked
                        inputType: "integer"
                        validator: IntValidator { bottom: 0 }
                        Layout.leftMargin: 18
                    }
                }
            }
        }

    ExpanderButton {
        text: qsTr("Advanced planning options")
        Layout.leftMargin: 20
        implicitWidth: 560

        Flow {
            Layout.leftMargin: 20
            spacing: 60

            RadioButtonGroup {
                title: qsTr("<b>Sampling model</b>")
                name: "distribution"
                id: distribution

                RadioButton { text: qsTr("With replacement")            ; name: "binomial" ; checked: true}
                RadioButton { text: qsTr("Without replacement")         ; name: "hypergeometric" ; id: hyperDist}
            }
          }
    }

    Divider { }

    Flow {
      spacing: 60

       GroupBox {
          title: qsTr("<b>Plots</b>")

           CheckBox {      text: qsTr("Decision plot")                  ; name: "plotCriticalErrors"; checked: true }
           CheckBox {      text: qsTr("Distribution information")       ; name: "distributionPlot"; id: distributionPlot }
           CheckBox {      text: qsTr("Cumulative density")             ; name: "showCumulative"; Layout.leftMargin: 20; enabled: distributionPlot.checked }
        }
    }

    Item {
      height: toSampling.height
      Layout.fillWidth: true

        CheckBox {
          anchors.right: toSampling.left
          width: visible ? height : 0
          visible: false
          name: "samplingChecked"
          id: samplingChecked
          checked: false
        }
        Button {
          id: toSampling
          anchors.right: parent.right
          text: qsTr("<b>To Sampling</b>")

          onClicked: {
            planningPhase.expanded = false
            samplingPhase.expanded = true
            samplingPhase.enabled = true
            samplingChecked.checked = true
          }
        }
    }
  }

      // Expander button for the Sampling phase
        ExpanderButton {
            text: samplingPhase.expanded ? qsTr("<b>3. Sampling</b>") : qsTr("3. Sampling")
            enabled: false
            expanded: false
            id: samplingPhase

            VariablesForm {
                availableVariablesList.name: "variablesFormSampling"
                id: variablesFormSampling
                implicitHeight: 200

                AssignedVariablesList {
                    name: "rankingVariable"
                    title: qsTr("Ranking variable (optional)")
                    singleItem: true
                    allowedColumns: ["scale"]
                    }
                AssignedVariablesList {
                    name: "variables"
                    title: qsTr("Additional variables (optional)")
                    singleItem: false
                    allowedColumns: ["scale", "ordinal", "nominal"]
                }
            }

            Flow {
                Layout.leftMargin: 10
                spacing: 60

                ColumnLayout {

                    RadioButtonGroup {
                        title: qsTr("<b>Seed</b>")
                        name: "seed"
                        id: seed

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

                    ExpanderButton {
                      title: qsTr("Advanced sampling options")
                      implicitWidth: 260
                      id: samplingType

                      RadioButtonGroup {
                        name: "samplingType"

                        RadioButton { text: qsTr("Simple random sampling")                 ; name: "simplerandomsampling" ; id: simplerandomsampling; checked: true}
                        CheckBox { text: qsTr("Allow duplicate records")                   ; name: "allowDuplicates"; Layout.leftMargin: 20; enabled: simplerandomsampling.checked }
                        RadioButton { text: qsTr("Cell sampling")                   ; name: "cellsampling" ; id: cellsampling}

                        RadioButton { text: qsTr("Systematic sampling")             ; name: "systematicsampling" ; id: systematicsampling}
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
                    }
                  }

                ColumnLayout {

                    GroupBox {
                        title: qsTr("<b>Tables</b>")
                        id: samplingTables

                        CheckBox { text: qsTr("Display sample")       ; name: "showSample"}
                        CheckBox { text: qsTr("Sample descriptives")  ; name: "showDescriptives" ; id: descriptives}
                        Flow {
                          Layout.leftMargin: 20
                            ColumnLayout {
                              spacing: 5
                              CheckBox { text: qsTr("Mean")                 ; name: "mean"; enabled: descriptives.checked ; checked: true}
                              CheckBox { text: qsTr("Median")               ; name: "median"; enabled: descriptives.checked ; checked: true}
                              CheckBox { text: qsTr("Std. deviation")       ; name: "sd"; enabled: descriptives.checked ; checked: true}
                              CheckBox { text: qsTr("Variance")             ; name: "var"; enabled: descriptives.checked}
                            }
                            ColumnLayout {
                              spacing: 5
                              CheckBox { text: qsTr("Minimum")              ; name: "min"; enabled: descriptives.checked}
                              CheckBox { text: qsTr("Maximum")              ; name: "max"; enabled: descriptives.checked}
                              CheckBox { text: qsTr("Range")                ; name: "range"; enabled: descriptives.checked}
                            }
                        }
                    }
                }
            }

            Item {
              height: toExecution.height
              Layout.fillWidth: true

                Button {
                  id: toExecution
                  anchors.right: parent.right
                  text: qsTr("<b>To Execution</b>")
                  onClicked: {
                    samplingPhase.expanded = false
                    executionPhase.expanded = true
                    executionPhase.enabled = true
                  }
                }
            }
        }

        // Expander button for the interim-evaluation option phase
        ExpanderButton {
            text: executionPhase.expanded ? qsTr("<b>4. Execution</b>") : qsTr("4. Execution")
            expanded: false
            enabled: false
            id: executionPhase

            Text {
                text: qsTr("Click the 'Paste variables' button to amend the data set with two additional variables:
                            \n 1) sampleFilter: Indicates whether an observation is in(1) or out(0) of the sample
                            \n2) correctID: Use this variable to fill out the ist-position for the sample observations")
                font.family: "SansSerif"
                font.pointSize: 8
                Layout.leftMargin: 20
            }

            Item {
              height: toEvaluation.height
              Layout.fillWidth: true

              Button {
                text: qsTr("<b>Paste variables</b>")
                id: pasteButton
                anchors.right: evaluationChecked.left
                onClicked: {
                  toEvaluation.enabled = true
                  pasteButton.enabled = false
                }
              }

              CheckBox {
                anchors.right: toEvaluation.left
                width: height
                visible: false
                name: "evaluationChecked"
                id: evaluationChecked
                checked: false
              }

              Button {
                enabled: false
                id: toEvaluation
                anchors.right: parent.right
                text: qsTr("<b>To Evaluation</b>")
                onClicked: {
                  executionPhase.expanded = false
                  evaluationPhase.expanded = true
                  evaluationPhase.enabled = true
                  optionPhase.expanded = false
                  auditProcedure.enabled = false
                  auditRisk.enabled = false
                  ir.enabled = false
                  cr.enabled = false
                  distribution.enabled = false
                  expectedErrors.enabled = false
                  variablesFormSampling.enabled = false
                  seed.enabled = false
                  samplingType.enabled = false
                  evaluationChecked.checked = true
                  pasteButton.enabled = false
                  variablesFormPreparation.enabled = false
                }
              }
            }
        }

        // Expander button for the Evaluation phase
        ExpanderButton {
            text: evaluationPhase.expanded ? qsTr("<b>5. Evaluation</b>") : qsTr("5. Evaluation")
            expanded: false
            enabled: false
            id: evaluationPhase

            VariablesForm {
            availableVariablesList.name: "evaluationVariables"
            implicitHeight: 200

                AssignedVariablesList {
                    name: "sampleFilter"
                    title: qsTr("Sample filter")
                    singleItem: true
                    allowedColumns: ["nominal"]
                    id: sampleFilter
                }
                AssignedVariablesList {
                    visible: attributes.checked
                    name: "correctID"
                    title: qsTr("Error variable")
                    singleItem: true
                    allowedColumns: ["nominal"]
                    id: correctID
                }
                AssignedVariablesList {
                    visible: mus.checked
                    name: "correctMUS"
                    title: qsTr("True values")
                    singleItem: true
                    allowedColumns: ["scale"]
                    id: correctMUS
                }
            }

            Flow{
              Layout.leftMargin: 10
              spacing: 140

              GroupBox {
                title: qsTr("<b>Statistics</b>")

                CheckBox {
                    text: qsTr("Most Likely Error (MLE)")
                    name: "mostLikelyError"
                    checked: false
                }
              }
                GroupBox {
                    title: qsTr("<b>Plots</b>")
                    CheckBox {
                      text: qsTr("Outcome information")
                      name: "plotBound"
                    }
                }
            }

            // Expander button for the various bounds in MUS procedure
            ExpanderButton {
              visible: attributes.checked ? false : true
              Layout.leftMargin: 20
              title: qsTr("Advanced output options")
              implicitWidth: 560

              RadioButtonGroup {
                title: qsTr("<b>Estimator</b>")
                name: "boundMethodMUS"

                RadioButton {
                  name: "stringerBound"
                  text: qsTr("Stringer")
                  checked: true
                }
                RadioButton {
                  name: "regressionBound"
                  text: qsTr("Regression")
                }
              }
            }

            Item {
              height: toInterpretation.height
              Layout.fillWidth: true

              Button {
                id: toInterpretation
                anchors.right: parent.right
                enabled: attributes.checked ? (sampleFilter.count > 0 && correctID.count > 0) : (sampleFilter.count > 0 && correctMUS.count > 0)
                text: qsTr("<b>To Report</b>")
                onClicked: {
                  evaluationPhase.expanded = false
                  interpretationPhase.expanded = true
                  interpretationPhase.enabled = true
                }
              }
            }
        }

        // Expander button for the report phase
        ExpanderButton {
            text: interpretationPhase.expanded ? qsTr("<b>6. Report</b>") : qsTr("6. Report")
            expanded: false
            enabled: false
            id: interpretationPhase

            Item {
              height: toReport.height
              Layout.fillWidth: true

              Button {
                id: toReport
                anchors.right: parent.right
                text: qsTr("<b>Download Report</b>")

                onClicked: {
                  interpretationPhase.expanded = false
                  interpretationPhase.enabled = false
                  optionPhase.enabled = false
                  planningPhase.enabled = false
                  samplingPhase.enabled = false
                  executionPhase.enabled = false
                  evaluationPhase.enabled = false
                  interpretationPhase.enabled = false
                }
            }
          }
        }
}