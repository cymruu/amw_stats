FROM jupyter/scipy-notebook

ENV SINCE $SINCE
ENV UNTIL $UNTIL

WORKDIR /workspace/pandas

COPY stats.ipynb .

CMD ["jupyter", "nbconvert", "--to", "notebook", "--execute", "--stdout", "stats.ipynb"]
