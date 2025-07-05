import sys
import random
import os
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
from example.watch_games import *

NB_ITERATIONS_TESTS = 100000
NB_SEC_TESTS = int(sys.argv[1]) 
print("nb seconds:", NB_SEC_TESTS)
def create_property_based_test(f):
    regressions = []
    tstart = time.time()

    i = 0
    while (time.time() - tstart) < NB_SEC_TESTS:
        if i < len(regressions):
            seed = regressions[i]
        else:
            seed = random.randrange(0, 2**64)
    i += 1
    random.seed(seed)
    try:
        f()
    except AssertionError as err:
        print(seed, "test failed")
        print(err)
        sys.exit(1)


def test_mkbar():
    score = random.randrange(-10000,10000)
    print("score:", score)

    potential = random.randrange(0,10000)
    print("potential is :",potential)

    if score < 0 :
        score_max = 0
    else :
        score_max = score + potential
    print("score_max :",score_max)

    if score == 0 :
        print("score is null")
        assert score_max == potential
    elif potential == 0 :
        print("potential is nul")
        assert score_max == score
    elif score < 0:
        print('score is negative')
        assert score_max ==0
    else :
        assert score_max > score
        assert score_max > potential

    res = mkbar(score,potential,score_max)
    print("res:",res)
    assert len(res) > 0
    scorelen = 0
    potentialen = 0
    voidlen = 0
    for x in range(len(res)):
        if res[x] == '█':
            scorelen+=1
        elif res[x] == '▒':
            potentialen+=1
        else : 
            voidlen +=1
    print("scorelength :{}, potentiallength: {}, voidlen:{}".format(scorelen,potentialen,voidlen))
    if score > potential :
        print("score sup")
        assert scorelen>potentialen
    elif potential>score :
        print("pot superieur")
        assert potentialen>=scorelen #>= car si score =0 alors potentialen et scorelen = 0
    else:
        print("egalité")
        assert scorelen == potentialen
    if (score + potential) < score_max/2 :
        print("voidlen plus grand")
        assert voidlen > (scorelen+potentialen)/2

create_property_based_test(test_mkbar)