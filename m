Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43810CA1010
	for <linux-um@archiver.kernel.org>; Tue,  2 Sep 2025 21:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:
	References:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Subject:Date:From:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xioHQ5KTG+jebQzTOOBaTVLdwwFRjLNCqggcN57Q9EM=; b=z5VhQ+Z0zNOnGlvPf3myeDhlo2
	rWOdEdd6TEKvWG8MZYCIATj9+oWBmmyCKfXwEDu0neRuYSN+zb6zJr8w2Q8ckdbO7+QalBJHhIq4o
	0vpZpPY1oNCUGxX8E42VCqfm2bSzgb2CBTgzZ3e9wYBEm4vY8k/NQXpebUKH0UhXaTmnAg6Toelgw
	J2c9igQQh35aT/gWta/kTT5MH8ZCipyjuuE289BsDjmfZZo5dhtr3GqGxoZg8ZgoHJQcK/FrD2sMr
	E5dakDW3ypd04ZeB0ppZZzWnQQhmx0KXdAf6GcGFmlozRcl1OAzHJoq8MwLOJsZT4Om1dp8bmpdAN
	/gUh6gSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utYlq-00000002AC4-35pg;
	Tue, 02 Sep 2025 21:42:30 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ut4JK-0000000CdsM-0KiA;
	Mon, 01 Sep 2025 13:11:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Reply-To:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Content-ID:Content-Description;
	bh=xioHQ5KTG+jebQzTOOBaTVLdwwFRjLNCqggcN57Q9EM=; b=aq+mflZasVG2hQiFUYERq/oW+Y
	3rvFpMjYJeqSViuSvJxBe+crzh3bd3pff9XMu1VX8WwCyRFyXa6o1oF1Epo+mh2nfWbMH5UM/Za2i
	eGhwYm1hAzV6F6MKeB2mc2RV/yaKwwYj+FTeSxzwz17Za9GLogk0qieWjRmXwi9xa7jXVuBXaWM1t
	ic7EgnhuoJ6BlQd8XTqWpl6sugCsd6QxWCb+FVRl9r9LqNHdO6ITfYiGr5C3xphm8nBXtbDPv/oN6
	ae83tFyZJ4b8KD3FDJwc6vMLDecH6oWu6Ez19L01AcQMMyGl+BcpvEZRq6pxA/22Gk8FmC/Dv5kmg
	IMlmR4lA==;
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ut4JE-00000003ixr-2QFO;
	Mon, 01 Sep 2025 13:11:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0ED504501F;
	Mon,  1 Sep 2025 13:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3F4DC4CEFA;
	Mon,  1 Sep 2025 13:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756732249;
	bh=VOxu8arS/s7gFRMCG19RKI+wB0Hc+6Kyu4sWG8FSmZ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=j4YsDfs041pcEA4PsPM9Fv3cx+Fety1JSDdn80JTlpQfdfbDx49Pj5d73mfbToakx
	 PgLya/HeSbiEPI6JiRWwnf1/+pAmv8a8iYyHCBp4Ds6IqCe4hIez3MU/eu+hu2SbYz
	 lB4Gfs5Y6gmt4q60PKIgOXRBHP3WM5szwT1cuKL2dPIwcwbo6IwaMAPb7M6vbKuZPg
	 afObqthiKmeuNnWe2LTyybg0Ox7TgWLw5aDYxA3PnhAkUwFQMdAsEPqIaAFdzVpS01
	 mAjgyzCoEp77jX8f+cQSGeAlXuVYIZcMVOt/vaDMeLJVmMQHLoFTN/48ISQ6HnWeAn
	 I5XBnsB1pmvdQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCDDCA0FF0;
	Mon,  1 Sep 2025 13:10:49 +0000 (UTC)
From: Simon Schuster via B4 Relay <devnull+schuster.simon.siemens-energy.com@kernel.org>
Date: Mon, 01 Sep 2025 15:09:53 +0200
Subject: [PATCH v2 4/4] nios2: implement architecture-specific portion of
 sys_clone3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-nios2-implement-clone3-v2-4-53fcf5577d57@siemens-energy.com>
References: <20250901-nios2-implement-clone3-v2-0-53fcf5577d57@siemens-energy.com>
In-Reply-To: <20250901-nios2-implement-clone3-v2-0-53fcf5577d57@siemens-energy.com>
To: Dinh Nguyen <dinguyen@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Kees Cook <kees@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Guo Ren <guoren@kernel.org>, 
 Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 John Johansen <john.johansen@canonical.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Ondrej Mosnacek <omosnace@redhat.com>, 
 Kentaro Takeda <takedakn@nttdata.co.jp>, 
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, 
 Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Brian Cain <bcain@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>, 
 Michal Simek <monstr@monstr.eu>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Jonas Bonn <jonas@southpole.se>, 
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, 
 Stafford Horne <shorne@gmail.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Andreas Larsson <andreas@gaisler.com>, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, 
 Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 cgroups@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, apparmor@lists.ubuntu.com, 
 selinux@vger.kernel.org, linux-alpha@vger.kernel.org, 
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-um@lists.infradead.org, 
 Simon Schuster <schuster.simon@siemens-energy.com>
X-Mailer: b4 0.14.3-dev-2ce6c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756732247; l=2260;
 i=schuster.simon@siemens-energy.com; s=20250818;
 h=from:subject:message-id;
 bh=af84J4YQt0c2u1+xik140Isbk9cuIhCMOLjW6thJwsY=;
 b=d7NLA1iQDxLQGisMH0KtrKIUv8tslRZQ31+BK5A9IfF7XRRqtN0/NtBHPN1763CSVsp/AaVUs
 Xc5SawZJT/gDUL4ePU56689mSaXuGDc8R0/3KXZ7O8sV4jJB/D/Z4M0
X-Developer-Key: i=schuster.simon@siemens-energy.com; a=ed25519;
 pk=PUhOMiSp43aSeRE1H41KApxYOluamBFFiMfKlBjocvo=
X-Endpoint-Received: by B4 Relay for
 schuster.simon@siemens-energy.com/20250818 with auth_id=495
X-Original-From: Simon Schuster <schuster.simon@siemens-energy.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250901_141057_055711_78C3C6D3 
X-CRM114-Status: GOOD (  17.00  )
X-Mailman-Approved-At: Tue, 02 Sep 2025 11:45:36 -0700
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Reply-To: schuster.simon@siemens-energy.com
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Simon Schuster <schuster.simon@siemens-energy.com>

This commit adds the sys_clone3 entry point for nios2. An
architecture-specific wrapper (__sys_clone3) is required to save and
restore additional registers to the kernel stack via SAVE_SWITCH_STACK
and RESTORE_SWITCH_STACK.

Signed-off-by: Simon Schuster <schuster.simon@siemens-energy.com>
---
 arch/nios2/include/asm/syscalls.h | 1 +
 arch/nios2/include/asm/unistd.h   | 2 --
 arch/nios2/kernel/entry.S         | 6 ++++++
 arch/nios2/kernel/syscall_table.c | 1 +
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/nios2/include/asm/syscalls.h b/arch/nios2/include/asm/syscalls.h
index b4d4ed3bf9c8..0e214b0a0ac8 100644
--- a/arch/nios2/include/asm/syscalls.h
+++ b/arch/nios2/include/asm/syscalls.h
@@ -7,6 +7,7 @@
 
 int sys_cacheflush(unsigned long addr, unsigned long len,
 				unsigned int op);
+asmlinkage long __sys_clone3(struct clone_args __user *uargs, size_t size);
 
 #include <asm-generic/syscalls.h>
 
diff --git a/arch/nios2/include/asm/unistd.h b/arch/nios2/include/asm/unistd.h
index 1146e56473c5..213f6de3cf7b 100644
--- a/arch/nios2/include/asm/unistd.h
+++ b/arch/nios2/include/asm/unistd.h
@@ -7,6 +7,4 @@
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SET_GET_RLIMIT
 
-#define __ARCH_BROKEN_SYS_CLONE3
-
 #endif
diff --git a/arch/nios2/kernel/entry.S b/arch/nios2/kernel/entry.S
index 99f0a65e6234..dd40dfd908e5 100644
--- a/arch/nios2/kernel/entry.S
+++ b/arch/nios2/kernel/entry.S
@@ -403,6 +403,12 @@ ENTRY(sys_clone)
 	addi    sp, sp, 4
 	RESTORE_SWITCH_STACK
 	ret
+/* long syscall(SYS_clone3, struct clone_args *cl_args, size_t size); */
+ENTRY(__sys_clone3)
+	SAVE_SWITCH_STACK
+	call	sys_clone3
+	RESTORE_SWITCH_STACK
+	ret
 
 ENTRY(sys_rt_sigreturn)
 	SAVE_SWITCH_STACK
diff --git a/arch/nios2/kernel/syscall_table.c b/arch/nios2/kernel/syscall_table.c
index 434694067d8f..c99818aac9e1 100644
--- a/arch/nios2/kernel/syscall_table.c
+++ b/arch/nios2/kernel/syscall_table.c
@@ -13,6 +13,7 @@
 #define __SYSCALL_WITH_COMPAT(nr, native, compat)        __SYSCALL(nr, native)
 
 #define sys_mmap2 sys_mmap_pgoff
+#define sys_clone3 __sys_clone3
 
 void *sys_call_table[__NR_syscalls] = {
 	[0 ... __NR_syscalls-1] = sys_ni_syscall,

-- 
2.39.5



