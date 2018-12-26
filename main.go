package main

import (
	"bufio"
	"encoding/base64"
	"encoding/json"
	"io/ioutil"
	"log"
	"net/http"
	"os"
	"text/template"
)

type placeholders struct {
	Address string `json:"address,omitempty"`
	Subject string `json:"subject,omitempty"`
	Text    string `json:"text,omitempty"`
}

type labels struct {
	Phone   string `json:"phone,omitempty"`
	Mobile  string `json:"mobile,omitempty"`
	Email   string `json:"email,omitempty"`
	Website string `json:"website,omitempty"`
	Bank    string `json:"bank,omitempty"`
	Iban    string `json:"iban,omitempty"`
	Bic     string `json:"bic,omitempty"`
	VatID   string `json:"vatId,omitempty"`
	TaxID   string `json:"taxId,omitempty"`
}

// Config parameters
type Config struct {
	Theme        string
	Signature    string
	Title        string `json:"title,omitempty"`
	Name         string `json:"name,omitempty"`
	Street       string `json:"street,omitempty"`
	City         string `json:"city,omitempty"`
	Country      string `json:"country,omitempty"`
	Phone        string `json:"phone,omitempty"`
	Mobile       string `json:"mobile,omitempty"`
	Email        string `json:"email,omitempty"`
	Website      string `json:"website,omitempty"`
	Bank         string `json:"bank,omitempty"`
	Iban         string `json:"iban,omitempty"`
	Bic          string `json:"bic,omitempty"`
	VatID        string `json:"vatId,omitempty"`
	TaxID        string `json:"taxId,omitempty"`
	Closing      string `json:"closing,omitempty"`
	Placeholders placeholders
	Labels       labels
}

var listen = ":3000"
var config Config
var index *template.Template

func serveIndex(w http.ResponseWriter, r *http.Request) {
	if err := index.Execute(w, config); err != nil {
		log.Fatal(err)
	}
}

func loadConfig() Config {
	jsonFile, readErr := ioutil.ReadFile("config/config.json")
	if readErr != nil {
		log.Fatal(readErr)
	}

	var config Config
	err := json.Unmarshal(jsonFile, &config)
	if err != nil {
		log.Fatal(err)
	}

	return config
}

func loadIndexTemplate() *template.Template {
	index, err := template.ParseFiles("app/index.tpl")
	if err != nil {
		log.Fatal(err)
	}
	return index
}

func inlineImage(filename string) string {
	imgFile, err := os.Open(filename)
	if err != nil {
		log.Fatal(err)
	}
	defer imgFile.Close()

	// create a new buffer base on file size
	fInfo, _ := imgFile.Stat()
	var size = fInfo.Size()
	buf := make([]byte, size)

	// read file content into buffer
	fReader := bufio.NewReader(imgFile)
	fReader.Read(buf)
	return base64.StdEncoding.EncodeToString(buf)
}

func main() {
	config = loadConfig()
	config.Signature = inlineImage("config/signature.png")

	themeFile, err := ioutil.ReadFile("config/styles.css")
	if err != nil {
		log.Fatal(err)
	}
	config.Theme = string(themeFile)

	index = loadIndexTemplate()

	fs := http.FileServer(http.Dir("app"))
	http.Handle("/static/", fs)

	http.HandleFunc("/", serveIndex)

	log.Printf("Listening on %s ...\n", listen)
	http.ListenAndServe(":3000", nil)
}
