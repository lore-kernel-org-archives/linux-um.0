Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWO99-0001HZ-Fr
 for linux-um@lists.infradead.org; Wed, 06 May 2020 17:47:53 +0000
Date: Wed, 6 May 2020 19:47:47 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 08/15] maccess: rename strnlen_unsafe_user to
 strnlen_user_unsafe
Message-ID: <20200506174747.GA7549@lst.de>
References: <20200506062223.30032-1-hch@lst.de>
 <20200506062223.30032-9-hch@lst.de>
 <CAHk-=wj3T6u_kj8r9f3aGXCjuyN210_gJC=AXPFm9=wL-dGALA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHk-=wj3T6u_kj8r9f3aGXCjuyN210_gJC=AXPFm9=wL-dGALA@mail.gmail.com>
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

On Wed, May 06, 2020 at 10:44:15AM -0700, Linus Torvalds wrote:
> So while I think using a consistent convention is good, and it's true
> that there is a difference in the convention between the two cases
> ("unsafe" at the beginning vs end), one of them is actually about the
> safety and security of the operation (and we have automated logic
> these days to verify it on x86), the other has nothing to do with
> "safety", really.
> 
> Would it be better to standardize around a "probe_xyz()" naming?

So:

  probe_strncpy, probe_strncpy_user, probe_strnlen_user?

Sounds weird, but at least it is consistent.

> Or perhaps a "xyz_nofault()" naming?

That sounds a little better:

   strncpy_nofault, strncpy_user_nofault, strnlen_user_nofault

> I realize this is nit-picky, and I think the patch series as-is is
> already an improvement, but I do think our naming in this area is
> really quite bad.

Always open for improvements :)

> The fact that we have "probe_kernel_read()" but then
> "strncpy_from_user_unsafe()" for the _same_ conceptual difference
> really tells me how inconsistent the naming for these kinds of "we
> can't take page faults" is. No?

True.  If we wanted to do _nofaul, what would the basic read/write
versions be?

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

