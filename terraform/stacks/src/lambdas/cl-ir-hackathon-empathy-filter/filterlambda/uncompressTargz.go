package filterlambda

import (
	"archive/tar"
	"bytes"
	"compress/gzip"
	"fmt"
	"io"
	"log"
)

func uncompressTargz(pCompressed []byte) ([]byte, error) {
	var vGzipReader *gzip.Reader
	var vHeader *tar.Header
	var vErr error
	// pCompressed is the byte slice containing the compressed tar.gz data
	// Create a buffer to store the file contents
	var vFileContents []byte
	// Create a reader for the compressed data
	vCompressedReader := bytes.NewReader(pCompressed)

	// Create a gzip reader to decompress the data
	if vGzipReader, vErr = gzip.NewReader(vCompressedReader); vErr != nil {
		log.Println("Error creating gzip reader")
		return nil, vErr
	}

	defer vGzipReader.Close()

	// Create a tar reader to read the uncompressed tar data
	vTarReader := tar.NewReader(vGzipReader)

	// Read the single file from the tar archive
	if vHeader, vErr = vTarReader.Next(); vErr != nil {
		return nil, fmt.Errorf("error reading tar entry: %w", vErr)
	}

	// Process the file
	if vHeader.Typeflag != tar.TypeReg {
		return nil, fmt.Errorf("unexpected file type: %s", string(vHeader.Typeflag))
	}

	if vFileContents, vErr = io.ReadAll(vTarReader); vErr != nil {
		return nil, fmt.Errorf("error reading file content: %w", vErr)
	}

	return vFileContents, nil
}
