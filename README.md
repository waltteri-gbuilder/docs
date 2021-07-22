# GB Docs

### Local environment
To run locally, run `run-dev.sh` script in this folder. Access pages from [http://localhost:8000](http://localhost:8000)

Modify files with editor of your choice, and save. Browser should automatically reload after saving.

### Editing
Use markdown to edit file contents. They're located in docs folder of this directory. If you add new files/folders, remember to add them in `mkdocs.yml` file in nav block

### Building production image
Run `docker build . -t gbuildercom/docs` to build docker image and run `docker run --rm -d -p 8000:80 gbuildercom/docs` to view production version. It's identical anyway, but hosted from static files.