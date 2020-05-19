Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jav8m-00031x-Eu
 for linux-um@lists.infradead.org; Tue, 19 May 2020 05:50:13 +0000
Date: Tue, 19 May 2020 07:50:09 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: clean up and streamline probe_kernel_* and friends v2
Message-ID: <20200519055009.GB23853@lst.de>
References: <20200513160038.2482415-1-hch@lst.de>
 <10c58b09-5ece-e49f-a7c8-2aa6dfd22fb4@iogearbox.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <10c58b09-5ece-e49f-a7c8-2aa6dfd22fb4@iogearbox.net>
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
Cc: bpf@vger.kernel.org, linux-parisc@vger.kernel.org, netdev@vger.kernel.org, x86@kernel.org, linux-um@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Masami Hiramatsu <mhiramat@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>

On Thu, May 14, 2020 at 01:04:38AM +0200, Daniel Borkmann wrote:
> Aside from comments on list, the series looks reasonable to me. For BPF
> the bpf_probe_read() helper would be slightly penalized for probing user
> memory given we now test on copy_from_kernel_nofault() first and if that
> fails only then fall back to copy_from_user_nofault(), but it seems
> small enough that it shouldn't matter too much and aside from that we have
> the newer bpf_probe_read_kernel() and bpf_probe_read_user() anyway that
> BPF progs should use instead, so I think it's okay.
>
> For patch 14 and patch 15, do you roughly know the performance gain with
> the new probe_kernel_read_loop() + arch_kernel_read() approach?

I don't think there should be any measurable difference in performance
for typical use cases.  We'll save the stac/clac pair, but that's it.
The real eason is to avoid that stac/clac pair that opens up a window
for explots, and as a significant enabler for killing of set_fs based 
address limit overrides entirely.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

