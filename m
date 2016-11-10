Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 9 Nov 2016 20:53:26 -0500
From: Keno Fischer <keno@juliacomputing.com>
Subject: [PATCH] um: Fix compile failure due to current_text_address()
 definition
Message-ID: <20161110015326.GA51351@juliacomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: jdike@addtoit.com, richard@nod.at, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Fixes the following link error:
```
/usr/bin/ld: net/built-in.o: relocation R_X86_64_32S against `.text'
can not be used when making a shared object; recompile with -fPIC
```

This is the same definition used on some other architectures.

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
---
I am not sure this is the correct patch in the context of uml. I believe this
should give the runtime ip, which may be different between runs. It may be
better to use the offset in .text (e.g. by using `pc-__text_start`), which
should be consistent.

 arch/x86/um/asm/processor_64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/um/asm/processor_64.h b/arch/x86/um/asm/processor_64.h
index c3be852..6ca3304 100644
--- a/arch/x86/um/asm/processor_64.h
+++ b/arch/x86/um/asm/processor_64.h
@@ -32,7 +32,7 @@ static inline void arch_copy_thread(struct arch_thread *from,
 }
 
 #define current_text_addr() \
-	({ void *pc; __asm__("movq $1f,%0\n1:":"=g" (pc)); pc; })
+	({ __label__ _l; _l: &&_l; })
 
 #define current_sp() ({ void *sp; __asm__("movq %%rsp, %0" : "=r" (sp) : ); sp; })
 #define current_bp() ({ unsigned long bp; __asm__("movq %%rbp, %0" : "=r" (bp) : ); bp; })
-- 
2.9.3


