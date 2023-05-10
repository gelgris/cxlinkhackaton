package filterlambda

type ComprehendEntity struct {
	//{"BeginOffset": 56, "EndOffset": 66, "Score": 0.999457952829264, "Text": "Jos\u00e9 P\u00e9rez", "Type": "PERSON"}
	BeginOffset int     `json:"BeginOffset,omitempty"`
	EndOffset   int     `json:"EndOffset,omitempty"`
	Score       float32 `json:"Score,omitempty"`
	Text        string  `json:"Text,omitempty"`
	Type        string  `json:"Type,omitempty"`
}

type ComprehendOutput struct {
	Entities []ComprehendEntity `json:"Entities,omitempty"`
	File     string             `json:"File,omitempty"`
}
