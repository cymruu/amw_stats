FROM jupyter/scipy-notebook

WORKDIR /workspace

ENV SINCE $SINCE
ENV UNTIL $UNTIL

CMD [ "jupyter", "nbconvert", "--to", "notebook", "--execute", "--stdout", "pandas/stats.ipynb"]
