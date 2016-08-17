Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: [PATCH] UML: don't discard .text.exit section
Date: Wed, 17 Aug 2016 18:10:11 +0300
Message-ID: <1471446611-16250-1-git-send-email-aryabinin@virtuozzo.com>
In-Reply-To: <CAFLxGvzB=WGNEdNJVvPpQLpwCqT6oNcvEQnyT2xk0Jv2L3FBaA@mail.gmail.com>
References: <CAFLxGvzB=WGNEdNJVvPpQLpwCqT6oNcvEQnyT2xk0Jv2L3FBaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Stefan Traby <stefan@hello-penguin.com>, Dmitry Vyukov <dvyukov@google.com>, stable@vger.kernel.org, Andrey Ryabinin <aryabinin@virtuozzo.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Commit e41f501d3912 ("vmlinux.lds: account for destructor sections")
added '.text.exit' to EXIT_TEXT which is discarded at link time by default.
This breaks compilation of UML:
     `.text.exit' referenced in section `.fini_array' of
     /usr/lib/gcc/x86_64-linux-gnu/6/../../../x86_64-linux-gnu/libc.a(sdlerror.o):
     defined in discarded section `.text.exit' of
     /usr/lib/gcc/x86_64-linux-gnu/6/../../../x86_64-linux-gnu/libc.a(sdlerror.o)

Apparently UML doesn't want to discard exit text, so let's place all EXIT_TEXT
sections in .exit.text.

Fixes: e41f501d3912 ("vmlinux.lds: account for destructor sections")
Reported-by: Stefan Traby <stefan@hello-penguin.com>
Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: <stable@vger.kernel.org> # 4.0+
---
 arch/um/include/asm/common.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/include/asm/common.lds.S b/arch/um/include/asm/common.lds.S
index 1dd5bd8..1330553 100644
--- a/arch/um/include/asm/common.lds.S
+++ b/arch/um/include/asm/common.lds.S
@@ -81,7 +81,7 @@
   .altinstr_replacement : { *(.altinstr_replacement) }
   /* .exit.text is discard at runtime, not link time, to deal with references
      from .altinstructions and .eh_frame */
-  .exit.text : { *(.exit.text) }
+  .exit.text : { EXIT_TEXT }
   .exit.data : { *(.exit.data) }
 
   .preinit_array : {
-- 
2.7.3


