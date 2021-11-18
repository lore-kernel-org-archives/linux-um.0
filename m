Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Thu, 18 Nov 2021 17:00:58 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [tip:x86/core 1/1] arch/x86/um/../lib/csum-partial_64.c:98:12:
 error: implicit declaration of function 'load_unaligned_zeropad'
Message-ID: <YZZ4upqWGMOY+r56@hirez.programming.kicks-ass.net>
References: <202111180219.YkyoBMpf-lkp@intel.com>
 <CANn89iJfh+x-s4GtWJcyRFpMmSvvyq-r1TGV4sDLXy3F50zD6w@mail.gmail.com>
 <CANn89iJj4zeNUiXCmG=rSejbHAwPhBEPKUv1tPL9ig=e4vg7pQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANn89iJj4zeNUiXCmG=rSejbHAwPhBEPKUv1tPL9ig=e4vg7pQ@mail.gmail.com>
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
To: Eric Dumazet <edumazet@google.com>
Cc: kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org, linux-kernel@vger.kernel.org, x86@kernel.org, Alexander Duyck <alexanderduyck@fb.com>, linux-um@lists.infradead.org


On Wed, Nov 17, 2021 at 11:40:35AM -0800, Eric Dumazet wrote:
> On Wed, Nov 17, 2021 at 10:55 AM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Wed, Nov 17, 2021 at 10:46 AM kernel test robot <lkp@intel.com> wrote:
> > >
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
> > > head:   d31c3c683ee668ba5d87c0730610442fd672525f
> > > commit: d31c3c683ee668ba5d87c0730610442fd672525f [1/1] x86/csum: Rewrite/optimize csum_partial()
> > > config: um-x86_64_defconfig (attached as .config)
> > > compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> > > reproduce (this is a W=1 build):
> > >         # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=d31c3c683ee668ba5d87c0730610442fd672525f
> > >         git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
> > >         git fetch --no-tags tip x86/core
> > >         git checkout d31c3c683ee668ba5d87c0730610442fd672525f
> > >         # save the attached .config to linux build tree
> > >         make W=1 ARCH=um SUBARCH=x86_64
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > All errors (new ones prefixed by >>):
> > >
> > >    arch/x86/um/../lib/csum-partial_64.c: In function 'csum_partial':
> > > >> arch/x86/um/../lib/csum-partial_64.c:98:12: error: implicit declaration of function 'load_unaligned_zeropad' [-Werror=implicit-function-declaration]
> > >       98 |   trail = (load_unaligned_zeropad(buff) << shift) >> shift;
> > >          |            ^~~~~~~~~~~~~~~~~~~~~~
> > >    cc1: some warnings being treated as errors
> > >
> > >
> >
> > Hmmm... it seems we need to guard this with CONFIG_DCACHE_WORD_ACCESS ?
> 
> Perhaps something like the following ?

Dear um folks, is this indeed the best solution? It's a bit sad to have
to add this to x86_64, but if that's the way it is...

> 
> diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
> index 5ec35626945b6db2f7f41c6d46d5e422810eac46..d419b9345d6dba2e924887671bc6f11c3e17ebd7
> 100644
> --- a/arch/x86/lib/csum-partial_64.c
> +++ b/arch/x86/lib/csum-partial_64.c
> @@ -91,12 +91,23 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
>                         : "memory");
>                 buff += 8;
>         }
> -       if (len & 7) {
> -               unsigned int shift = (8 - (len & 7)) * 8;
> +       len &= 7;
> +       if (len) {
>                 unsigned long trail;
> +#ifndef CONFIG_DCACHE_WORD_ACCESS
> +               union {
> +                       unsigned long   ulval;
> +                       u8              bytes[sizeof(long)];
> +               } v;
> 
> -               trail = (load_unaligned_zeropad(buff) << shift) >> shift;
> +               v.ulval = 0;
> +               memcpy(v.bytes, buff, len);
> +               trail = v.ulval;
> +#else
> +               unsigned int shift = (sizeof(long) - len) * BITS_PER_BYTE;
> 
> +               trail = (load_unaligned_zeropad(buff) << shift) >> shift;
> +#endif
>                 asm("addq %[trail],%[res]\n\t"
>                     "adcq $0,%[res]"
>                         : [res] "+r" (temp64)

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

