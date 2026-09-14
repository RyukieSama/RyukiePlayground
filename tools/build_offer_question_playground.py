#!/usr/bin/env python3
"""从旧 Playground 提取题面，生成不包含答案的练习版 Playground。"""

from __future__ import annotations

import html
import re
import shutil
from pathlib import Path


ROOT = Path(__file__).resolve().parent.parent
SOURCE = ROOT / "剑指Offer.playground"
TARGET = ROOT / "剑指Offer-题目与用例.playground"


# 旧页面中缺少明确示例标记的题目，在这里补齐公开题面中的标准用例。
FALLBACK_CASES = {
    "07.重建二叉树": """**输入：** `preorder = [3,9,20,15,7]`，`inorder = [9,3,15,20,7]`

**输出：** `[3,9,20,null,null,15,7]`""",
    "32-I.从上到下打印二叉树": """**输入：** `root = [3,9,20,null,null,15,7]`

**输出：** `[3,9,20,15,7]`""",
    "32-II.从上到下打印二叉树II": """**输入：** `root = [3,9,20,null,null,15,7]`

**输出：** `[[3],[9,20],[15,7]]`""",
    "32-III.从上到下打印二叉树III": """**输入：** `root = [3,9,20,null,null,15,7]`

**输出：** `[[3],[20,9],[15,7]]`""",
    "36.二叉搜索树与双向链表": """**输入：** `root = [4,2,5,1,3]`

**输出：** 双向循环链表 `[1,2,3,4,5]`""",
    "55-I.二叉树的深度": """**输入：** `root = [3,9,20,null,null,15,7]`

**输出：** `3`""",
    "92. 区间反转链表 II": """**输入：** `head = [1,2,3,4,5]`，`left = 2`，`right = 4`

**输出：** `[1,4,3,2,5]`""",
    "1047. 删除字符串中的所有相邻重复项": """**输入：** `s = \"abbaca\"`

**输出：** `\"ca\"`""",
    "1209. 删除字符串中的所有相邻重复项 II": """**输入：** `s = \"deeedbbcccbdaa\"`，`k = 3`

**输出：** `\"aa\"`""",
    "剑指 Offer 09. 用两个栈实现队列": """**输入：** `[\"CQueue\", \"appendTail\", \"deleteHead\", \"deleteHead\"]`，`[[], [3], [], []]`

**输出：** `[null, null, 3, -1]`""",
    "剑指 Offer II 022. 链表中环的入口节点": """**输入：** `head = [3,2,0,-4]`，`pos = 1`

**输出：** 返回索引为 `1` 的链表节点""",
}


# 这些旧页面只有链接或残缺的一句话，因此补为完整题面；内容仅含题目与用例。
OVERRIDE_DOCUMENTS = {
    "剑指 Offer 09. 用两个栈实现队列": """
用两个栈实现一个队列。请实现 `appendTail` 和 `deleteHead`：前者在队列尾部插入整数，后者删除并返回队列头部的整数。若队列为空，`deleteHead` 返回 `-1`。

示例 1：

输入：`["CQueue", "appendTail", "deleteHead", "deleteHead"]`，`[[], [3], [], []]`

输出：`[null, null, 3, -1]`

限制：

- `1 <= value <= 10000`
- 最多调用 `appendTail`、`deleteHead` 10000 次

链接：https://leetcode.cn/problems/yong-liang-ge-zhan-shi-xian-dui-lie-lcof/
""",
    "剑指 Offer II 022. 链表中环的入口节点": """
给定一个链表，返回链表开始入环的第一个节点。如果链表无环，则返回 `nil`。

使用整数 `pos` 表示链表尾连接到链表中的位置（索引从 0 开始）；`pos = -1` 表示链表无环。`pos` 只用于描述用例，不会作为参数传入。不得修改给定链表。

示例 1：

输入：`head = [3,2,0,-4]`，`pos = 1`

输出：返回索引为 `1` 的链表节点

示例 2：

输入：`head = [1,2]`，`pos = 0`

输出：返回索引为 `0` 的链表节点

示例 3：

输入：`head = [1]`，`pos = -1`

输出：`nil`

限制：

- 链表节点数在 `[0, 10⁴]` 范围内
- `-10⁵ <= Node.val <= 10⁵`
- `pos` 为 `-1` 或链表中的有效索引

链接：https://leetcode.cn/problems/c32eOV/
""",
    "92. 区间反转链表 II": """
给定单链表的头节点 `head` 和两个整数 `left`、`right`，其中 `left <= right`。反转从位置 `left` 到位置 `right` 的链表节点，返回反转后的链表。

示例 1：

输入：`head = [1,2,3,4,5]`，`left = 2`，`right = 4`

输出：`[1,4,3,2,5]`

示例 2：

输入：`head = [5]`，`left = 1`，`right = 1`

输出：`[5]`

限制：

- 链表节点数为 `n`
- `1 <= n <= 500`
- `-500 <= Node.val <= 500`
- `1 <= left <= right <= n`

链接：https://leetcode.cn/problems/reverse-linked-list-ii/
""",
    "1047. 删除字符串中的所有相邻重复项": """
给定一个仅由小写字母组成的字符串 `s`。一次重复项删除操作会选择两个相邻且相同的字母并将它们删除。

反复执行删除操作，直到无法继续。返回最终的字符串，答案保证唯一。

示例 1：

输入：`s = "abbaca"`

输出：`"ca"`

解释：先删除 `"bb"` 得到 `"aaca"`，再删除 `"aa"` 得到 `"ca"`。

限制：

- `1 <= s.count <= 10⁵`
- `s` 仅由小写英文字母组成

链接：https://leetcode.cn/problems/remove-all-adjacent-duplicates-in-string/
""",
    "1209. 删除字符串中的所有相邻重复项 II": """
给定字符串 `s` 和整数 `k`。一次删除操作会选择 `k` 个相邻且相同的字母并将它们删除，使被删除部分的左右两侧重新连接。

反复执行删除操作，直到无法继续。返回最终的字符串，答案保证唯一。

示例 1：

输入：`s = "abcd"`，`k = 2`

输出：`"abcd"`

示例 2：

输入：`s = "deeedbbcccbdaa"`，`k = 3`

输出：`"aa"`

示例 3：

输入：`s = "pbbcggttciiippooaais"`，`k = 2`

输出：`"ps"`

限制：

- `1 <= s.count <= 10⁵`
- `2 <= k <= 10⁴`
- `s` 仅由小写英文字母组成

链接：https://leetcode.cn/problems/remove-all-adjacent-duplicates-in-string-ii/
""",
}


# 将旧题面中叙述式或代码式的示例统一为明确的输入、输出格式。
NORMALIZED_CASE_SECTIONS = {
    "04.二维数组中的查找": """## 用例

**输入：**

```
matrix = [
  [1,  4,  7, 11, 15],
  [2,  5,  8, 12, 19],
  [3,  6,  9, 16, 22],
  [10,13, 14, 17, 24],
  [18,21, 23, 26, 30]
]
target = 5
```

**输出：** `true`

**输入：** 使用相同的 `matrix`，`target = 20`

**输出：** `false`""",
    "22.链表中倒数第k个节点": """## 用例

**输入：** `head = [1,2,3,4,5]`，`k = 2`

**输出：** 节点 `4`，即链表 `[4,5]`""",
    "30.包含min函数的栈": """## 用例

**输入：**

```
["MinStack", "push", "push", "push", "min", "pop", "top", "min"]
[[], [-2], [0], [-3], [], [], [], []]
```

**输出：** `[null, null, null, null, -3, null, 0, -2]`""",
    "34.二叉树中和为某一值的路径": """## 用例

**输入：** `root = [5,4,8,11,null,13,4,7,2,null,null,5,1]`，`target = 22`

**输出：** `[[5,4,11,2], [5,8,4,5]]`""",
    "55-II.平衡二叉树": """## 用例 1

**输入：** `root = [3,9,20,null,null,15,7]`

**输出：** `true`

## 用例 2

**输入：** `root = [1,2,2,3,3,null,null,4,4]`

**输出：** `false`""",
}


def normalized_name(old_name: str) -> str:
    """统一题号格式，同时明确区分 Offer II 和额外的 LeetCode 题。"""
    name = old_name.replace("⭐️", "").strip()
    name = name.replace("（回溯法）", "")
    name = name.replace("(没有Swift用例)", "")
    name = re.sub(r"^剑指\s*Offer\s+II\s+(\d+)\.\s*", r"Offer-II-\1-", name)
    name = re.sub(r"^剑指\s*Offer\s+(\d+)\.\s*", r"\1-", name)

    match = re.match(r"^(\d+)(?:\.\s*|-)(.*)$", name)
    if match:
        number, title = match.groups()
        if number in {"92", "1047", "1209"}:
            return f"LeetCode-{int(number):04d}-{title.strip()}"
        title = re.sub(r"^(I{1,3})[.．-]", r"\1-", title.strip())
        return f"{number}-{title}"
    return name


def sort_key(old_name: str) -> tuple[int, int, str]:
    """剑指 Offer、Offer II、补充 LeetCode 题依次排列。"""
    if old_name.startswith("剑指 Offer II"):
        number = int(re.search(r"(\d+)", old_name).group(1))
        return (1, number, old_name)
    if re.match(r"^(92|1047|1209)\.", old_name):
        number = int(re.match(r"\d+", old_name).group())
        return (2, number, old_name)
    number_match = re.search(r"\d+", old_name)
    return (0, int(number_match.group()) if number_match else 9999, old_name)


def extract_document(source: str) -> str:
    match = re.search(r"/\*:(.*?)\*/", source, flags=re.DOTALL)
    if not match:
        raise ValueError("页面中未找到 Playground Markdown 题面")
    return match.group(1)


def clean_document(raw: str, old_name: str, title: str) -> str:
    """清理转载声明和噪声，并统一常见题面标签的 Markdown 样式。"""
    raw = raw.replace("\u00a0", " ").replace("\u3000", " ")
    lines = [line.rstrip() for line in raw.splitlines()]
    urls: list[str] = []
    cleaned: list[str] = []
    in_fence = False

    for line in lines:
        stripped = line.strip()
        if old_name == "14-I.剪绳子" and re.match(r"^##\s*二、", stripped):
            break
        if "leetcode" in stripped.lower():
            urls.extend(re.findall(r"https?://[^\s)>]+", stripped))
        if any(token in stripped for token in ("著作权归领扣", "商业转载请联系", "非商业转载请注明")):
            continue
        if re.fullmatch(r"通过次数.*提交次数.*", stripped):
            continue
        if re.fullmatch(r"\[.*?\]\(https?://.*?\)", stripped):
            continue
        if stripped.startswith(("链接：http", "链接: http", "来源：", "* 来源：", "* 链接：")):
            continue

        if stripped.startswith("```"):
            in_fence = not in_fence
            cleaned.append(stripped)
            continue

        if not in_fence:
            if re.match(r"^#{1,4}\s*(?:一、\s*)?题目\s*$", stripped):
                cleaned.append("## 题目")
                continue
            heading_text = stripped.strip("* ")
            heading = re.match(r"^(示例(?:\s*\d+)?|示例一|示例二)\s*[：:]?\s*(.*)$", heading_text)
            if heading:
                case_number = heading.group(1).removeprefix("示例").strip()
                case_number = {"一": "1", "二": "2"}.get(case_number, case_number)
                case_heading = f"## 用例 {case_number}" if case_number else "## 用例"
                suffix = heading.group(2)
                cleaned.extend([case_heading, suffix] if suffix else [case_heading])
                continue
            heading = re.match(r"^(限制|约束|提示|说明)\s*[：:]?\s*(.*)$", heading_text)
            if heading:
                label, suffix = heading.groups()
                label = "约束" if label == "限制" else label
                cleaned.extend([f"## {label}", suffix] if suffix else [f"## {label}"])
                continue
            io_line = re.match(r"^(输入|输出)\s*[：:]\s*(.*)$", stripped)
            if io_line:
                cleaned.append(f"**{io_line.group(1)}：** {io_line.group(2)}")
                continue

        cleaned.append(line.strip() if stripped else "")

    # 合并多余空行，让各页在 Xcode 中保持一致的阅读节奏。
    compact: list[str] = []
    for line in cleaned:
        if line or (compact and compact[-1]):
            compact.append(line)
    while compact and not compact[-1]:
        compact.pop()

    has_case = any(line.startswith("## 用例") or line.startswith("**输入：**") for line in compact)
    if not has_case and old_name in FALLBACK_CASES:
        compact.extend(["", "## 用例", "", FALLBACK_CASES[old_name]])

    # 去掉题面开头偶尔重复出现的标题，标题统一由页面生成。
    while compact and not compact[0]:
        compact.pop(0)
    if compact and compact[0].lstrip("# ").replace(" ", "") in {
        old_name.replace(" ", ""),
        title.replace(" ", ""),
    }:
        compact.pop(0)
        while compact and not compact[0]:
            compact.pop(0)

    body = "\n".join(compact)
    if not body.startswith("## "):
        body = "## 题目\n\n" + body
    if "## 用例" not in body:
        body = re.sub(
            r"\n(```[^\n]*\n输入[：:])",
            r"\n\n## 用例\n\n\1",
            body,
            count=1,
        )

    if old_name in NORMALIZED_CASE_SECTIONS:
        case_pattern = r"## 用例.*?(?=\n## (?:约束|提示|说明|来源)|\Z)"
        body = re.sub(
            case_pattern,
            NORMALIZED_CASE_SECTIONS[old_name] + "\n",
            body,
            count=1,
            flags=re.DOTALL,
        ).rstrip()

    unique_urls = list(dict.fromkeys(url.rstrip("。；;") for url in urls))
    if unique_urls:
        problem_urls = [url for url in unique_urls if "/problems/" in url]
        body += f"\n\n## 来源\n\n[LeetCode 原题]({(problem_urls or unique_urls)[0]})"

    return f"//: [上一题](@previous)\n\n/*:\n# {title}\n\n{body}\n*/\n\n//: [下一题](@next)\n"


def main() -> None:
    if TARGET.exists():
        shutil.rmtree(TARGET)
    pages_dir = TARGET / "Pages"
    pages_dir.mkdir(parents=True)

    old_pages: list[tuple[str, Path]] = []
    for contents in (SOURCE / "Pages").glob("*.xcplaygroundpage/Contents.swift"):
        old_name = contents.parent.name.removesuffix(".xcplaygroundpage")
        old_pages.append((old_name, contents))
    old_pages.sort(key=lambda item: sort_key(item[0]))

    page_names: list[str] = []
    for old_name, contents in old_pages:
        new_name = normalized_name(old_name)
        page_names.append(new_name)
        page_dir = pages_dir / f"{new_name}.xcplaygroundpage"
        page_dir.mkdir()
        source = contents.read_text(encoding="utf-8")
        raw_document = OVERRIDE_DOCUMENTS.get(old_name, extract_document(source))
        document = clean_document(raw_document, old_name, new_name)
        (page_dir / "Contents.swift").write_text(document, encoding="utf-8")

    page_xml = "\n".join(f"        <page name='{html.escape(name, quote=True)}'/>" for name in page_names)
    manifest = f"""<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<playground version='6.0' target-platform='ios' display-mode='rendered'>
    <pages>
{page_xml}
    </pages>
</playground>
"""
    (TARGET / "contents.xcplayground").write_text(manifest, encoding="utf-8")
    print(f"已生成 {len(page_names)} 个页面：{TARGET}")


if __name__ == "__main__":
    main()
