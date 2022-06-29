def predict_diff_bomb_effect(current_blknum, current_difficulty, block_adjustment, months):
    '''
    Predicts the effect on block time (as a ratio) in a specified amount of months in the future.
    Vars used for predictions:
    current_blknum = 14884880 # Jun 01, 2022
    current_difficulty = 13891609586928851
    block adjustment = 11200000
    months = 2.5 # August 2022
    months = 4 # October 2022
    '''
    blocks_per_month = (86400 * 30) // 13.3
    future_blknum = current_blknum + blocks_per_month * months
    diff_adjustment = 2 ** ((future_blknum - block_adjustment) // 100000 - 2)
    diff_adjust_coeff = diff_adjustment / current_difficulty * 2048
    return diff_adjust_coeff


diff_adjust_coeff = predict_diff_bomb_effect(14884880,13891609586928851,11200000,2.5)
diff_adjust_coeff = predict_diff_bomb_effect(14884880,13891609586928851,11200000,4)
