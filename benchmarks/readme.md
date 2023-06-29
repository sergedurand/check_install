This directory contains utility functions and examples to run benchmarks to evaluate PyRAT performance

## Benchmarking ACAS:

For example run benchAcas as.:

```python
from benchmarks.utils_benchmark import bench_acas

bench_acas(prop=3, domains=[["poly"]])
```

Arguments:

- prop: number of the property.
- onlyNet: tuple (k,l) to specify a unique network to run on. Use for properties > 4 as mentioned
  in https://arxiv.org/abs/1702.01135
- domains: list of additionalDomains to compare. using ```domains =[["zonotopes"],["poly"]]```
  will compare the results for the zonotopes domains and deepppoly domains, using ```[["poly","zonotopes"]]``` will
  using the product of the zonotope and deeppoly domains.

- Log: file to save the results in as a csv. Use log=False if you don't want to save anything.

- append: Set to True in case you want to append the results to a previous existing log file.
- timeout / split / noiseThreshold / layerPerLayer: parameters to be used for each analysis (see analyeNet function)

Run examples/fullBenchAcas.py to benchmark all properties and all relevant networks with deepZ and deepPoly domains.

### Certifying images

The pipeline is:

1) load the original network (keras, torch, onnx supported soon)
2) load the PyRAT model (using the parsers or exportNet for pytorch models)
3) run analyzeAdv with the model, the pyratModel, the image, its true label, the size of the perturbation, the total
   number of labels and other parameters for analysis (layerPerLayer, nbProcess etc)

You can also use a special loader to test on many images for example in a local folder, see the
datasets/utilsDataset.py. The local folder should be arranged with images in one folder per class:
Dataset/class_0/images0.png

See examples/benchMnist.py for mnist certification and benchLocal for tests from a local folder (change datasetPath if
needed)
