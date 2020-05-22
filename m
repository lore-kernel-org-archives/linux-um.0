Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbvS5-0008Ca-Ux
 for linux-um@lists.infradead.org; Fri, 22 May 2020 00:22:19 +0000
Date: Fri, 22 May 2020 09:22:11 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: clean up and streamline probe_kernel_* and friends v4
Message-Id: <20200522092211.dd45d126b7598c4bf2182859@kernel.org>
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
Cc: linux-parisc@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, x86@kernel.org, linux-um@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, bpf@vger.kernel.org

On Thu, 21 May 2020 17:22:38 +0200
Christoph Hellwig <hch@lst.de> wrote:

> Hi all,
> 
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
> 
> Changes since v3:
>  - cleanup how bpf and trace_kprobe perform the TASK_SIZE checks
>  - remove the unused dst argument to probe_kernel_read_allowed
>  - document the -ERANGE return value

This series looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

for this series.

Thank you!

> 
> Changes since v2:
>  - rebased on 5.7-rc6 with the bpf trace format string changes
>  - rename arch_kernel_read to __get_kernel_nofault and arch_kernel_write
>    to __put_kernel_nofault
>  - clean up the tracers to only allowd "mixed" reads when the kernel
>    has non-overlapping address spaces


-- 
Masami Hiramatsu <mhiramat@kernel.org>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

