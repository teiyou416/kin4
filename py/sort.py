
def selection_sort(arr):
    n = len(arr)
    compare_count = 0
    for i in range(n):
        min_index = i
        for j in range(i + 1, n):
            if arr[j] < arr[min_index]:
                min_index = j
        arr[i], arr[min_index] = arr[min_index], arr[i]
        compare_count += 1
    return compare_count

def bubble_sort(arr):
    n = len(arr)
    compare_count = 0
    for i in range(n):
        for j in range(n - 1 - i):
            if arr[j] > arr[j + 1]:
                arr[j], arr[j + 1] = arr[j + 1], arr[j]
                compare_count += 1
    return compare_count

# 测试数组
arr = [5, 2, 3, 1, 8, 9, 0, 7, 4, 6]

# 比较次数
selection_count = selection_sort(arr.copy())  # 复制数组避免排序干扰
bubble_count = bubble_sort(arr.copy())

print(f"选择排序的比较次数: {selection_count}")
print(f"冒泡排序的比较次数: {bubble_count}")
