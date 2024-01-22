extends Button

@export var inputText : TextEdit
@export var outputText : TextEdit
@export var optionButton : OptionButton

var models = [
	[ "Llama 2", 0, "llama2" ],
	[ "Mistral", 1, "mistral" ],
	[ "Dolphin Phi", 2, "dolphin-phi" ],
	[ "Phi-2", 3, "phi" ],
	[ "Neural Chat", 4, "neural-chat" ],
	[ "Starling", 5, "starling-lm" ],
	[ "Code Llama", 6, "codellama" ],
	[ "Llama 2 Uncensored", 7, "llama2-uncensored" ],
	[ "Llama 2 13B", 8, "llama2:13b" ],
	[ "Llama 2 70B", 9, "llama2:70b"  ],
	[ "Orca Mini", 10, "orca-mini" ],
	[ "Vicuna", 11, "vicuna"  ],
	[ "LLAVA", 12, "llava"  ]
]

# Called when the node enters the scene tree for the first time.
func _ready():
	for model in models:
		optionButton.add_item(model[0], model[1])
	optionButton.selected = 7
	connect("pressed", self._button_pressed)

func _button_pressed():
	var model = models[optionButton.selected][2]

	if inputText.text:
		outputText.text += "\nYou: " + inputText.text + "\n"

		var output = []
		OS.execute("ollama", ["run", model, inputText.text], output)

		inputText.text = ""
		outputText.text += "\nOllama: "
		for line in output:
			outputText.text += line.trim_suffix("\n")
