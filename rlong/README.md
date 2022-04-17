# Context-dependent semantic parsing datasets

**Paper:** <https://arxiv.org/abs/1606.05378>

**CodaLab:** <https://worksheets.codalab.org/worksheets/0xad3fc9f52f514e849b282a105b1e3f02/>

This package contains three datasets called Alchemy, Scene, and Tangrams.

Each example contains an initial world state, several natural language instructions (up to 5 utterances),
and the target final world state. Please refer to the CodaLab worksheet above for examples.

## File format

Each tab-seperated line contains the following fields:

    ID WORLD_0 UTTERANCE_1 WORLD_1 ... UTTERANCE_N WORLD_N

For example:

    train-A9164 <tab> 1:ggg 2:_ 3:_ 4:_ 5:o 6:ooo 7:gggg <tab> throw out two units of first beaker <tab> 1:g 2:_ 3:_ 4:_ 5:o 6:ooo 7:gggg <tab> ...

Each world state (`WORLD_i`) contains several object of the form `position:properties`.
The objects are encoded as follows:

- **Alchemy:** Each object is a beaker.
  Each unit of chemical in the beaker is encoded as a character indicating the color.
  An empty beaker is denoted as `_`.
- **Scene:** Each object is a position on a stage. Each position contains at most 1 person.
  Each person is encoded as the shirt color followed by the hat color (or `_` = no hat).
  An empty position is denoted as `__`.
- **Tangrams:** Each object is a tangram piece encoded as the shape ID.

## Raw data

The files `<domain>-<train|dev|test>.tsv` include complete 5-utterance (or 3-uttrance) instructions.
In addition to the initial and final world states, these files also have the world state following
each utterance in the instruction.

## Reproducing the setting in the ACL 2016 paper

The experiments in the paper use examples with 1 to 2 utterances for training,
and examples with 3 or 5 utterances for evaluation.

**Training:**
The files `<domain>-train-orig.tsv` contains training data as used in the ACL 2016 paper.
Examples in these files contain 1 or 2 utterances from the middle of the 5-utterance instructions.
The intermediate world states of 2-utterance examples are not used, and thus are replaced with `?`.

**Evaluation:**
For dev and test data, use the first 3 or 5 utterances from files `<domain>-<dev|test>.tsv`.
