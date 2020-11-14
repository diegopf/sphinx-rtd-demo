FROM readthedocs/build:latest as sample-docs
USER root
RUN pip3 install -U sphinx
RUN pip3 install sphinx_rtd_theme
COPY . /home/docs/demo
RUN chown -R docs:docs /home/docs/demo
USER docs
RUN cd /home/docs/demo && make html

FROM nginx:latest
COPY --from=sample-docs ./home/docs/demo/_build/html /usr/share/nginx/html/