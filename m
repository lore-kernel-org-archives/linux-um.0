Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from [2002:c35c:fd02::1] (helo=ZenIV.linux.org.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZ0nc-0002dG-Nt
 for linux-um@lists.infradead.org; Wed, 13 May 2020 23:28:30 +0000
Date: Thu, 14 May 2020 00:28:16 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 11/18] maccess: remove strncpy_from_unsafe
Message-ID: <20200513232816.GZ23230@ZenIV.linux.org.uk>
References: <20200513160038.2482415-1-hch@lst.de>
 <20200513160038.2482415-12-hch@lst.de>
 <CAHk-=wj=u+nttmd1huNES2U=9nePtmk7WgR8cMLCYS8wc=rhdA@mail.gmail.com>
 <20200513192804.GA30751@lst.de>
 <0c1a7066-b269-9695-b94a-bb5f4f20ebd8@iogearbox.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0c1a7066-b269-9695-b94a-bb5f4f20ebd8@iogearbox.net>
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
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, linux-parisc@vger.kernel.org, Netdev <netdev@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, linux-um <linux-um@lists.infradead.org>, Alexei Starovoitov <ast@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Masami Hiramatsu <mhiramat@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>

On Thu, May 14, 2020 at 12:36:28AM +0200, Daniel Borkmann wrote:

> > So on say s390 TASK_SIZE_USUALLy is (-PAGE_SIZE), which means we'd alway
> > try the user copy first, which seems odd.
> > 
> > I'd really like to here from the bpf folks what the expected use case
> > is here, and if the typical argument is kernel or user memory.
> 
> It's used for both. Given this is enabled on pretty much all program types, my
> assumption would be that usage is still more often on kernel memory than user one.

Then it needs an argument telling it which one to use.  Look at sparc64.
Or s390.  Or parisc.  Et sodding cetera.

The underlying model is that the kernel lives in a separate address space.
Yes, on x86 it's actually sharing the page tables with userland, but that's
not universal.  The same address can be both a valid userland one _and_
a valid kernel one.  You need to tell which one do you want.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

