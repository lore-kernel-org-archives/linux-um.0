Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC253CA1017
	for <linux-um@archiver.kernel.org>; Tue,  2 Sep 2025 21:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D06UuwjAYlV6l7iTncZwN2SfO36CQk7GREFp9cWnrbY=; b=2LR0SSoXCFWTeYkj+YvFoTtEoi
	zGodKwu2NMzgEV4tGcoNXXBVoVYzbT5BWuh48+Y7vOtEbjA8QKjRP31qSFbBdNZOiOIY3odtn69Gs
	XFOdN1qD9RIl5ozlyMJdZQ7IK42TFiYsDyDlXhehKSdpeqbWMzofQ5WQzEiSfVr1ftDaB/2BBnmS+
	TI4Qo202Lt8KReqTzRVj9e9wt6IQ6sX/rAhwk/y1BIKyOb77JyKIUu5W5iETe22ltRz7NDPnxW3F6
	2aUzuW0OSwRnQiH7J+PYfkHPnZPs3GNBSowepRYlnrzq2vgSPNGHPypeDNUN/UVahFIH28UGEw2Pf
	UeznwsWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utYlt-00000002AGy-1uBC;
	Tue, 02 Sep 2025 21:42:33 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ut4nl-0000000Cizh-3LZI;
	Mon, 01 Sep 2025 13:42:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7EA9544C2A;
	Mon,  1 Sep 2025 13:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2A3C4CEF0;
	Mon,  1 Sep 2025 13:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756734149;
	bh=Vh7XUBI8fbBk4XZ8pKOtZH1UfNJDpJTXo419bu2F3VE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hhAgv3jysX69gBwri906yWypXEK80NcNcU75ZV9/QeXQCy7l2f36k4byfNVTER6IP
	 gOpTcCFplnwo778jgs8p6iIv5w82lNMr1NdsMRGJMrKmcMxP4YY2DKw+dekKbGSucF
	 fH1UC9E5PgUSkFcL53l8SZJBBuh5k12ZnrsQltX79STLRHqZnRwbCiiL2r1trnqoDx
	 puTp0teu7LJmcMXEaHizKLVFBrc6SbxJk1xEnU8p4L+3jrFGOH2GOvXFX8s+j/Uzcc
	 iESOxfINPv0beoEDy4YTocStDSjRMNPUi5KjJ3O7gh5nCTPwxK3fbka9qE414MrABB
	 Q6ziiIx0FS2KA==
From: Christian Brauner <brauner@kernel.org>
To: Simon Schuster <schuster.simon@siemens-energy.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org, linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-perf-users@vger.kernel.org, apparmor@lists.ubuntu.com, selinux@vger.kernel.org, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, stable@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Kees Cook <kees@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Guo Ren <guoren@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>, Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <mhiramat@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, John Johansen <john.johansen@canonical.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, Kentaro Takeda <takedakn@nttdata.co.jp>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Andreas Larsson <andreas@gaisler.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v2 0/4] nios2: Add architecture support for clone3
Date: Mon,  1 Sep 2025 15:41:21 +0200
Message-ID: <20250901-sauer-stunk-49def0170f7d@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901-nios2-implement-clone3-v2-0-53fcf5577d57@siemens-energy.com>
References: <20250901-nios2-implement-clone3-v2-0-53fcf5577d57@siemens-energy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1648; i=brauner@kernel.org; h=from:subject:message-id; bh=Vh7XUBI8fbBk4XZ8pKOtZH1UfNJDpJTXo419bu2F3VE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRsXbQgjNu70HTe/oL9c9q1am5UpWv3Rf4/axBS2d225 DLTetc9HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNJDGb4796daOqUVCMcef3h SZ6HDAFLrq8xmcSxzTOQKT+CvTO3n+G/d83ztvwDXH+ZHPU+vLlcvOafQ5/X9C+bSnabHoy/7bC TBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250901_064229_879470_860971D3 
X-CRM114-Status: GOOD (  18.95  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Mon, 01 Sep 2025 15:09:49 +0200, Simon Schuster wrote:
> This series adds support for the clone3 system call to the nios2
> architecture. This addresses the build-time warning "warning: clone3()
> entry point is missing, please fix" introduced in 505d66d1abfb9
> ("clone3: drop __ARCH_WANT_SYS_CLONE3 macro"). The implementation passes
> the relevant clone3 tests of kselftest when applied on top of
> next-20250815:
> 
> [...]

Seems fine to me. Thanks for fixing this.

---

Applied to the kernel-6.18.clone3 branch of the vfs/vfs.git tree.
Patches in the kernel-6.18.clone3 branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: kernel-6.18.clone3

[1/4] copy_sighand: Handle architectures where sizeof(unsigned long) < sizeof(u64)
      https://git.kernel.org/vfs/vfs/c/04ff48239f46
[2/4] copy_process: pass clone_flags as u64 across calltree
      https://git.kernel.org/vfs/vfs/c/5b38576cb8d3
[3/4] arch: copy_thread: pass clone_flags as u64
      https://git.kernel.org/vfs/vfs/c/04e760acd97f
[4/4] nios2: implement architecture-specific portion of sys_clone3
      https://git.kernel.org/vfs/vfs/c/d7109d2a2358

