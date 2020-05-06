Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWOaB-00067p-6C
 for linux-um@lists.infradead.org; Wed, 06 May 2020 18:15:51 +0000
Date: Wed, 6 May 2020 20:15:43 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 15/15] x86: use non-set_fs based maccess routines
Message-ID: <20200506181543.GA7873@lst.de>
References: <20200506062223.30032-1-hch@lst.de>
 <20200506062223.30032-16-hch@lst.de>
 <CAHk-=wi6E5z_aKr9NX+QcEJqJvSyrDbO3ypPugxstcPV5EPSMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHk-=wi6E5z_aKr9NX+QcEJqJvSyrDbO3ypPugxstcPV5EPSMQ@mail.gmail.com>
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

On Wed, May 06, 2020 at 10:51:51AM -0700, Linus Torvalds wrote:
> My private tree no longer has those __get/put_user_size() things,
> because "unsafe_get/put_user()" is the only thing that remains with my
> conversion to asm goto.
> 
> And we're actively trying to get rid of the whole __get_user() mess.
> Admittedly "__get_user_size()" is just the internal helper that
> doesn't have the problem, but it really is an internal helper for a
> legacy operation, and the new op that uses it is that
> "unsafe_get_user()".
> 
> Also, because you use __get_user_size(), you then have to duplicate
> the error handling logic that we already have in unsafe_get_user().
> 
> IOW - is there some reason why you didn't just make these use
> "unsafe_get/put_user()" directly, and avoid both of those issues?

That was the first prototype, and or x86 it works great, just the
__user cases in maccess.c are a little ugly.  And they point to
the real problem - for architectures like sparc and s390 that use
an entirely separate address space for the kernel vs userspace
I dont think just use unsafe_{get,put}_user will work, as they need
different instructions.

Btw, where is you magic private tree and what is the plan for it?

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

