Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nN9F2-00HFb8-9P
 for linux-um@lists.infradead.org; Thu, 24 Feb 2022 08:12:49 +0000
Received: by mail-pg1-x54a.google.com with SMTP id
 t7-20020a634447000000b0036579648983so795148pgk.3
 for <linux-um@lists.infradead.org>; Thu, 24 Feb 2022 00:12:46 -0800 (PST)
Date: Thu, 24 Feb 2022 16:12:33 +0800
Message-Id: <20220224081233.1765788-1-davidgow@google.com>
Mime-Version: 1.0
Subject: [PATCH] um: Remove unused timeval_to_ns() function
From: David Gow <davidgow@google.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>
Cc: linux-um@lists.infradead.org, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>

The timeval_to_ns() function doesn't appear to be used anywhere, as far
as I (or git grep) can tell, and clang throws up a warning about it:

../arch/um/os-Linux/time.c:21:25: warning: unused function 'timeval_to_ns' [-Wunused-function]
static inline long long timeval_to_ns(const struct timeval *tv)
                        ^
1 warning generated.

Signed-off-by: David Gow <davidgow@google.com>
---

Warning can be reproduced under clang 13.0.1-+rc1 after applying:
um: Allow builds with Clang -- https://lkml.org/lkml/2022/2/24/40

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
2.35.1.473.g83b2b277ed-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

