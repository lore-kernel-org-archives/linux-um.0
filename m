Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jahO6-0000yZ-O3
 for linux-um@lists.infradead.org; Mon, 18 May 2020 15:09:08 +0000
Date: Mon, 18 May 2020 17:09:03 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 14/18] maccess: allow architectures to provide kernel
 probing directly
Message-ID: <20200518150903.GD8871@lst.de>
References: <20200513160038.2482415-1-hch@lst.de>
 <20200513160038.2482415-15-hch@lst.de>
 <20200516124259.5b68a4e1d4670efa1397a1e0@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200516124259.5b68a4e1d4670efa1397a1e0@kernel.org>
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
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-parisc@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, x86@kernel.org, linux-um@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>

On Sat, May 16, 2020 at 12:42:59PM +0900, Masami Hiramatsu wrote:
> > Provide alternative versions of probe_kernel_read, probe_kernel_write
> > and strncpy_from_kernel_unsafe that don't need set_fs magic, but instead
> > use arch hooks that are modelled after unsafe_{get,put}_user to access
> > kernel memory in an exception safe way.
> 
> This patch seems to introduce new implementation of probe_kernel_read/write()
> and strncpy_from_kernel_unsafe(), but also drops copy_from/to_kernel_nofault()
> and strncpy_from_kernel_nofault() if HAVE_ARCH_PROBE_KERNEL is defined.
> In the result, this cause a link error with BPF and kprobe events.

That was just a bug as I didn't commit the changes to switch everything
to _nofault and remove _unsafe entirely, sorry.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

