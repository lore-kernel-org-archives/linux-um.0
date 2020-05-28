Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1je6po-0003Fy-JH
 for linux-um@lists.infradead.org; Thu, 28 May 2020 00:55:49 +0000
Date: Wed, 27 May 2020 17:55:47 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 10/23] maccess: unify the probe kernel arch hooks
Message-Id: <20200527175547.0260fb90d76734d4e0f56def@linux-foundation.org>
In-Reply-To: <20200521152301.2587579-11-hch@lst.de>
References: <20200521152301.2587579-1-hch@lst.de>
 <20200521152301.2587579-11-hch@lst.de>
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

On Thu, 21 May 2020 17:22:48 +0200 Christoph Hellwig <hch@lst.de> wrote:

> Currently architectures have to override every routine that probes
> kernel memory, which includes a pure read and strcpy, both in strict
> and not strict variants.  Just provide a single arch hooks instead to
> make sure all architectures cover all the cases.

Fix a buildo.

--- a/arch/x86/mm/maccess.c~maccess-unify-the-probe-kernel-arch-hooks-fix
+++ a/arch/x86/mm/maccess.c
@@ -29,6 +29,6 @@ bool probe_kernel_read_allowed(const voi
 {
 	if (!strict)
 		return true;
-	return (unsigned long)vaddr >= TASK_SIZE_MAX;
+	return (unsigned long)unsafe_src >= TASK_SIZE_MAX;
 }
 #endif
_


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

