Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jav4s-0000B3-CI
 for linux-um@lists.infradead.org; Tue, 19 May 2020 05:46:11 +0000
Date: Tue, 19 May 2020 07:46:06 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 10/18] maccess: unify the probe kernel arch hooks
Message-ID: <20200519054606.GA23853@lst.de>
References: <20200513160038.2482415-1-hch@lst.de>
 <20200513160038.2482415-11-hch@lst.de>
 <20200514101318.1c14647e41b7038b99b91fcd@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200514101318.1c14647e41b7038b99b91fcd@kernel.org>
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

On Thu, May 14, 2020 at 10:13:18AM +0900, Masami Hiramatsu wrote:
> > +		bool strict)
> >  {
> >  	long ret;
> >  	mm_segment_t old_fs = get_fs();
> >  
> > +	if (!probe_kernel_read_allowed(dst, src, size, strict))
> > +		return -EFAULT;
> 
> Could you make this return -ERANGE instead of -EFAULT so that
> the caller can notice that the address might be user space?

That is clearly a behavior change, so I don't want to mix it into
this patch.  But I can add it as another patch at the end.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

