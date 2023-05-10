package textlambda

type Transcript struct {
	Transcript string `json:"transcript,omitempty"`
}

type Results struct {
	Transcripts []Transcript `json:"transcripts,omitempty"`
}

type TranscribeOutput struct {
	JobName   string  `json:"jobName,omitempty"`
	AccountId string  `json:"accountId,omitempty"`
	Results   Results `json:"results,omitempty"`
}