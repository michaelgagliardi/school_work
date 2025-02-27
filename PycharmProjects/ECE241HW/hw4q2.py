import sys


class Fence_Builder:

    # Constructor
    def __init__(self, planks):
        self.plank_list = planks

    # Returns the list of plans to be selected
    def select_planks(self, fence_length):
        remaining_length = fence_length
        list_of_planks = []
        min_planks = [sys.maxsize] * (fence_length + 1) ##minimum number of planks for all fence lengths
        track = [None] * (fence_length + 1)
        min_planks[0] = 0

        for length in range(fence_length):
            for i, plank_length in enumerate(self.plank_list):
                if plank_length + length <= fence_length and min_planks[plank_length + length] > 1 + min_planks[length]:
                    min_planks[plank_length + length] = 1 + min_planks[length]
                    track[plank_length + length] = i

        while track[remaining_length] is not None:
            list_of_planks.append(self.plank_list[track[remaining_length]])
            remaining_length -= self.plank_list[track[remaining_length]]

        return sorted(list_of_planks,reverse=True)


if __name__ == "__main__":
    fence_1 = (128, 134)
    fence_2 = (50, 54)
    planks = [1, 5, 10, 21, 25]
    sol = Fence_Builder(planks)
    print(sol.select_planks(fence_1[0]))
    print(sol.select_planks(fence_1[1]))
    print(sol.select_planks(fence_2[0]))
    print(sol.select_planks(fence_2[1]))