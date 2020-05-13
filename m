Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from www62.your-server.de ([213.133.104.62])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZ0Qd-0004T5-7l
 for linux-um@lists.infradead.org; Wed, 13 May 2020 23:04:44 +0000
Subject: Re: clean up and streamline probe_kernel_* and friends v2
References: <20200513160038.2482415-1-hch@lst.de>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <10c58b09-5ece-e49f-a7c8-2aa6dfd22fb4@iogearbox.net>
Date: Thu, 14 May 2020 01:04:38 +0200
MIME-Version: 1.0
In-Reply-To: <20200513160038.2482415-1-hch@lst.de>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Christoph Hellwig <hch@lst.de>, x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-parisc@vger.kernel.org, netdev@vger.kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org

On 5/13/20 6:00 PM, Christoph Hellwig wrote:
> Hi all,
> 
> this series start cleaning up the safe kernel and user memory probing
> helpers in mm/maccess.c, and then allows architectures to implement
> the kernel probing without overriding the address space limit and
> temporarily allowing access to user memory.  It then switches x86
> over to this new mechanism by reusing the unsafe_* uaccess logic.
> 
> This version also switches to the saner copy_{from,to}_kernel_nofault
> naming suggested by Linus.
> 
> I kept the x86 helprs as-is without calling unsage_{get,put}_user as
> that avoids a number of hard to trace casts, and it will still work
> with the asm-goto based version easily.

Aside from comments on list, the series looks reasonable to me. For BPF
the bpf_probe_read() helper would be slightly penalized for probing user
memory given we now test on copy_from_kernel_nofault() first and if that
fails only then fall back to copy_from_user_nofault(), but it seems
small enough that it shouldn't matter too much and aside from that we have
the newer bpf_probe_read_kernel() and bpf_probe_read_user() anyway that
BPF progs should use instead, so I think it's okay.

For patch 14 and patch 15, do you roughly know the performance gain with
the new probe_kernel_read_loop() + arch_kernel_read() approach?

Thanks,
Daniel

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

