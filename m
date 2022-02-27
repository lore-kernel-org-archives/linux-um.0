Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH v3 1/7] overflow: Provide constant expression struct_size
Date: Sun, 27 Feb 2022 10:45:11 -0800
Message-Id: <20220227184517.504931-2-keescook@chromium.org>
In-Reply-To: <20220227184517.504931-1-keescook@chromium.org>
References: <20220227184517.504931-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Kees Cook <keescook@chromium.org>
Cc: "Gustavo A . R . Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Vitor Massaru Iha <vitor@massaru.org>, Daniel Latypov <dlatypov@google.com>, David Gow <davidgow@google.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, linux-kbuild@vger.kernel.org, kunit-dev@googlegroups.com, llvm@lists.linux.dev, x86@kernel.org, linux-hardening@vger.kernel.org
List-ID: <linux-um.lists.infradead.org>

There have been cases where struct_size() (or flex_array_size()) needs
to be calculated for an initializer, which requires it be a constant
expression. This is possible when the "count" argument is a constant
expression, so provide this ability for the helpers.

Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Tested-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Link: https://lore.kernel.org/lkml/20220210010407.GA701603@embeddedor
---
v1: https://lore.kernel.org/linux-hardening/20220210004326.776574-1-keescook@chromium.org
v2:
 - fix broken self-test due to CE optimization
---
 include/linux/overflow.h | 10 +++++++---
 lib/test_overflow.c      | 26 +++++++++++++++++---------
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 59d7228104d0..f1221d11f8e5 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -4,6 +4,7 @@
 
 #include <linux/compiler.h>
 #include <linux/limits.h>
+#include <linux/const.h>
 
 /*
  * We need to compute the minimum and maximum values representable in a given
@@ -221,8 +222,9 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
  * Return: number of bytes needed or SIZE_MAX on overflow.
  */
 #define flex_array_size(p, member, count)				\
-	size_mul(count,							\
-		 sizeof(*(p)->member) + __must_be_array((p)->member))
+	__builtin_choose_expr(__is_constexpr(count),			\
+		(count) * sizeof(*(p)->member) + __must_be_array((p)->member),	\
+		size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
 
 /**
  * struct_size() - Calculate size of structure with trailing flexible array.
@@ -237,6 +239,8 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
  * Return: number of bytes needed or SIZE_MAX on overflow.
  */
 #define struct_size(p, member, count)					\
-	size_add(sizeof(*(p)), flex_array_size(p, member, count))
+	__builtin_choose_expr(__is_constexpr(count),			\
+		sizeof(*(p)) + flex_array_size(p, member, count),	\
+		size_add(sizeof(*(p)), flex_array_size(p, member, count)))
 
 #endif /* __LINUX_OVERFLOW_H */
diff --git a/lib/test_overflow.c b/lib/test_overflow.c
index 712fb2351c27..f6530fce799d 100644
--- a/lib/test_overflow.c
+++ b/lib/test_overflow.c
@@ -602,10 +602,18 @@ struct __test_flex_array {
 
 static int __init test_overflow_size_helpers(void)
 {
+	/* Make sure struct_size() can be used in a constant expression. */
+	u8 ce_array[struct_size((struct __test_flex_array *)0, data, 55)];
 	struct __test_flex_array *obj;
 	int count = 0;
 	int err = 0;
 	int var;
+	volatile int unconst = 0;
+
+	/* Verify constant expression against runtime version. */
+	var = 55;
+	OPTIMIZER_HIDE_VAR(var);
+	err |= sizeof(ce_array) != struct_size(obj, data, var);
 
 #define check_one_size_helper(expected, func, args...)	({	\
 	bool __failure = false;					\
@@ -663,28 +671,28 @@ static int __init test_overflow_size_helpers(void)
 				     flex_array_size, obj, data, var++);
 	err |= check_one_size_helper(5 * sizeof(*obj->data),
 				     flex_array_size, obj, data, var++);
-	err |= check_one_size_helper(0, flex_array_size, obj, data, 0);
+	err |= check_one_size_helper(0, flex_array_size, obj, data, 0 + unconst);
 	err |= check_one_size_helper(sizeof(*obj->data),
-				     flex_array_size, obj, data, 1);
+				     flex_array_size, obj, data, 1 + unconst);
 	err |= check_one_size_helper(7 * sizeof(*obj->data),
-				     flex_array_size, obj, data, 7);
+				     flex_array_size, obj, data, 7 + unconst);
 	err |= check_one_size_helper(SIZE_MAX,
-				     flex_array_size, obj, data, -1);
+				     flex_array_size, obj, data, -1 + unconst);
 	err |= check_one_size_helper(SIZE_MAX,
-				     flex_array_size, obj, data, SIZE_MAX - 4);
+				     flex_array_size, obj, data, SIZE_MAX - 4 + unconst);
 
 	var = 4;
 	err |= check_one_size_helper(sizeof(*obj) + (4 * sizeof(*obj->data)),
 				     struct_size, obj, data, var++);
 	err |= check_one_size_helper(sizeof(*obj) + (5 * sizeof(*obj->data)),
 				     struct_size, obj, data, var++);
-	err |= check_one_size_helper(sizeof(*obj), struct_size, obj, data, 0);
+	err |= check_one_size_helper(sizeof(*obj), struct_size, obj, data, 0 + unconst);
 	err |= check_one_size_helper(sizeof(*obj) + sizeof(*obj->data),
-				     struct_size, obj, data, 1);
+				     struct_size, obj, data, 1 + unconst);
 	err |= check_one_size_helper(SIZE_MAX,
-				     struct_size, obj, data, -3);
+				     struct_size, obj, data, -3 + unconst);
 	err |= check_one_size_helper(SIZE_MAX,
-				     struct_size, obj, data, SIZE_MAX - 3);
+				     struct_size, obj, data, SIZE_MAX - 3 + unconst);
 
 	pr_info("%d overflow size helper tests finished\n", count);
 
-- 
2.32.0


