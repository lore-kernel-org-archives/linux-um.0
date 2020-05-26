Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jdSpv-0001k9-St
 for linux-um@lists.infradead.org; Tue, 26 May 2020 06:13:17 +0000
Date: Tue, 26 May 2020 08:13:09 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: clean up and streamline probe_kernel_* and friends v4
Message-ID: <20200526061309.GA15549@lst.de>
References: <20200521152301.2587579-1-hch@lst.de>
 <20200525151912.34b20b978617e2893e484fa3@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200525151912.34b20b978617e2893e484fa3@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-parisc@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, x86@kernel.org, linux-um@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Masami Hiramatsu <mhiramat@kernel.org>, bpf@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>

On Mon, May 25, 2020 at 03:19:12PM -0700, Andrew Morton wrote:
> hm.  Applying linux-next to this series generates a lot of rejects against
> powerpc:
> 
> -rw-rw-r-- 1 akpm akpm  493 May 25 15:06 arch/powerpc/kernel/kgdb.c.rej
> -rw-rw-r-- 1 akpm akpm 6461 May 25 15:06 arch/powerpc/kernel/trace/ftrace.c.rej
> -rw-rw-r-- 1 akpm akpm  447 May 25 15:06 arch/powerpc/mm/fault.c.rej
> -rw-rw-r-- 1 akpm akpm  623 May 25 15:06 arch/powerpc/perf/core-book3s.c.rej
> -rw-rw-r-- 1 akpm akpm 1408 May 25 15:06 arch/riscv/kernel/patch.c.rej
> 
> the arch/powerpc/kernel/trace/ftrace.c ones aren't very trivial.
> 
> It's -rc7.  Perhaps we should park all this until 5.8-rc1?

As this is a pre-condition for the set_fs removal I'd really like to
get the actual changes in.  All these conflicts seem to be about the
last three cleanup patches just doing renaming, so can we just skip
those three for now?  Then we can do the rename right after 5.8-rc1
when we have the least chances for conflicts.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

