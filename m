Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jb4sp-0007mf-WA
 for linux-um@lists.infradead.org; Tue, 19 May 2020 16:14:25 +0000
Date: Tue, 19 May 2020 18:14:18 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 11/20] bpf: factor out a bpf_trace_copy_string helper
Message-ID: <20200519161418.GA26545@lst.de>
References: <20200519134449.1466624-1-hch@lst.de>
 <20200519134449.1466624-12-hch@lst.de>
 <CAHk-=wjm3HQy_awVX-WyF6KrSuE1pcFRaNX_XhiLKkBUFUZBtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHk-=wjm3HQy_awVX-WyF6KrSuE1pcFRaNX_XhiLKkBUFUZBtQ@mail.gmail.com>
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

On Tue, May 19, 2020 at 09:07:55AM -0700, Linus Torvalds wrote:
> On Tue, May 19, 2020 at 6:45 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > +       switch (fmt_ptype) {
> > +       case 's':
> > +#ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
> > +               strncpy_from_unsafe(buf, unsafe_ptr, bufsz);
> > +               break;
> > +#endif
> > +       case 'k':
> > +               strncpy_from_kernel_nofault(buf, unsafe_ptr, bufsz);
> > +               break;
> 
> That 's' case needs a "fallthrough;" for the overlapping case,
> methinks. Otherwise you'll get warnings.

I don't think we need it as the case of

	case 'a':
	case 'b':
		do_stuff();
		break;

has always been fine even with the fallthough warnings.  And the
rest of the stuff gets removed by cpp..

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

