Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from zeniv-ca.linux.org.uk ([2607:5300:60:148a::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n2S1S-002Jlf-AI
 for linux-um@lists.infradead.org; Wed, 29 Dec 2021 06:01:15 +0000
Date: Wed, 29 Dec 2021 06:00:56 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [tip:x86/core 1/1] arch/x86/um/../lib/csum-partial_64.c:98:12:
 error: implicit declaration of function 'load_unaligned_zeropad'
Message-ID: <Ycv5mF+gfGxlmmQL@zeniv-ca.linux.org.uk>
References: <202111180219.YkyoBMpf-lkp@intel.com>
 <CANn89iJfh+x-s4GtWJcyRFpMmSvvyq-r1TGV4sDLXy3F50zD6w@mail.gmail.com>
 <CANn89iJj4zeNUiXCmG=rSejbHAwPhBEPKUv1tPL9ig=e4vg7pQ@mail.gmail.com>
 <YZZ4upqWGMOY+r56@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YZZ4upqWGMOY+r56@hirez.programming.kicks-ass.net>
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

On Thu, Nov 18, 2021 at 05:00:58PM +0100, Peter Zijlstra wrote:

> Dear um folks, is this indeed the best solution? It's a bit sad to have
> to add this to x86_64, but if that's the way it is...

Something like this, perhaps? (absolutely untested)

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
diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
index 95d26a69088b1..a812cc35092c6 100644
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@ -9,6 +9,7 @@ endmenu
 config UML_X86
 	def_bool y
 	select GENERIC_FIND_FIRST_BIT
+	select DCACHE_WORD_ACCESS
 
 config 64BIT
 	bool "64-bit kernel" if "$(SUBARCH)" = "x86"

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

