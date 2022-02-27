Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH v3 4/7] um: Remove unused timeval_to_ns() function
Date: Sun, 27 Feb 2022 10:45:14 -0800
Message-Id: <20220227184517.504931-5-keescook@chromium.org>
In-Reply-To: <20220227184517.504931-1-keescook@chromium.org>
References: <20220227184517.504931-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Kees Cook <keescook@chromium.org>
Cc: David Gow <davidgow@google.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Vitor Massaru Iha <vitor@massaru.org>, Daniel Latypov <dlatypov@google.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, linux-kbuild@vger.kernel.org, kunit-dev@googlegroups.com, llvm@lists.linux.dev, x86@kernel.org, linux-hardening@vger.kernel.org
List-ID: <linux-um.lists.infradead.org>

From: David Gow <davidgow@google.com>

The timeval_to_ns() function doesn't appear to be used anywhere, as far
as I (or git grep) can tell, and clang throws up a warning about it:

../arch/um/os-Linux/time.c:21:25: warning: unused function 'timeval_to_ns' [-Wunused-function]
static inline long long timeval_to_ns(const struct timeval *tv)
                        ^
1 warning generated.

Signed-off-by: David Gow <davidgow@google.com>
Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Link: https://lore.kernel.org/lkml/78d6ac17-9492-7c41-d6dd-4c92dce8ce62@cambridgegreys.com
Signed-off-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20220224081233.1765788-1-davidgow@google.com
---
This is a resend of the above linked patch, just included in this series.
---
 arch/um/os-Linux/time.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/um/os-Linux/time.c b/arch/um/os-Linux/time.c
index 6c5041c5560b..4d5591d96d8c 100644
--- a/arch/um/os-Linux/time.c
+++ b/arch/um/os-Linux/time.c
@@ -18,12 +18,6 @@
 
 static timer_t event_high_res_timer = 0;
 
-static inline long long timeval_to_ns(const struct timeval *tv)
-{
-	return ((long long) tv->tv_sec * UM_NSEC_PER_SEC) +
-		tv->tv_usec * UM_NSEC_PER_USEC;
-}
-
 static inline long long timespec_to_ns(const struct timespec *ts)
 {
 	return ((long long) ts->tv_sec * UM_NSEC_PER_SEC) + ts->tv_nsec;
-- 
2.32.0


