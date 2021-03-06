// Copyright (C) 2013-2018 University of Amsterdam
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
// You should have received a copy of the GNU Affero General Public
// License along with this program.  If not, see
// <http://www.gnu.org/licenses/>.
import QtQuick 2.8
import QtQuick.Layouts 1.3
import JASP.Controls 1.0
import JASP.Widgets 1.0

Form {
	usesJaspResults: true

	GridLayout {
		columns: 3
		RadioButtonGroup {
			id: materiality
			name: "materiality"
			title: qsTr("Population materiality")
			RowLayout {
				RadioButton {
					id: materialityAbsolute
					name: "materialityAbsolute"
					text: qsTr("Absolute")
					checked: true
					childrenOnSameRow: true
					DoubleField {
						id: materialityValue
						visible: materialityAbsolute.checked
						name: "materialityValue"
						defaultValue: 0
						min: 0
						fieldWidth: 90
						decimals: 2
					}
				}
			}
			RowLayout {
				RadioButton {
					id: materialityRelative
					name: "materialityRelative"
					text: qsTr("Relative")
					childrenOnSameRow: true
					PercentField {
						id: materialityPercentage
						visible: materialityRelative.checked
						decimals: 2
						defaultValue: 0
						name: "materialityPercentage"
						fieldWidth: 50
					}
				}
			}
		}
		GroupBox {
			title: qsTr("Population")
			IntegerField {
				id: populationSize
				name: "populationSize"
				text: qsTr("Size")
				fieldWidth: 100
				defaultValue: 0
			}
			DoubleField {
				id: populationValue
				name: "populationValue"
				text: qsTr("Value")
				defaultValue: 0
				enabled: materialityAbsolute.checked
				fieldWidth: 100
			}
		}
		GroupBox {
			title: qsTr("Audit risk")
			id: auditRisk
			PercentField {
				name: "confidence"
				label: qsTr("Confidence")
				decimals: 2
				defaultValue: 95
			}
		}
	}

	Divider {
	}

	Item {
		height: variableSelectionTitle.height
		Layout.fillWidth: true
		Text {
			id: variableSelectionTitle
			anchors.horizontalCenter: parent.horizontalCenter
			text: qsTr("<b>Variable selection</b>")
			font.family: "SansSerif"
			font.pointSize: 12
		}
	}
	VariablesForm {
		implicitHeight: 200
		AvailableVariablesList {
			name: "evaluationVariables"
		}
		AssignedVariablesList {
			name: "auditResult"
			title: qsTr("Audit result")
			singleVariable: true
			allowedColumns: ["nominal", "scale"]
			id: auditResult
		}
		AssignedVariablesList {
			name: "monetaryVariable"
			title: qsTr("Book values (optional)")
			singleVariable: true
			allowedColumns: ["scale"]
			id: monetaryVariable
		}
		AssignedVariablesList {
			name: "sampleFilter"
			title: qsTr("Observation multiplyer (optional)")
			singleVariable: true
			allowedColumns: ["nominal"]
			id: sampleFilter
		}
	}

	Section {
		title: qsTr("Advanced options")

		GridLayout {
			columns: 3

			ColumnLayout {
				RadioButtonGroup {
					title: qsTr("Inherent risk")
					name: "IR"
					id: ir

					RadioButton {
						text: qsTr("High")
						name: "High"
						checked: true
					}
					RadioButton {
						text: qsTr("Medium")
						name: "Medium"
					}
					RadioButton {
						text: qsTr("Low")
						name: "Low"
					}
				}
				RadioButtonGroup {
					title: qsTr("Control risk")
					name: "CR"
					id: cr

					RadioButton {
						text: qsTr("High")
						name: "High"
						checked: true
					}
					RadioButton {
						text: qsTr("Medium")
						name: "Medium"
					}
					RadioButton {
						text: qsTr("Low")
						name: "Low"
					}
				}
			}

			RadioButtonGroup {
				title: qsTr("Estimator")
				name: "estimator"

				GridLayout {
					columns: 2

					//columnSpacing: 5
					ColumnLayout {
						spacing: 5

						Text {
							text: "<i>Binary</i>"
						}
						RadioButton {
							name: "gammaBound"
							text: qsTr("Gamma")
							id: gammaBound
						}
						RadioButton {
							name: "binomialBound"
							text: qsTr("Binomial")
							id: binomialBound
							checked: monetaryVariable.count == 0
						}
						RadioButton {
							name: "hyperBound"
							text: qsTr("Hypergeometric")
							id: hyperBound
						}
					}
					ColumnLayout {
						spacing: 5

						Text {
							text: "<i>Monetary</i>"
						}
						RadioButton {
							name: "stringerBound"
							text: qsTr("Stringer")
							id: stringerBound
							enabled: monetaryVariable.count > 0
						}
						RadioButton {
							name: "directBound"
							text: qsTr("Direct")
							id: directBound
							enabled: monetaryVariable.count > 0
						}
						RadioButton {
							name: "differenceBound"
							text: qsTr("Difference")
							id: differenceBound
							enabled: monetaryVariable.count > 0
						}
						RadioButton {
							name: "ratioBound"
							text: qsTr("Ratio")
							id: ratioBound
							enabled: monetaryVariable.count > 0
						}
						RadioButton {
							name: "regressionBound"
							text: qsTr("Regression")
							id: regressionBound
							enabled: monetaryVariable.count > 0
						}
					}
				}
			}

			GroupBox {
				title: qsTr("Explanatory text")
				RowLayout {
					CheckBox {
						id: explanatoryText
						text: qsTr("Enable")
						name: "explanatoryText"
						checked: true
					}
					MenuButton {
						width: 20
						iconSource: "qrc:/images/info-button.png"
						toolTip: "Show explanatory text at each step of the analysis"
						radius: 20
						Layout.alignment: Qt.AlignRight
					}
				}
			}
		}
	}

	Section {
		title: qsTr("Tables and plots")

		GridLayout {

			GroupBox {
				title: qsTr("Statistics")

				CheckBox {
					text: qsTr("Most likely error (MLE)")
					name: "mostLikelyError"
					checked: false
				}
			}

			GroupBox {
				title: qsTr("Plots")
				CheckBox {
					text: qsTr("Evaluation information")
					name: "evaluationInformation"
				}
				CheckBox {
					text: qsTr("Correlation plot")
					name: "correlationPlot"
				}
			}
		}
	}

	Item {
		height: downloadReportEvaluation.height
		Layout.fillWidth: true

		Button {
			id: downloadReportEvaluation
			enabled: materialityRelative.checked ? (populationSize.value != 0 & materialityPercentage.value != 0 & auditResult.count > 0) : (populationSize.value != 0 & materialityValue.value != 0 & populationValue.value != 0 & auditResult.count > 0)
			anchors.right: parent.right
			anchors.bottom: parent.bottom
			text: qsTr("<b>Download report</b>")
		}
	}
}
