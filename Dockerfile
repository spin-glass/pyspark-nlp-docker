FROM jupyter/pyspark-notebook
USER root 
RUN apt-get update
RUN pip install --upgrade pip
RUN pip install poetry
COPY pyproject.toml ./
RUN poetry update
RUN poetry export -f requirements.txt > requirements.txt
RUN pip install -r requirements.txt
RUN spacy download en_core_web_sm
RUN jupyter lab build --dev-build
ENV PYTHONPATH "${SPARK_HOME}/python/:${SPARK_HOME}/python/lib/py4j-0.10.9.5-src.zip:${PYTHONPATH}"