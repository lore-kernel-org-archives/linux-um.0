Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jb5JN-0008Ew-OI
 for linux-um@lists.infradead.org; Tue, 19 May 2020 16:41:51 +0000
Date: Tue, 19 May 2020 18:41:46 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 12/20] maccess: remove strncpy_from_unsafe
Message-ID: <20200519164146.GA28313@lst.de>
References: <20200519134449.1466624-1-hch@lst.de>
 <20200519134449.1466624-13-hch@lst.de>
 <CAHk-=whE_C2JF0ywF09iMBWtquEfMM3aSxCeLrb5S75EdHr1JA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHk-=whE_C2JF0ywF09iMBWtquEfMM3aSxCeLrb5S75EdHr1JA@mail.gmail.com>
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

On Tue, May 19, 2020 at 09:25:57AM -0700, Linus Torvalds wrote:
> On Tue, May 19, 2020 at 6:45 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > +       if (IS_ENABLED(CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE) &&
> > +           compat && (unsigned long)unsafe_ptr < TASK_SIZE)
> > +               ret = strncpy_from_user_nofault(dst, user_ptr, size);
> > +       else
> > +               ret = strncpy_from_kernel_nofault(dst, unsafe_ptr, size);
> 
> These conditionals are completely illegible.

I had a lot of folks complaining about things like:

#ifdef CONFIG_FOO
	if (foo)
		do_stuff();
	else
#endif
		do_something_else();

which I personally don't mind at all, so I switched to this style.

>   static long bpf_strncpy_from_legacy(void *dest, const void
> *unsafe_ptr, long size, bool legacy)
>   {
>   #ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>         if (legacy && addr < TASK_SIZE)
>             return strncpy_from_user_nofault(dst, (const void __user
> *) unsafe_ptr, size);
>   #endif
> 
>         return strncpy_from_kernel_nofault(dst, unsafe_ptr, size);
>   }
> 
> and then you'd just use
> 
>         if (bpf_strncpy_from_unsafe(dst, unsafe_ptr, size, compat) < 0)
>                 memset(dst, 0, size);
> 
> and avoid any complicated conditionals, goto's, and make the code much
> easier to understand thanks to having a big comment about the legacy
> case.

Sure.

> In fact, separately I'd probably want that "compat" naming to be
> scrapped entirely in that file.

Not my choice..  Maybe Daniel has a recommendation of what to change
there, but I'd love to not have to deal with that renaming as well
in this series.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

