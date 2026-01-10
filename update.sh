hugo mod clean
rm go.sum
hugo mod get -u github.com/HugoBlox/kit/modules/blox@main
hugo mod get -u github.com/HugoBlox/kit/modules/integrations/netlify@main
hugo mod tidy
