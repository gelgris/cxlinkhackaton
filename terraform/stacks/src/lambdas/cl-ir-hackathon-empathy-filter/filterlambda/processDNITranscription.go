package filterlambda

import "strings"

// Processes DNI transcription as "cuatro tres dos ..." as number with final DNI letter (XX.XXX.XXXY)
func processDNITranscription(pTranscribedDNI string) (string, error) {
	var vDNI string
	var vWords2Nums = make(map[string]string)

	vWords2Nums["cero"] = "0"
	vWords2Nums["uno"] = "1"
	vWords2Nums["dos"] = "2"
	vWords2Nums["tres"] = "3"
	vWords2Nums["cuatro"] = "4"
	vWords2Nums["cinco"] = "5"
	vWords2Nums["seis"] = "6"
	vWords2Nums["siete"] = "7"
	vWords2Nums["ocho"] = "8"
	vWords2Nums["nueve"] = "9"

	// Split word numbers to an slice of strings
	vNumsSlice := strings.Split(pTranscribedDNI, " ")

	for index, numAsWord := range vNumsSlice {
		vDNI = vDNI + vWords2Nums[numAsWord]
		// Last number is not a number is a character
		if index == len(vNumsSlice)-1 {
			// Conctenate the word (character) directly
			vDNI = vDNI + numAsWord
		}
	}

	return vDNI, nil
}
