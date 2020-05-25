Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jdLRH-0007NO-1o
 for linux-um@lists.infradead.org; Mon, 25 May 2020 22:19:20 +0000
Date: Mon, 25 May 2020 15:19:12 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: clean up and streamline probe_kernel_* and friends v4
Message-Id: <20200525151912.34b20b978617e2893e484fa3@linux-foundation.org>
In-Reply-To: <20200521152301.2587579-1-hch@lst.de>
References: <20200521152301.2587579-1-hch@lst.de>
Mime-Version: 1.0
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
To: Christoph Hellwig <hch@lst.de>
Cc: Daniel Borkmann <daniel@iogearbox.net>, linux-parisc@vger.kernel.org, netdev@vger.kernel.org, x86@kernel.org, linux-um@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Masami Hiramatsu <mhiramat@kernel.org>, bpf@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, 21 May 2020 17:22:38 +0200 Christoph Hellwig <hch@lst.de> wrote:

> this series start cleaning up the safe kernel and user memory probing
> helpers in mm/maccess.c, and then allows architectures to implement
> the kernel probing without overriding the address space limit and
> temporarily allowing access to user memory.  It then switches x86
> over to this new mechanism by reusing the unsafe_* uaccess logic.
> 
> This version also switches to the saner copy_{from,to}_kernel_nofault
> naming suggested by Linus.
> 
> I kept the x86 helpers as-is without calling unsage_{get,put}_user as
> that avoids a number of hard to trace casts, and it will still work
> with the asm-goto based version easily.

hm.  Applying linux-next to this series generates a lot of rejects against
powerpc:

-rw-rw-r-- 1 akpm akpm  493 May 25 15:06 arch/powerpc/kernel/kgdb.c.rej
-rw-rw-r-- 1 akpm akpm 6461 May 25 15:06 arch/powerpc/kernel/trace/ftrace.c.rej
-rw-rw-r-- 1 akpm akpm  447 May 25 15:06 arch/powerpc/mm/fault.c.rej
-rw-rw-r-- 1 akpm akpm  623 May 25 15:06 arch/powerpc/perf/core-book3s.c.rej
-rw-rw-r-- 1 akpm akpm 1408 May 25 15:06 arch/riscv/kernel/patch.c.rej

the arch/powerpc/kernel/trace/ftrace.c ones aren't very trivial.

It's -rc7.  Perhaps we should park all this until 5.8-rc1?

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

