## Install

Install requirements using your favourite package manager / virtual environment.

We suggest conda / [mamba](https://github.com/mamba-org/mamba). You can use the provided yaml environment. You can install mamba and create 
a new environment with all required packages and activate it by running the following (tested on Ubuntu 20.04):

```bash
conda install mamba
mamba env create -f pyrat_env.yml
conda activate pyrat
```

If you have a timeout error with the pip install you can increase pip default timeout
(```export PIP_DEFAULT_TIMEOUT=1000```) and try again.

Alternatively you can create a local environment with virtualenv and install packages with pip, with python 3.9:
```bash
pip install virtualenv
virtualenv venv
source venv/bin/activate
pip install -r requirements.txt
```

Versions are fixed for better reproducibility. Other packages versions 
might work as well but were not thoroughly tested.

## Docker version

You can try the Dockerfile to run PyRAT in a container.

In a terminal on the root of PyRAT folder you can build the image with:
```bash
docker build . -t pyrat_image
```

Run the image interactively:
```bash
docker run -it pyrat_image bash
```

You can then launch PyRAT as you would on your own machine using the following instructions.
For example you can run all tests:
```bash
python -m pytest -s tests
```

## Run PyRAT

### Generic Usage:

```
usage: pyrat.py [-h] [--config CONFIG] [-V] [--model_path MODEL_PATH]
                [--property_path PROPERTY_PATH] [--acas ACAS [ACAS ...]]
                [--dataset DATASET] [--nb_img NB_IMG] [--shuffle [SHUFFLE]]
                [--epsilon EPSILON] [--total_labels TOTAL_LABELS]
                [--true_label TRUE_LABEL] [--force_analysis [FORCE_ANALYSIS]]
                [--image IMAGE] [--grayscale [GRAYSCALE]] [--verbose [VERBOSE]]
                [--domains DOMAINS [DOMAINS ...]] [--timeout TIMEOUT] [--split [SPLIT]]
                [--transpose [TRANSPOSE]] [--squeeze [SQUEEZE]]
                [--refined_split REFINED_SPLIT [REFINED_SPLIT ...]]
                [--max_noise MAX_NOISE] [--nb_process NB_PROCESS] [--by_layer [BY_LAYER]]
                [--max_size MAX_SIZE] [--allow_smaller_size [ALLOW_SMALLER_SIZE]]
                [--add_suffix [ADD_SUFFIX]] [--scorer SCORER]
                [--polarity_shift POLARITY_SHIFT] [--booster BOOSTER]
                [--booster_threshold BOOSTER_THRESHOLD] [--metric METRIC] [--mode MODE]
                [--coef_weight COEF_WEIGHT] [--initial [INITIAL]] [--adapt [ADAPT]]
                [--progress [PROGRESS]] [--affine_axis AFFINE_AXIS] [--log_dir LOG_DIR]
                [--log_name LOG_NAME] [--log_date [LOG_DATE]] [--log_number LOG_NUMBER]
                [--header HEADER] [--log_intermediate [LOG_INTERMEDIATE]]
                [--debug_file DEBUG_FILE] [--debug [DEBUG]] [--relative_path [RELATIVE_PATH]]

PyRAT Analysis

optional arguments:
  -h, --help            show this help message and exit

General options:
  --config CONFIG, -c CONFIG
                        Path to a config.ini file for the analysis, optional
  -V, --version         show program's version number and exit

Path / data options:
  --model_path MODEL_PATH, -mp MODEL_PATH
                        Path to the model to be analysed
  --property_path PROPERTY_PATH, -pp PROPERTY_PATH
                        Path to the property file to be analysed
  --acas ACAS [ACAS ...]
                        Three ints i, j, p indicating network and property for ACAS Xu
                        benchmark : i, j, p will lead to analysis of ACAS network i_j on
                        property p.i must be in [1, 4], j in [1, 9] and p in [1, 10]
  --dataset DATASET     Put the path to a pytorch ImageFolder kind of dataset, or a name
                        in ['mnist', 'cifar_10,'cifar_100'] for robustness analysis on
                        this dataset
  --nb_img NB_IMG       Number of images to analyze if certifying robustness on an
                        imagedataset (default: 10)
  --shuffle [SHUFFLE]   Shuffle the image dataset. Only useful if doing robustness
                        analysis on an image set
  --epsilon EPSILON, -eps EPSILON
                        Radius of the ball to certify robust to adversarial inputs
                        (default: 0.03)
  --total_labels TOTAL_LABELS
                        The total number of labels of the dataset, for adversarial
                        robustness certification (default: 10)
  --true_label TRUE_LABEL
                        The label of the image, for adversarial robustness certification
  --force_analysis [FORCE_ANALYSIS]
                        If set the predicted label will be used as label even if the model
                        has a wrong prediction and the robustness will be considered with
                        regard to this prediction.
  --image IMAGE, -img IMAGE
                        Path to an image to be analyzed for adversarial robustness. Images
                        can be array saved by numpy np.save (must have extension .npy) Or
                        images compatible with PIL.Image.open (jpg, png etc) The shape of
                        the image after loading should be compatible with the network
                        input shape
  --grayscale [GRAYSCALE], -gs [GRAYSCALE]
                        Loads the images in grayscale

Analysis options:
  --verbose [VERBOSE], -v [VERBOSE]
                        Displays progress bar
  --domains DOMAINS [DOMAINS ...]
                        List of domains to be used. Choices: 'zonotopes', 'poly', 'symbox'
  --timeout TIMEOUT, -t TIMEOUT
                        Timeout (default: 20s)
  --split [SPLIT], -s [SPLIT]
                        Recursively splits the inputs if the analysis is too imprecise to
                        conclude
  --transpose [TRANSPOSE], -tr [TRANSPOSE]
                        Transposes the weights of the network. Use it when loading nnet or
                        onnx from converted nnet files
  --squeeze [SQUEEZE], -sq [SQUEEZE]
                        Squeezes the network first dimension. Use it if the network has
                        batch size 1 has first dimension. Don't use it if the first
                        dimension is the number of channels
  --refined_split REFINED_SPLIT [REFINED_SPLIT ...]
                        Splitting parameters to use if using analysis refinement
  --max_noise MAX_NOISE
                        Number of additional noise to keep when using zonotope domains. If
                        set to -1 all noises will be kept, if set to 0 no new noises will
                        be added
  --nb_process NB_PROCESS, -p NB_PROCESS
                        Number of processes to use when doing analysis with splits
                        (default: 1)
  --by_layer [BY_LAYER]
                        Activates full backsubstitution when using the deeppoly domain
  --max_size MAX_SIZE   Modulates the maximum number of coefficient in the PyRAT analysis
                        arrays. -1 means max_size is infinite. This brings a tradeoff
                        between memory and time. (default: -1)
  --allow_smaller_size [ALLOW_SMALLER_SIZE]
                        Allows the added coefficients for the zonotopes to be of smaller
                        size than the specified max_size. This allows the sources of these
                        coefficients to be kept. Otherwise, they are by default fused
                        together to match max_size. This should be activated when Add or
                        Concat layers are present in the network.
  --add_suffix [ADD_SUFFIX]
                        Adds a layer to the network to refine properties which includes
                        comparison between outputs
  --library LIBRARY     Which computing library to use. Options: numpy, torch. (default: numpy)
  --device DEVICE       Devide to execute upon:cpu or cuda, only available when using torch as a library
  --sound [SOUND]       Option to be correct w.r.t. floating point operations. If True, all operations are rounded correctly towards minus and plus infinity. Otherwise, round to nearest is used. Does not work on cuda. (default: True)     



scorer / booster options :
  --scorer SCORER       Type of scorer to use when doing analysis with split on inputs.
                        Current options: 'width', 'coef', 'random' (default: width)
  --polarity_shift POLARITY_SHIFT
                        Shift in case polarity is not centered in 0 (for properties of
                        type N(x) > c with c !=0)
  --booster BOOSTER     TYpe of booster, must be in "general", "no_boost", "always_boost"
  --booster_threshold BOOSTER_THRESHOLD, --bt BOOSTER_THRESHOLD
                        The threhsold above which to boost, for the general booster
  --metric METRIC, --m METRIC
                        The metric that the booster will use, either relu_stat or polarity
                        (default: polarity)
  --mode MODE           The computation to apply to the raw metrics, must be in [sum, min,
                        max, mean, n] with n an int specifying which output to consider
                        for the polarity metric only
  --coef_weight COEF_WEIGHT, --cw COEF_WEIGHT
                        Weight to use in the weighted sum of the affine scorer affine.
                        Score is (1-cw)*size input + cw * affineform score using cw = 0 is
                        equivalent to using the widthscorer (default: 1)
  --initial [INITIAL]   If set the concretization used in the affine scorer will be based
                        on a [-1, 1] interval If not set the concretization will use the
                        actual input interval
  --adapt [ADAPT]       Uses an adaptative booster based on the depth
  --progress [PROGRESS]
                        Uses the progress of the metric to evaluate when boosting instead
                        of only the current step metric
  --affine_axis AFFINE_AXIS, --aa AFFINE_AXIS
                        Output axis to use when computing affine form score Can be either
                        an int between [0, number of outputs -1] or "min" or "max" or
                        "sum"

logging options:
  --log_dir LOG_DIR     Directory where to keep logs
  --log_name LOG_NAME   Directory to save the logging result of the experiment
  --log_date [LOG_DATE]
                        Adds the date to the name of the logging folder
  --log_number LOG_NUMBER
                        Adds a number to the name of the logging folder
  --header HEADER       Header for the tree html file
  --log_intermediate [LOG_INTERMEDIATE]
                        Stores all intermediate results when running analysis (e.g
                        intermediate zonotopes and bounds. If false only store final
                        domain and output_bounds

debugging options:
  --debug_file DEBUG_FILE   File for a logger for debugging purpose
  --debug [DEBUG]       If True will print INFO and DEBUG to the console or a log file
  --relative_path [RELATIVE_PATH]
                        If True will consider paths (logging dir, model path, image
                        path... as relative path from project root
```

Analysis can be also run with a config.ini specification e.g (more examples in configs folder):

```ini
[data]
model_path = pyrat_sound/models/mnist/smallFNN.onnx

[logging]
log_dir = results
log_name = results
log_date = False
log_number

[domain]
domains = [zonotopes]
max_size =  -1
max_noise = -1
by_layer = True
allow_smaller_size = False

[analysis]
split = True
timeout = 20
add_suffix = True
nb_process = 1
verbose = True

[partitioning]
refined_split = (2,)
refine_criterion = polarity
scorer = WidthScorer
refine_val = 0.3

[acas]
i = 2
j = 1
prop = 3

[adv_robust]
dataset = mnist
nb_img = 10
shuffle = False
epsilon = 0.03
image = pyrat_sound/tests/images/npy/mnist.npy
true_label = 1
total_labels = 10
```

No argument is mandatory but some of the arguments are incompatible (property path and adversarial robustness or acas
etc.). In this case default behavior is:

- If there is no model path the analysis will run on the specified acas network / property
- If there is a model path and no property path:
    - if there is an image path: run analysis on the image (epsilon, true labels and total_labels required)
    - if there is no image and a dataset name: run benchmark on the dataset (nb_image, shuffle are required)

Other cases should fail as the arguments are incomplete (can't run analysis with no property nor image nor dataset
paths).
(proper checks / error raising when parsing arguments is TODO)

The same logic is applied to analysis from config files.

Arguments related to logging / partitioning can be ignored, it's an anticipation on work in progress (
logging can be safely removed from ini files but partitioning should remain as follows for default analysis with splits.
)

```ini
[partitioning]
refined_split = (2,)
refine_criterion = polarity
scorer = WidthScorer
refine_val = 0.3
```

running from terminal examples:

```bash
python pyrat.py --dataset mnist --model_path ./models/mnist/smallFNN.onnx --nb_img 100 \
--epsilon 0.05 --split False

python pyrat.py --split True --acas 3 1 3 --verbose True --domains zonotopes

python pyrat.py --model_path ./models/technip/test_offi.nnet \
 --property_path ./properties/technip/prop3.txt --split True --verbose True \
 --nb_process 4 --domains zonotopes --timeout 60
```
