Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from zeniv-ca.linux.org.uk ([2607:5300:60:148a::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nEMRV-007snJ-Ty
 for linux-um@lists.infradead.org; Mon, 31 Jan 2022 02:29:23 +0000
Date: Mon, 31 Jan 2022 02:29:06 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [tip:x86/core 1/1] arch/x86/um/../lib/csum-partial_64.c:98:12:
 error: implicit declaration of function 'load_unaligned_zeropad'
Message-ID: <YfdJcu1xE1kv55Up@zeniv-ca.linux.org.uk>
References: <202111180219.YkyoBMpf-lkp@intel.com>
 <CANn89iJfh+x-s4GtWJcyRFpMmSvvyq-r1TGV4sDLXy3F50zD6w@mail.gmail.com>
 <CANn89iJj4zeNUiXCmG=rSejbHAwPhBEPKUv1tPL9ig=e4vg7pQ@mail.gmail.com>
 <YZZ4upqWGMOY+r56@hirez.programming.kicks-ass.net>
 <Ycv5mF+gfGxlmmQL@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Ycv5mF+gfGxlmmQL@zeniv-ca.linux.org.uk>
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
To: Peter Zijlstra <peterz@infradead.org>
Cc: Eric Dumazet <edumazet@google.com>, kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org, linux-kernel@vger.kernel.org, x86@kernel.org, Alexander Duyck <alexanderduyck@fb.com>, linux-um@lists.infradead.org

On Wed, Dec 29, 2021 at 06:00:56AM +0000, Al Viro wrote:
> On Thu, Nov 18, 2021 at 05:00:58PM +0100, Peter Zijlstra wrote:
> 
> > Dear um folks, is this indeed the best solution? It's a bit sad to have
> > to add this to x86_64, but if that's the way it is...
> 
> Something like this, perhaps? (absolutely untested)

[snip]
AFAICS, this (on top of current mainline) does the right thing.

commit 6692531df62d812de5d22c8bca0d90edc163aa84
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Sun Jan 30 21:25:53 2022 -0500

    uml/x86: use x86 load_unaligned_zeropad()
    
    allows, among other things, to drop !DCACHE_WORD_ACCESS mess in
    x86 csum-partial_64.c
    
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index e5a7b552bb384..a58b67ec8119d 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -23,7 +23,6 @@ generic-y += softirq_stack.h
 generic-y += switch_to.h
 generic-y += topology.h
 generic-y += trace_clock.h
-generic-y += word-at-a-time.h
 generic-y += kprobes.h
 generic-y += mm_hooks.h
 generic-y += vga.h
diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
index 1f8a8f8951738..50734a23034c4 100644
--- a/arch/x86/lib/csum-partial_64.c
+++ b/arch/x86/lib/csum-partial_64.c
@@ -93,7 +93,6 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
 		buff += 8;
 	}
 	if (len & 7) {
-#ifdef CONFIG_DCACHE_WORD_ACCESS
 		unsigned int shift = (8 - (len & 7)) * 8;
 		unsigned long trail;
 
@@ -103,31 +102,6 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
 		    "adcq $0,%[res]"
 			: [res] "+r" (temp64)
 			: [trail] "r" (trail));
-#else
-		if (len & 4) {
-			asm("addq %[val],%[res]\n\t"
-			    "adcq $0,%[res]"
-				: [res] "+r" (temp64)
-				: [val] "r" ((u64)*(u32 *)buff)
-				: "memory");
-			buff += 4;
-		}
-		if (len & 2) {
-			asm("addq %[val],%[res]\n\t"
-			    "adcq $0,%[res]"
-				: [res] "+r" (temp64)
-				: [val] "r" ((u64)*(u16 *)buff)
-				: "memory");
-			buff += 2;
-		}
-		if (len & 1) {
-			asm("addq %[val],%[res]\n\t"
-			    "adcq $0,%[res]"
-				: [res] "+r" (temp64)
-				: [val] "r" ((u64)*(u8 *)buff)
-				: "memory");
-		}
-#endif
 	}
 	result = add32_with_carry(temp64 >> 32, temp64 & 0xffffffff);
 	if (unlikely(odd)) {
diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
index 40d6a06e41c81..4eb47d3ba6250 100644
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@ -8,6 +8,7 @@ endmenu
 
 config UML_X86
 	def_bool y
+	select DCACHE_WORD_ACCESS
 
 config 64BIT
 	bool "64-bit kernel" if "$(SUBARCH)" = "x86"

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

