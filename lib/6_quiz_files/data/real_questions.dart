import 'package:connections/6_quiz_files/models/quiz_question_model.dart';

const List<List<QuizQuestion>> questionSets = [
  [ // Set 1
    QuizQuestion('How many phases are in Mitosis?', ['3', '4', '1', '5'], '4'),
    QuizQuestion('What is a zygote?', ['A fertilized egg', 'A fertilized sperm', 'A cell in the endometrium', 'A reproductive hormone'], 'A fertilized egg'),
    QuizQuestion('What is a cell?', ['An epithelial tissue', 'The basic unit of life', 'The smallest organ', 'A type of room'], 'The basic unit of life'),
    QuizQuestion('What is the purpose of mitosis?', ['For the production of haploid cells', 'For cell communication', 'For DNA replication', 'For growth and replacement of  cells'], 'For growth and replacement of  cells'),
    QuizQuestion('What are the two main types of cells?', ['Positive cell and negative cell', 'Egg cell and sperm cell', 'Prokaryotes and eukaryotes', 'Skin cells and brain cells'], 'Prokaryotes and eukaryotes'),
  ],
  [ // Set 2
    QuizQuestion('Chromosomes contain ______.', ['Genes', 'Water', 'Vesicles', 'Cytosol'], 'Genes'),
    QuizQuestion('What are XY and XX chromosomes?', ['Non-existent chromosomes', 'Eye color chromosome', 'Sex type chromosome', 'A body type chromosome'], 'Sex type chromosome'),
    QuizQuestion('What is the purpose of a chromosome?', ['It carries genetic information', 'It carries energy', 'It carries chemical messengers', 'It carries oxygen'], 'It carries genetic information'),
    QuizQuestion('Which of the following is NOT true about the hierarchical structure of chromosomes?', ['In a chromosome, the DNA wraps around proteins called histones', 'The coils of DNA around histones are called nucleosomes', 'The nucleosomes fold up and form the chromatin fiber', 'The chromatin fiber unwinds to form the chromosome'], 'The chromatin fiber unwinds to form the chromosome'),
    QuizQuestion('Do all living things have the same shape of chromosome?', ['Yes', 'No', 'Maybe', 'Cannot be determined'], 'No'),
  ],
  [ // Set 3
    QuizQuestion('What is P in PMAT?', ['Paraphrase', 'Pass phase', 'Prophase', 'Protophase'], 'Prophase'),
    QuizQuestion('Which of the following does NOT happen in Prophase?', ['The nuclear membrane disintegrates', 'The DNA supercoils in chromosomes', 'The sister chromatids start to separate', 'The centrosomes move to opposite sides of the nucleus'], 'The sister chromatids start to separate'),
    QuizQuestion('As the DNA condenses into chromosomes, which of the following does NOT happen? ', ['A protein called cohesin forms rings that hold the sister chromatids together', 'A protein called albumin transports the histones to the DNA', 'A protein called condensin forms rings that coil the chromosomes into highly compact forms', 'The sister chromatids are held together by the centromere'], 'A protein called albumin transports the histones to the DNA'),
    QuizQuestion('In Prophase, the chromosomes become visible under the microscope.', ['True', 'False', 'Maybe', 'Cannot be determined'], 'True'),
    QuizQuestion('In Prophase, the centrosomes start their production of __________.', ['Synovial fluid', 'Nitrogenous bases', 'RNA', 'Spindle fibers'], 'Spindle fibers'),
  ],
  [ // Set 4
    QuizQuestion('What is M in PMAT?', ['Megaphase', 'Maltosephase', 'Metaphase', 'Measuring phase'], 'Metaphase'),
    QuizQuestion('What is the purpose of Metaphase?', ['It is the first stage of mitosis after interphase', 'It does not have any clear purpose', 'It prepares the duplicated chromosomes to move to mitosis', 'It makes the chromosome line up in the middle in preparation of the next phase'], 'It makes the chromosome line up in the middle in preparation of the next phase'),
    QuizQuestion('___________ is the part of the nucleus that is responsible for capturing all the chromosomes and lining them up in the middle.', ['Spinner', 'Spammer', 'Spider', 'Spindle'], 'Spindle'),
    QuizQuestion('Which of the following is NOT needed to align the sister chromatids in the middle?', ['Centrioles', 'Centromere', 'Spindle fibers', 'Nuclear envelope'], 'Nuclear envelope'),
    QuizQuestion('Where do spindle fibers form?', ['Centrioles', 'Century', 'Centromere', 'Chromatids'], 'Centrioles'),
  ],
  [ // Set 5
    QuizQuestion('How many phases does Mitosis have?', ['It varies', '3', '2', '4'], '4'),
    QuizQuestion('Why is Mitosis important? ', ['It helps deliver the needed nutrients to the organ', 'It helps reduce the risks of mutation', 'It helps combine cells for improvement', 'It helps by replacing old and worn out cells with new ones'], 'It helps by replacing old and worn out cells with new ones'),
    QuizQuestion('Eukaryotes can also be described as _________.', ['Cells that sexually reproduce', 'Cells that spontaneously generate', 'Cells use transformation and transduction to reproduce', 'Cells that cannot reproduce'], 'Cells that sexually reproduce'),
    QuizQuestion('What do eukaryotes and prokaryotes have in common?', ['They both contain a genetic material', 'Both are a type of cell', 'Both can reproduce ', 'All of the choices'], 'All of the choices'),
    QuizQuestion('What are prokaryotes? ', ['Cells that sexually reproduce', 'Cells that spontaneously generate', 'Cells that use transformation and transduction to reproduce', 'Cells that cannot reproduce'], 'Cells that use transformation and transduction to reproduce'),
  ],
  [ // Set 6
    QuizQuestion('What does DNA stand for?', ['Deoxyribosome nucleic acid', 'Deoxyribose nucleouse acid', 'Detoxyribose-nuclei acid', 'Deoxyribonucleic acid'], 'Deoxyribonucleic acid'),
    QuizQuestion('How many strands does DNA have?', ['3', '5', '2', '1'], '2'),
    QuizQuestion('DNA strands also resemble ____________.', ['An icosahedron', 'A double helix', 'A triple helix', 'A 1-D line'], 'A double helix'),
    QuizQuestion('Which of  the following is the correct base pairing of DNA?', ['Adenine, Cytosine', 'Uracil , Adenine', 'Guanine, Cytosine', 'Cytosine, Thymine'], 'Guanine, Cytosine'),
    QuizQuestion('Nucleic acids like RNA and DNA are made up of monomers called nucleotides. Which of the following is NOT a part of the nucleotide?', ['5-carbon sugar', 'Lipids', 'Phosphate group', 'Nitrogenous base'], 'Lipids'),
  ],
  [ // Set 7
    QuizQuestion('What is A in PMAT?', ['Aristophanes', 'Arachnophase', 'Anaphase', 'Anatomy'], 'Anaphase'),
    QuizQuestion('What is the purpose of Anaphase?', ['Separating the sister chromatids', 'Combining the sister chromatids', 'Twisting the sister chromatids', 'Switching the p and q arms of the chromatids'], 'Separating the sister chromatids'),
    QuizQuestion('In Anaphase the sister chromatids are ___________ from each other', ['Combined', 'Pulled away', 'Twisted', 'Switched'], 'Pulled away'),
    QuizQuestion('In Anaphase the spindle fibers begin to _______ in order to pull the sister chromatids apart. ', ['Twist', 'Shorten', 'Break', 'Elongate'], 'Shorten'),
    QuizQuestion('Why do spindle fibers pull the sister chromatids apart in mitosis?', ['Because the sister chromatids hate each other', 'Because the sister chromatids are fragile', 'To ensure that each daughter cell gets identical sets of chromosomes', 'To make the daughter cells haploid'], 'To ensure that each daughter cell gets identical sets of chromosomes'),
  ],
  [ // Set 8
    QuizQuestion('What is T in PMAT?', ['Telekinophase', 'Telephose', 'Transfer phase', 'Telophase'], 'Telophase'),
    QuizQuestion('What happens in Telophase?', ['It is the step where the nucleus starts to reform.', 'It is the step where the chromosomes line up in the middle.', 'It is the first step and most important step of mitosis.', 'It is the step where chromosomes are duplicated.'], 'It is the step where the nucleus starts to reform.'),
    QuizQuestion('In Telophase, the cell also undergoes a process called _____________.', ['Telekinesis', 'Cytokinesis', 'Cell constriction', 'Cell division'], 'Cytokinesis'),
    QuizQuestion('What is a nuclear envelope?', ['A fancy envelope', 'A synonym of cell wall', 'A barrier that encloses the DNA', 'A barrier to protect us from nuclears'], 'A barrier that encloses the DNA'),
    QuizQuestion('Does Telophase occur both in mitosis and meiosis? ', ['No', 'Maybe', 'Cannot be determined', 'Yes'], 'Yes'),
  ],
  [ // Set 9
    QuizQuestion('What happens in Cytokinesis?', ['Cell undergoes programmed cell death', 'Cell undergoes a frozen state', 'The parent cell is finally split into two daughter cells', 'The parent cell is finally split into four daughter cells'], 'The parent cell is finally split into two daughter cells'),
    QuizQuestion('What is the purpose of actin in Cytokinesis?', ['It mixes the two new daughter cells', 'It is a preliminary protein for creating the cell wall', 'It acts as a binder connecting the two new daughter cells', 'It acts as a drawstring creating a barrier between two new daughter cells'], 'It acts as a drawstring creating a barrier between two new daughter cells'),
    QuizQuestion('Karyokinesis is the splitting of the nucleus to form two daughter nuclei. It happens _______ the Cytokinesis, which is the division of the cytoplasm.', ['Simultaneously with', 'After', 'Two steps after', 'Before'], 'Before'),
    QuizQuestion('The parent cell gets a pinch crease in Cytokinesis to help it split into two daughter cells. A pinch crease is also called what?', ['V furrow', 'Curve furrow', 'Cleavage furrow', 'Parabolic furrow'], 'Cleavage furrow'),
    QuizQuestion('What is actin made of?', ['Acid', 'Protein', 'Specialized Cells', 'Water'], 'Protein'),
  ],
  [ // Set 10
    QuizQuestion('G0 phase is also called what?', ['Cell cycle let go', 'Cell cycle arrest', 'Cell cycle combine', 'Cell cycle continuous'], 'Cell cycle arrest'),
    QuizQuestion('How many stages does interphase have?', ['3', '2', '5', '1'], '3'),
    QuizQuestion('How many chromosomes are in a diploid cell?', ['n', '2n', '3n', '2n - 1'], '2n'),
    QuizQuestion('Why is G2 important in interphase?', ['This is the phase where the DNA is duplicated', 'This is the phase where the cell rests and stops growing for a while', 'This is where the cell grows further and synthesize proteins to prepare for cell division', 'This is where the cell double shrinks and sheds off unnecessary materials to prepare for cell division'], 'This is where the cell grows further and synthesize proteins to prepare for cell division'),
    QuizQuestion('What is the longest part of the cell cycle?', ['Anaphase', 'Telophase', 'Interphase', 'Metaphase'], 'Interphase'),
  ],
  [ // Set 11
    QuizQuestion('What are centromeres?', ['Area where sister chromatids are held together', 'Cause for formation of the spindle fibers', 'Center for a certain gene', 'Area where crossing over of sister chromatids occur'], 'Area where sister chromatids are held together'),
    QuizQuestion('What are centrioles?', ['Area where sister chromatids are held together', 'Cause for formation of the spindle fibers', 'Center for a certain gene', 'Area where crossing over of sister chromatids occur'], 'Cause for formation of the spindle fibers'),
    QuizQuestion('Kinetochores are important proteinaceous structures in mitosis. Which of the following correctly describes it?', ['A type of cell that specializes on spindle fiber production', 'A special egg that can self-fertilize', 'A specialized structure on the centriole to which the microtubular spindle fibers attach during mitosis', 'A specialized structure on the centromere to which the microtubular spindle fibers attach during mitosis'], 'A specialized structure on the centromere to which the microtubular spindle fibers attach during mitosis'),
    QuizQuestion('What is the nuclear membrane?', ['A part of the brain', 'A semipermeable layer that encloses a cell', 'A process in mitosis', 'A layer that attacks the cell'], 'A semipermeable layer that encloses a cell'),
    QuizQuestion('What is being referred to as poles in mitosis?', ['A type of tube', 'Region in a cell where centrioles go during metaphase ', 'Outside layer of cell', 'A structure in the cytoskeleton'], 'Region in a cell where centrioles go during metaphase'),
  ],
  
  [ // Set 12
    QuizQuestion('Before a cell can divide, the DNA in the nucleus of the cell must be duplicated.', ['True', 'False', 'Maybe', 'Cannot be determined'], 'True'),
    QuizQuestion('DNA has a double helix structure.', ['True', 'False', 'Maybe', 'Cannot be determined'], 'True'),
    QuizQuestion('In Cytokinesis, pinch creases are also called a cleavage furrow.', ['True', 'False', 'Maybe', 'Cannot be determined'], 'True'),
    QuizQuestion('There are a total of 92 chromatids in a diploid HUMAN cell.', ['True', 'False', 'Maybe', 'Cannot be determined'], 'True'),
    QuizQuestion('Metaphase is the part where sister chromatids are separated.', ['True', 'False', 'Maybe', 'Cannot be determined'], 'False'),
  ],
  
  [ // Set 13
    QuizQuestion('The longest period for a cell life is Telophase.', ['True.', 'False. It is Interphase.', 'Maybe. It could also be Anaphase.', 'Cannot be determined. It varies depending on the cell.'], 'False. It is Interphase.'),
    QuizQuestion('The G2 phase checkpoint double checks the duplicated chromosomes for errors.', ['True', 'False', 'Maybe', 'Cannot be determined'], 'True'),
    QuizQuestion('Nuclear envelope reforms in Telophase.', ['True', 'False', 'Maybe', 'Cannot be determined'], 'True'),
    QuizQuestion('Spindle fibers attach at the centromere of each pair of the sister chromatid during metaphase.', ['True', 'False', 'Maybe', 'Cannot be determined'], 'True'),
    QuizQuestion('Mitosis produces two daughter nuclei that have different genetic material.', ['True', 'False', 'Maybe', 'Cannot be determined'], 'False'),
  ],
  
  [ // Set 14
    QuizQuestion('Rings of actin filaments form in the metaphase plate to create the cleavage furrow in Cytokinesis.', ['True', 'False', 'Maybe', 'Cannot be determined'], 'True'),
    QuizQuestion('In metaphase, centrioles move into the poles of the cell.', ['True', 'False', 'Maybe', 'Cannot be determined'], 'True'),
    QuizQuestion('XY and XX chromosomes are sex type chromosomes.', ['True', 'False', 'Maybe', 'Cannot be determined'], 'True'),
    QuizQuestion('YY chromosomes exist.', ['True', 'False', 'Maybe', 'Cannot be determined'], 'False'),
    QuizQuestion('The first 22 pairs of chromosomes in a human karyotype will help determine whether it belongs to a male or female.', ['True', 'False', 'Maybe', 'Cannot be determined'], 'False'),
  ],
  
  [ // Set 15
    QuizQuestion('What is the 4th stage of Mitosis or the 4th letter in PMAT?', ['Telophase', 'Thymine', 'Theory', 'Thylakoid'], 'Telophase'),
    QuizQuestion('During which phase do chromosomes first become visible?', ['Prophase', 'Telophase', 'Metaphase', 'Interphase'], 'Prophase'),
    QuizQuestion('What process is Cytokinesis?', ['Divides the cytoplasm of a parental cell into 2 daughter cells', 'Divides the cytoplasm of a parental cell into 4 daughter cells', 'Multiplies the cytoplasm of a parental cell into 2 daughter cells', 'Multiplies the cytoplasm of a parental cell into 4 daughter cells'], 'Divides the cytoplasm of a parental cell into 2 daughter cells'),
    QuizQuestion('These are found in the Interphase or the late G2 phase where the cell has copied its DNA and presents with two connected copies which are?', ['Sister Chromatids', 'Brother Chromatids', 'Chromatids', 'Twin Chromatids'], 'Sister Chromatids'),
    QuizQuestion('What happens in Early Prophase in context with spindle fibers? ', ['Mitotic spindle fibers start to form', 'Mitotic spindle fibers had already formed', 'Mitotic spindle fibers have not formed', 'Mitotic spindle fibers are already captured and organized in the chromosomes'], 'Mitotic spindle fibers start to form'),
  ],
  
  [ // Set 16
    QuizQuestion('It is the second MAIN stage of the mitotic phase and is also called “Cell Motion”.', ['Cytokinesis', 'Metaphase', 'Telophase', 'Meiosis'], 'Cytokinesis'),
    QuizQuestion('What is Mitosis?', ['process where a cell segregates its replicated chromosomes and produces two identical nuclei', 'process where a cell does not replicate but segregates and produces two identical nuclei', 'process where a cell replicates its chromosomes, segregates them, and produces two different nuclei', 'process where a cell does not replicate but segregates and produces two identical nuclei'], 'process where a cell segregates its replicated chromosomes and produces two identical nuclei'),
    QuizQuestion('What happens in the Early Prophase in the context of chromosomes?', ['Chromosomes start to condense', 'Chromosomes are already condensed', 'Chromosomes have not condensed but will in late prophase', 'Chromosomes don’t need to condense'], 'Chromosomes start to condense'),
    QuizQuestion('When does Cytokinesis happen?', ['Overlaps the final stages of mitosis and starts in either anaphase or telophase', 'Overlaps the final stages of mitosis and starts in either prophase or metaphase', 'Does not overlap the final stages but the early ones, either by prophase or metaphase', 'Does not overlap the final stages but early, either by anaphase or telophase'], 'Overlaps the final stages of mitosis and starts in either anaphase or telophase'),
    QuizQuestion('What becomes of an animal cell in Cytokinesis?', ['It pinches the cell into two, much like a coin purse with a drawstring', 'It can’t be divided because animal cells are too stiff', 'It separates the cell into three', 'Cytokinesis does not happen in animal cells'], 'It pinches the cell into two, much like a coin purse with a drawstring'),
  ],
  
  [ // Set 17
    QuizQuestion('When does Mitosis begin?', ['Prophase', 'Metaphase', 'Cytokinesis', 'Anaphase'], 'Prophase'),
    QuizQuestion('What happens in Metaphase?', ['The chromosomes line up in the middle of the cell', 'The chromosomes attach to the sides of the cell and form spindle fibers', 'The chromosomes are pulled at opposite sides by spindle fibers', 'The chromosomes duplicate'], 'The chromosomes line up in the middle of the cell'),
    QuizQuestion('What becomes the by-product of Cytokinesis? ', ['Two new cells, with a complete set of chromosomes identical to that of the mother cell.', 'Four new cells, with a complete set of chromosomes identical to the that of the mother cell.', 'Two new cells, with a complete set of chromosomes different from that of the mother cell.', 'Four new cells, with a complete set of chromosomes different from that of the mother cell.'], 'Two new cells, with a complete set of chromosomes identical to that of the mother cell.'),
    QuizQuestion('What phase occurs when chromatids separate into two identical chromosomes pulled at opposite sides?', ['Anaphase', 'Telophase', 'Metaphase', 'Prophase'], 'Anaphase'),
    QuizQuestion('Why is Mitosis important?', ['The great majority of the cell division happening inside our body involves mitosis.', 'It is not important.', 'Because mitosis gives us energy.', 'The great majority of cell multiplication happening inside our body involves mitosis.'], 'The great majority of the cell division happening inside our body involves mitosis.'),
  ],
  
  [ // Set 18
    QuizQuestion('When do chromosomes condense and appear visible?', ['Prophase', 'Anaphase', 'Telophase', 'Mitosis'], 'Prophase'),
    QuizQuestion('What happens during telophase?', ['Chromosomes decondensed and the nuclear envelope forms', 'Division of the cytoplasm occurs', 'Centrioles complete their migration to the poles', 'Centrioles form and move towards opposite ends of the cell'], 'Chromosomes decondensed and the nuclear envelope forms'),
    QuizQuestion('It is the long period of the cell cycle between one mitosis and the next.', ['Interphase', 'Prophase', 'Metaphase', 'Anaphase'], 'Interphase'),
    QuizQuestion('What includes Interphase?', ['Gap 1 Phase, DNA Synthesis, Gap 2 Phase', 'Prophase, Metaphase, Anaphase', 'Gap 1 and Gap 2', 'Gap 1 and Prophase'], 'Gap 1 Phase, DNA Synthesis, Gap 2 Phase'),
    QuizQuestion('Which is the final stage of cell division in eukaryotes and prokaryotes?', ['Cytokinesis', 'Telophase', 'M Phase', 'Interphase'], 'Cytokinesis'),
  ],
  
  [ // Set 19
    QuizQuestion('What does a cell become when it divides and has a replicated DNA condensed and coiled into an X-shaped form?', ['Chromosome', 'Chromatin', 'Chromatids', 'DNA'], 'Chromosome'),
    QuizQuestion('What region holds up sister chromatids?', ['Centromere', 'Chromatin', 'Chromosome', 'Chromatids'], 'Centromere'),
    QuizQuestion('When do sister chromatids separate and do the resultant daughter chromosomes move toward the poles?', ['Anaphase', 'Telophase', 'Interphase', 'Prometaphase'], 'Anaphase'),
    QuizQuestion('What happens during the M in PMAT?', ['Chromosomes are aligned in the middle of the equatorial plane', 'Chromosomes are aligned at the side of the equatorial plane', 'Chromosomes reach the opposite poles by the spindle fibers', 'Chromones start to condense and appear visible'], 'Chromosomes are aligned in the middle of the equatorial plane'),
    QuizQuestion('What happens during cytokinesis inside animal cells?', ['Plasma membranes of the parent cell pinch along the equator of the cell till 2 daughter cell is created', 'Plasma membranes of the parent cell pinch along the equator of the cell 4 daughter cell is created', 'Plasma membranes of the parent cell form one', 'Plasma membranes of the parent cell pinch along the equator of the cell and stay that way'], 'Plasma membranes of the parent cell pinch along the equator of the cell till 2 daughter cell is created'),
  ],

  [ // Set 20
    QuizQuestion('Which phase replicates the DNA?', ['S phase', 'M Phase', 'Interphase', 'Prophase'], 'S phase'),
    QuizQuestion('What is the purpose of centromeres? ', ['Hold sister chromatids together and serve as attachment site for spindle fibers to help in proper alignment and segregation of chromosomes', 'To make sure the chromosomes stay in place in the middle', 'To keep the chromosomes from moving to the opposite poles of the cell', 'For the aesthetic'], 'Hold sister chromatids together and serve as attachment site for spindle fibers to help in proper alignment and segregation of chromosomes'),
    QuizQuestion('What begins to form in Prophase?', ['Mitotic spindle fibers', 'Centromeres', 'Chromosomes', 'Two Daughter Cells'], 'Mitotic spindle fibers'),
    QuizQuestion('When do centrosomes begin to move to the opposite poles of the cell?', ['Prophase', 'Metaphase', 'Anaphase', 'Telophase'], 'Prophase'),
    QuizQuestion('Cytokinesis occurs the same for animal and plant cells.', ['False', 'True', 'Maybe', 'Not sure'], 'False'),
  ],
  
  [ // Set 21
    QuizQuestion('When do chromosomes decondense or unravel in PMAT? ', ['Telophase', 'Prophase', 'Metaphase', 'Prometaphase'], 'Telophase'),
    QuizQuestion('What happens during Gap 1 in Interphase?', ['Cellular contents apart from chromosomes are duplicated', 'Cellular contents including chromosomes are duplicated', 'Cellular contents apart from chromosomes condense', 'Cellular contents including chromosomes are condensed'], 'Cellular contents apart from chromosomes are duplicated'),
    QuizQuestion('Prophase covers the spindle fibers’ motion to attach in each centriole of the sister chromatids.', ['True', 'Mostly False', 'False', 'Not Sure'], 'True'),
    QuizQuestion('What is the shortest stage of mitosis seen in PMAT?', ['Anaphase', 'Metaphase', 'Prophase', 'Gap 2 Phase'], 'Anaphase'),
    QuizQuestion('What is the S phase also called?', ['DNA Synthesis', 'RNA Synthesis', 'Spindle Fiber Phase', 'Gap 2 Phase'], 'DNA Synthesis'),
  ],

  [ // Set 22
    QuizQuestion('What happens during the S Phase in Interphase?', ['46 chromosomes are duplicated by the cell.', 'Cellular contents are duplicated.', 'The cells are “double-checked” to determine if attempted duplicated chromosomes are properly replicated.', 'Nuclear membranes are dissolved.'], '46 chromosomes are duplicated by the cell.'),
    QuizQuestion('Which phase is in Interphase where cells are assured to have no error in duplication in case of needed repair?', ['Gap 2 Phase', 'Gap 1 Phase', 'DNA Synthesis', 'S Phase'], 'Gap 2 Phase'),
    QuizQuestion('When do spindle fibers attach to kinetochores and begin to shorten and pull sister chromatids apart?', ['Anaphase', 'Metaphase', 'M phase', 'Cytokinesis'], 'Anaphase'),
    QuizQuestion('What substages are in Mitosis respectively?', ['Prophase, Metaphase, Anaphase, Telophase', 'Metaphase, Prophase, Anaphase, Telophase', 'Prophase, M-Phase, Anaphase, Cytokinesis', 'Cytokinesis, Anaphase, Prophase, Gap 1 Phase'], 'Prophase, Metaphase, Anaphase, Telophase'),
    QuizQuestion('What forms during Telophase?', ['2 daughter nuclei form', '4 daughter nuclei form', '2 brother nuclei form', '4 brother nuclei form'], '2 daughter nuclei form'),
  ],
  
  [ // Set 23
    QuizQuestion('Sperm and egg cells are the product of Mitosis.', ['True', 'False', 'Maybe', 'Cannot be determined'], 'False'),
    QuizQuestion('The duplication of chromosomes happens during the Interphase.', ['True', 'False', 'Maybe', 'Cannot be determined'], 'True'),
    QuizQuestion('The centromeres divide during the Metaphase.', ['True', 'False', 'Maybe', 'Cannot be determined'], 'False'),
    QuizQuestion('The nuclear membrane reappears during the Anaphase.', ['True', 'False', 'Maybe', 'Cannot be determined'], 'False'),
    QuizQuestion('Telophase happens before Metaphase.', ['True', 'False', 'Maybe', 'Cannot be determined'], 'False'),
  ],

  [ // Set 24
    QuizQuestion('The process of Mitosis ensures that:', ['cells will divide at an inappropriate time', 'each new cell receives the proper number of chromosomes', 'DNA is replicated without errors', 'each new cell is genetically different from its parent'], 'each new cell receives the proper number of chromosomes'),
    QuizQuestion('A cell that has 20 chromosomes undergoes Mitosis. Which of the following is true?', ['2 daughter cells will be created, each having 10 chromosomes', '4 daughter cells will be created, each having 10 chromosomes', 'two daughter cells will be created, each have 40 chromosomes', 'two daughter cells will be created, each have 20 chromosomes'], 'two daughter cells will be created, each have 20 chromosomes'),
    QuizQuestion('A spindle forms during which phase?', ['toothpaste', 'propaste', 'no face', 'prophase'], 'prophase'),
    QuizQuestion('Most cells spend their lives in:', ['Interphase', 'Metaphase', 'Prophase', 'Telophase'], 'Interphase'),
    QuizQuestion('What structure is responsible for moving the chromosomes during mitosis?', ['nuclear membrane', 'spindle', 'nucleolus', 'cytoplasm'], 'spindle'),
  ],
  
  [ // Set 25
    QuizQuestion('Cells will generally divide when?', ['they are 10 hours old', 'they become infected', 'they become too large', 'they have no food'], 'they become too large'),
    QuizQuestion('Each chromosome consists of 2 _____.', ['centrofibers', 'chromatids', 'daughter cells', 'centrioles'], 'chromatids'),
    QuizQuestion('During which phase do chromosomes first become visible?', ['Interphase', 'Telophase', 'Metaphase', 'Prophase'], 'Prophase'),
    QuizQuestion('A cell with 10 chromosomes undergoes Mitosis. How many daughter cells are created? ___ Each daughter cell has ___ chromosomes.', ['2, 10', '10, 2', '1, 10', '2, 20'], '2, 10'),
    QuizQuestion('Which phase occurs directly after Metaphase?', ['Telophase', 'Anaphase', 'Metaphase', 'Prophase'], 'Anaphase'),
  ],

  [ // Set 26
    QuizQuestion('What is chromatin? ', ['It is when the nuclear DNA exists as a grainy material', 'It is when the nuclear DNA exists as a smooth material', 'It is when the DNA condenses and forms an X-shape material', 'It is when the DNA condenses and forms an Y-shape material'], 'It is when the nuclear DNA exists as a grainy material'),
    QuizQuestion('What happens in Mitosis?', ['It is a phase of eukaryotic cells where DNA replication and the formation of 2 daughter cells occur', 'It is a phase of prokaryotic cells where DNA replication and the formation of 2 daughter cells occur', 'It is a phase of eukaryotic cells where DNA replication and the formation of 4 daughter cells occur', 'It is a phase of prokaryotic cells where DNA replication and the formation of 4 daughter cells occur'], 'It is a phase of eukaryotic cells where DNA replication and the formation of 2 daughter cells occur'),
    QuizQuestion('The late Phase of Prophase is called Prometaphase. ', ['True', 'False', 'Maybe', "I don't know"], 'True'),
    QuizQuestion('What is the first and longest phase of mitosis?', ['Prophase', 'Metaphase', 'Prometaphase', 'Anaphase'], 'Prophase'),
    QuizQuestion('Some spindles do not attach to the kinetochore protein of the centromeres.', ['True', 'False', 'All spindles attach to the kinetochore of the protein', 'Maybe'], 'True'),
  ],
  [ // Set 27
    QuizQuestion('How many spindle fibers are attached to each chromosome?', ['Two', 'One', 'Four', 'Three'], 'Two'),
    QuizQuestion('Why are non-kinetochore microtubules important?', ['They help in the elongation of the cell', 'They are not important because they do not attach to the kinetochore protein of centromeres', 'They are important because they keep the chromosomes aligned in the middle', 'They help in creating a cleavage furrow to create 2 daughter cells'], 'They help in the elongation of the cell'),
    QuizQuestion('Which analogy fits the spindle fibers’ motion during Anaphase?', ['Like reeling a fish by shortening the fishing line', 'Time is like a river', 'Like a needle in a haystack', 'In is to out as up is to down'], 'Like reeling a fish by shortening the fishing line'),
    QuizQuestion('What happens when conditions are not met during mitosis?', ['The process halts', 'The process continues', 'The process gradually continues', 'The process starts from the beginning'], 'The process halts'),
    QuizQuestion('What does mitosis have with the purpose of re-assuring that the cell’s growth is proceeding correctly?', ['Checkpoints', 'Barrier', 'Roadblock', 'Restriction'], 'Checkpoints'),
  ],
  [ // Set 28
    QuizQuestion('What is the M phase also referred to as?', ['Mitosis', 'S Phase', 'Gap 1 Phase', 'DNA Synthesis'], 'Mitosis'),
    QuizQuestion('What is the S phase also referred to as?', ['Gap 1 Phase', 'Gap 2 Phase', 'M Phase', 'DNA Synthesis'], 'DNA Synthesis'),
    QuizQuestion('When do chromosomes migrate to the poles in PMAT?', ['Metaphase', 'Telophase', 'Anaphase', 'Cytokinesis'], 'Anaphase'),
    QuizQuestion('In which phase do chromatids become chromosomes?', ['Anaphase', 'Telophase', 'Prophase', 'Metaphase'], 'Anaphase'),
    QuizQuestion('When does the division of the cytoplasm occur?', ['Cytokinesis', 'Telophase', 'Mitosis', 'Meiosis'], 'Cytokinesis'),
  ],
  [ // Set 29
    QuizQuestion('When do two nuclei form in a cell?', ['Telophase', 'Anaphase', 'Metaphase', 'Prophase'], 'Telophase'),
    QuizQuestion('What forms during Cytokinesis in the center of an elongated animal cell?', ['Microfilament Ring', 'Microtubules', 'Centrioles', 'Spindle Fibers'], 'Microfilament Ring'),
    QuizQuestion('What happens during Anaphase?', ['One sister chromatid moves to one pole and the other toward the opposite.', 'One sister chromatid moves to one pole and the other follows.', 'One sister chromatid moves to one pole and the other stays in place.', 'Both sister chromatids don’t move yet.'], 'One sister chromatid moves to one pole and the other toward the opposite.'),
    QuizQuestion('Where do spindle fibers go after separating the sister chromatids and the cell divides?', ['They will go to different daughter cells', 'They will go to the same daughter cells', 'They will go home', 'They will disperse'], 'They will go to different daughter cells'),
    QuizQuestion('When do spindle fibers form?', ['When the centrioles move apart in Prophase', 'When the centrioles move apart in Metaphase', 'When the centrioles move apart in Anaphase', 'Telophase'], 'When the centrioles move apart in Prophase'),
  ],
  [ // Set 30
    QuizQuestion('These are depolymerized into tubulin monomers that will be used to assemble cytoskeletal components for each daughter cell.', ['Mitotic Spindles', 'Centrioles', 'Daughter Cells', 'Cleavage Furrow'], 'Mitotic Spindles'),
    QuizQuestion('At the end of this phase, each pole of the cell has a complete set of chromosome.', ['Anaphase', 'Telophase', 'Metaphase', 'Interphase'], 'Anaphase'),
    QuizQuestion('These are composed of sister chromatids.', ['Chromosomes', 'Chromatin', 'DNA', 'Cell'], 'Chromosomes'),
    QuizQuestion('What do spindles attach to during mitosis that contain proteins called kinetochores?', ['Centromere', 'Chromatid', 'Chromosome', 'Poles'], 'Centromere'),
    QuizQuestion("During cytokinesis, animal cells’ plasma membrane of the parent cell pinches inward along the cell's equator until two daughter cells form.", ['True.', 'False, that does not happen.', 'False, that happens in plant cells.', 'Maybe.'], 'True.'),
  ],
  // ... more sets of 5 questions
];