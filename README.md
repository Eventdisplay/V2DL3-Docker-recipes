# V2DL3 Docker recipies

V2DL3 is a tool to convert VERITAS data products to DL3 Fits format. 
This repository provides Docker recipies for converting Eventdisplay data files.

The V2DL3 software is available from [here](https://github.com/VERITAS-Observatory/V2DL3) (unfortunatly private software)

## Building

```
$ docker build --build-arg GITHUBTOKEN="my-git-token" -t v2dl3-eventdisplay .
```

Your GitHub token is required, as the V2DL3 GitHub repository is a private repository.

## Running

All examples in the following expect that the Eventdisplay data files (anasum.root and effective area files) are in the directory '$(pwd)/data'.

Run the image and provide a bash environment:

```
$ docker run --rm -it -v "$(pwd)/data:/data" v2dl3-eventdisplay bash
```

Test the converter script:
```
$ python V2DL3/pyV2DL3/script/v2dl3_for_Eventdisplay.py
```

Example execution:
```
$ python V2DL3/pyV2DL3/script/v2dl3_for_Eventdisplay.py -f /data/64080.anasum.root \
                                                           /data/effArea-v486-auxv01-CARE_June2020-Cut-NTel2-PointSource-Moderate-TMVA-BDT-GEO-V6_2012_2013a-ATM62-T1234.root \
                                                           /data/fits.gz
```

To convert with starting the container in bash:
```
docker run --rm -it -v "$(pwd)/data:/data" v2dl3-eventdisplay \
                                  python V2DL3/pyV2DL3/script/v2dl3_for_Eventdisplay.py \
                                  -f  /data/64080.anasum.root \
                                  /data/effArea-v486-auxv01-CARE_June2020-Cut-NTel2-PointSource-Moderate-TMVA-BDT-GEO-V6_2012_2013a-ATM62-T1234.root \
                                  /data/fits.gz
```

## Docker hub

e.g.:
```
docker tag 396165de13d9 gernotmaier/v2dl3-eventdisplay:v0.2.0-eventdisplay-refactoring
docker push gernotmaier/v2dl3-eventdisplay:v0.2.0-eventdisplay-refactoring

```

## Singularity

Build a singularity image, as required for many HEP computing environments.

1. Upload to docker hub (see previous sections

2. Convert Docker image to Singularity

```
singularity pull docker://gernotmaier/v2dl3-eventdisplay:v0.2.0-eventdisplay-refactoring
```

3. Test the singularity container
```
singularity exec -e --bind $(PWD)/data:/data v2dl3-eventdisplay.sif \
                                  python V2DL3/pyV2DL3/script/v2dl3_for_Eventdisplay.py \
                                  -f  /data/64080.anasum.root \
                                  /data/effArea-v486-auxv01-CARE_June2020-Cut-NTel2-PointSource-Moderate-TMVA-BDT-GEO-V6_2012_2013a-ATM62-T1234.root \
```
