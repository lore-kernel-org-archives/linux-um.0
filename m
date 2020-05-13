Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYxEc-0003KO-OM
 for linux-um@lists.infradead.org; Wed, 13 May 2020 19:40:08 +0000
Date: Wed, 13 May 2020 21:40:03 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 14/18] maccess: allow architectures to provide kernel
 probing directly
Message-ID: <20200513194003.GA31028@lst.de>
References: <20200513160038.2482415-1-hch@lst.de>
 <20200513160038.2482415-15-hch@lst.de>
 <CAHk-=wgzXqgYQQt2NCdZTtxLmV1FV1nbZ_gKw0O_mRkXZj57zg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHk-=wgzXqgYQQt2NCdZTtxLmV1FV1nbZ_gKw0O_mRkXZj57zg@mail.gmail.com>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-parisc@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, Netdev <netdev@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, linux-um <linux-um@lists.infradead.org>, Alexei Starovoitov <ast@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>

On Wed, May 13, 2020 at 12:36:18PM -0700, Linus Torvalds wrote:
> > +               arch_kernel_read(dst, src, type, err_label);            \
> 
> I'm wondering if
> 
>  (a) we shouldn't expose this as an interface in general

We do export something like it, currently it is called
probe_kernel_address, and the last patch renames it to
get_kernel_nofault.  However it is implemented as a wrapper
around probe_kernel_address / copy_from_kernel_nofault and thus
not quite as efficient and without the magic goto semantics.

>  (b) it wouldn't be named differently..

It probably should with all the renaming..

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

