# V2DL3 Docker recipe for V2DL3 version 0.1.0

## Building

```
$ docker build --build-arg GITHUBTOKEN="my-git-token" -t vts-v2dl3-v0.1.0 .
```

Your GitHub token is required, as the V2DL3 GitHub repository is a private repository.

## Running

Run the image and provide a bash environment:

```
$ docker run --rm -it -v "$(pwd)/data:/data" vts-v2dl3-v0.1.0 bash
```

Using the run script with an analysis example:
```
v2dl3 -f /data/64080.anasum.root /data/effArea-v485-auxv01-CARE_June2020-Cut-NTel2-PointSource-Moderate-TMVA-BDT-GEO-V6_2012_2013a-ATM62-T1234.root /data/tt.fits.gz
```

To convert directly, do:
```
docker run --rm -it -v "$(pwd)/data:/data" vts-v2dl3-v0.1.0 /workdir/run.sh \
                                                     64080.anasum.root \
                                                     effArea-v485-auxv01-CARE_June2020-Cut-NTel2-PointSource-Moderate-TMVA-BDT-GEO-V6_2012_2013a-ATM62-T1234.root
```

## Docker hub

e.g.:
```
docker tag 396165de13d9 <your dockerhub name>/vts-v2dl3-v0.1.0:v03
docker push <your dockerhub name>/vts-v2dl3-v0.1.0:v03

```

## Singularity

Build a singularity image, as required for many HEP computing environments.

1. Upload to docker hub (see previous sections

2. Convert Docker image to Singularity
```
singularity pull docker://<your dockerhub name>/vts-v2dl3-v0.1.0:v03
```

3. Test the singularity container
```
singularity exec -e --bind $(PWD)/data:/data vts-v2dl3-v0.1.0.sif \
                                             /workdir/run.sh \
                                             64080.anasum.root \
                                             effArea-v485-auxv01-CARE_June2020-Cut-NTel2-PointSource-Moderate-TMVA-BDT-GEO-V6_2012_2013a-ATM62-T1234.root
```
