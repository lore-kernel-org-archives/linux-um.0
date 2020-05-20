Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbMfD-0004pc-HJ
 for linux-um@lists.infradead.org; Wed, 20 May 2020 11:13:33 +0000
Date: Wed, 20 May 2020 13:13:24 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 13/20] maccess: always use strict semantics for
 probe_kernel_read
Message-ID: <20200520111324.GA16488@lst.de>
References: <20200519134449.1466624-1-hch@lst.de>
 <20200519134449.1466624-14-hch@lst.de>
 <20200520201126.f37d3b1e46355199216404e2@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200520201126.f37d3b1e46355199216404e2@kernel.org>
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

On Wed, May 20, 2020 at 08:11:26PM +0900, Masami Hiramatsu wrote:
> > -		ret = probe_kernel_read(&c, (u8 *)addr + len, 1);
> > +		if (IS_ENABLED(CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE) &&
> > +		    (unsigned long)addr < TASK_SIZE) {
> > +			ret = probe_user_read(&c,
> > +				(__force u8 __user *)addr + len, 1);
> > +		} else {
> > +			ret = probe_kernel_read(&c, (u8 *)addr + len, 1);
> > +		}
> >  		len++;
> >  	} while (c && ret == 0 && len < MAX_STRING_SIZE);
> 
> To avoid redundant check in the loop, we can use strnlen_user_nofault() out of
> the loop. Something like below.

Yes, I've done something very similar in response to Linus' comment (just
using an ifdef instead).

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

