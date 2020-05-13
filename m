Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYxT2-0004wv-Ac
 for linux-um@lists.infradead.org; Wed, 13 May 2020 19:55:01 +0000
Date: Wed, 13 May 2020 21:54:56 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 14/18] maccess: allow architectures to provide kernel
 probing directly
Message-ID: <20200513195456.GA31096@lst.de>
References: <20200513160038.2482415-1-hch@lst.de>
 <20200513160038.2482415-15-hch@lst.de>
 <CAHk-=wgzXqgYQQt2NCdZTtxLmV1FV1nbZ_gKw0O_mRkXZj57zg@mail.gmail.com>
 <20200513194003.GA31028@lst.de>
 <CAHk-=whtGLxezkdMP6+859LFDgb++6dgYa6Vrc=zJ9+GB7UMFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHk-=whtGLxezkdMP6+859LFDgb++6dgYa6Vrc=zJ9+GB7UMFQ@mail.gmail.com>
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

On Wed, May 13, 2020 at 12:48:54PM -0700, Linus Torvalds wrote:
> Looking at the current users of "probe_kernel_read()", it looks like
> it's almost mostly things that just want a single byte or word.
> 
> It's not 100% that: we definitely do several things that want the
> "copy" semantics vs the "get" semantics: on the x86 side we have
> CALL_INSN_SIZE and MAX_INSN_SIZE, and the ldttss_desc.
> 
> But the bulk of them do seem to be a single value.
> 
> I don't know if performance really matters here, but to me the whole
> "most users seem to want to read a single value" is what makes me
> think that maybe that should be the primary model, rather than have
> the copy model be the primary one and then we implement the single
> value case (badly) with a copy.
> 
> It probably doesn't matter that much. I certainly wouldn't hold this
> series up over it - it can be a future thing.

I can make the get_kernel_nofault implementation suck a little less :)

Note that the arch helper (we could call it unsafe_get_kernel_nofault)
we still need to have a pagefault_disable / pagefault_enable pair
around the calls.  So maybe keep the get_kernel_nofault interface
as-is (without the goto label), and prepare the arch helpers for
being used similar to unsafe_get_user once all architectures are
converted.  And I can throw in a few patches to convert callers
from the copy semantics to the get semantics.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

