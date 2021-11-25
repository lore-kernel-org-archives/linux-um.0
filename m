Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mq8Y2-006XZt-6B
 for linux-um@lists.infradead.org; Thu, 25 Nov 2021 06:47:59 +0000
Received: by mail-pj1-x1035.google.com with SMTP id np3so4468186pjb.4
 for <linux-um@lists.infradead.org>; Wed, 24 Nov 2021 22:47:57 -0800 (PST)
MIME-Version: 1.0
References: <CANn89i+hQTn26hK-4CA=cAwCxEMzogqD30PYdqz4NP8kjmH2gg@mail.gmail.com>
 <CANn89i+K6=Kc0weayD_phAPn9YT=2UUje+1BZfg=kUiLp7ELqQ@mail.gmail.com>
 <619eee05.1c69fb81.4b686.4bbc@mx.google.com>
 <CANn89iJdQ1VTLYUKu1hYNm4wF__ZzrwNYr28v_vGM0MCybJpxg@mail.gmail.com>
 <CAFUsyf+5zp+p_0TPFLr-fMNry0M_CnNAFDG30PKDuy2jA5MhNw@mail.gmail.com>
 <CANn89iLtZmSyBYtvJ0nxdrM3CKyf3D9y9AWBC4GVbPCxtjOROw@mail.gmail.com>
 <CANn89i+edPKsp63R16kx4_kQ884ks=is8pg=W0wDbNV46UZ3vw@mail.gmail.com>
 <CANn89iJqZm9Mcfu+4-aZ_pZok1j4RsHK8YoFBVqjVYpGbt_P8Q@mail.gmail.com>
 <CAFUsyfL3RF-UC-HBUcbRn0e5S3URo9gpz5V85buF8C7xVb6K7w@mail.gmail.com>
 <CAFUsyfLz89DrkvTwDTDqNCHVbBzk1QgEKu0+PuwBoF=Y6me7cQ@mail.gmail.com>
 <CANn89iLYHkyaLawrZJYuRETx63c0QWQ0kLGysPbGpWj2+C5Jfw@mail.gmail.com>
In-Reply-To: <CANn89iLYHkyaLawrZJYuRETx63c0QWQ0kLGysPbGpWj2+C5Jfw@mail.gmail.com>
From: Noah Goldstein <goldstein.w.n@gmail.com>
Date: Thu, 25 Nov 2021 00:47:46 -0600
Message-ID: <CAFUsyfKx=444zNM40rVznS+=0YKxz2+O+qNA2NbiAv2Qs+Xhrg@mail.gmail.com>
Subject: Re: [tip:x86/core 1/1] arch/x86/um/../lib/csum-partial_64.c:98:12:
 error: implicit declaration of function 'load_unaligned_zeropad'
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
Cc: Johannes Berg <johannes@sipsolutions.net>, alexanderduyck@fb.com, kbuild-all@lists.01.org, open list <linux-kernel@vger.kernel.org>, linux-um@lists.infradead.org, lkp@intel.com, peterz@infradead.org, X86 ML <x86@kernel.org>

On Thu, Nov 25, 2021 at 12:32 AM Eric Dumazet <edumazet@google.com> wrote:
>
> On Wed, Nov 24, 2021 at 9:09 PM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
> >
> >
> >
> > Although I see slightly worse performance with aligned `buff`  in
> > the branch-free approach. Imagine if non-aligned `buff` is that
> > uncommon might be better to speculate past the work of `ror`.
>
> Yes, no clear win here removing the conditional (same cost really),
> although using a ror32() is removing the from32to16() helper and get
> rid of one folding.
>
> I will formally submit this change, thanks !

Great :)

Can you put me on the cc list? I have a patch for the function that I'll post
once yours gets through.

>
> diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
> index 1eb8f2d11f7c785be624eba315fe9ca7989fd56d..cf4bd3ef66e56c681b3435d43011ece78438376d
> 100644
> --- a/arch/x86/lib/csum-partial_64.c
> +++ b/arch/x86/lib/csum-partial_64.c
> @@ -11,16 +11,6 @@
>  #include <asm/checksum.h>
>  #include <asm/word-at-a-time.h>
>
> -static inline unsigned short from32to16(unsigned a)
> -{
> -       unsigned short b = a >> 16;
> -       asm("addw %w2,%w0\n\t"
> -           "adcw $0,%w0\n"
> -           : "=r" (b)
> -           : "0" (b), "r" (a));
> -       return b;
> -}
> -
>  /*
>   * Do a checksum on an arbitrary memory area.
>   * Returns a 32bit checksum.
> @@ -41,6 +31,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
>         if (unlikely(odd)) {
>                 if (unlikely(len == 0))
>                         return sum;
> +               temp64 = ror32((__force u32)sum, 8);
>                 temp64 += (*(unsigned char *)buff << 8);
>                 len--;
>                 buff++;
> @@ -129,10 +120,8 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
>  #endif
>         }
>         result = add32_with_carry(temp64 >> 32, temp64 & 0xffffffff);
> -       if (unlikely(odd)) {
> -               result = from32to16(result);
> -               result = ((result >> 8) & 0xff) | ((result & 0xff) << 8);
> -       }
> +       if (unlikely(odd))
> +               result = ror32(result, 8);
>         return (__force __wsum)result;
>  }
>  EXPORT_SYMBOL(csum_partial);

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

