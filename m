Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mq6FU-006Lxz-KY
 for linux-um@lists.infradead.org; Thu, 25 Nov 2021 04:20:42 +0000
Received: by mail-wm1-x32b.google.com with SMTP id
 c6-20020a05600c0ac600b0033c3aedd30aso3715653wmr.5
 for <linux-um@lists.infradead.org>; Wed, 24 Nov 2021 20:20:40 -0800 (PST)
MIME-Version: 1.0
References: <CANn89i+hQTn26hK-4CA=cAwCxEMzogqD30PYdqz4NP8kjmH2gg@mail.gmail.com>
 <CANn89i+K6=Kc0weayD_phAPn9YT=2UUje+1BZfg=kUiLp7ELqQ@mail.gmail.com>
 <619eee05.1c69fb81.4b686.4bbc@mx.google.com>
 <CANn89iJdQ1VTLYUKu1hYNm4wF__ZzrwNYr28v_vGM0MCybJpxg@mail.gmail.com>
 <CAFUsyf+5zp+p_0TPFLr-fMNry0M_CnNAFDG30PKDuy2jA5MhNw@mail.gmail.com>
 <CANn89iLtZmSyBYtvJ0nxdrM3CKyf3D9y9AWBC4GVbPCxtjOROw@mail.gmail.com>
 <CANn89i+edPKsp63R16kx4_kQ884ks=is8pg=W0wDbNV46UZ3vw@mail.gmail.com>
In-Reply-To: <CANn89i+edPKsp63R16kx4_kQ884ks=is8pg=W0wDbNV46UZ3vw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 24 Nov 2021 20:20:27 -0800
Message-ID: <CANn89iJqZm9Mcfu+4-aZ_pZok1j4RsHK8YoFBVqjVYpGbt_P8Q@mail.gmail.com>
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
To: Noah Goldstein <goldstein.w.n@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, alexanderduyck@fb.com, kbuild-all@lists.01.org, open list <linux-kernel@vger.kernel.org>, linux-um@lists.infradead.org, lkp@intel.com, peterz@infradead.org, X86 ML <x86@kernel.org>

On Wed, Nov 24, 2021 at 8:08 PM Eric Dumazet <edumazet@google.com> wrote:
>
> On Wed, Nov 24, 2021 at 8:00 PM Eric Dumazet <edumazet@google.com> wrote:
>
> >
> > It is an issue in general, not in standard cases because network
> > headers are aligned.
> >
> > I think it came when I folded csum_partial() and do_csum(), I forgot
> > to ror() the seed.
> >
> > I suspect the following would help:
> >
> > diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
> > index 1eb8f2d11f7c785be624eba315fe9ca7989fd56d..ee7b0e7a6055bcbef42d22f7e1d8f52ddbd6be6d
> > 100644
> > --- a/arch/x86/lib/csum-partial_64.c
> > +++ b/arch/x86/lib/csum-partial_64.c
> > @@ -41,6 +41,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
> >         if (unlikely(odd)) {
> >                 if (unlikely(len == 0))
> >                         return sum;
> > +               temp64 = ror32((__force u64)sum, 8);
> >                 temp64 += (*(unsigned char *)buff << 8);
> >                 len--;
> >                 buff++;
> >
> >
>
> It is a bit late here, I will test the following later this week.
>
> We probably can remove one conditional jump at the end of the function
>
> diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
> index 1eb8f2d11f7c785be624eba315fe9ca7989fd56d..15986ad42ed5ccb8241ff467a34188cf901ec98e
> 100644
> --- a/arch/x86/lib/csum-partial_64.c
> +++ b/arch/x86/lib/csum-partial_64.c
> @@ -41,9 +41,11 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
>         if (unlikely(odd)) {
>                 if (unlikely(len == 0))
>                         return sum;
> +               temp64 = ror32((__force u64)sum, 8);
>                 temp64 += (*(unsigned char *)buff << 8);
>                 len--;
>                 buff++;
> +               odd = 8;
>         }
>
>         while (unlikely(len >= 64)) {
> @@ -129,10 +131,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
>  #endif
>         }
>         result = add32_with_carry(temp64 >> 32, temp64 & 0xffffffff);
> -       if (unlikely(odd)) {
> -               result = from32to16(result);
> -               result = ((result >> 8) & 0xff) | ((result & 0xff) << 8);
> -       }
> +       ror32(result, odd);

this would be
          result = ror32(result, odd);

definitely time to stop working today for me.

>         return (__force __wsum)result;
>  }
>  EXPORT_SYMBOL(csum_partial);

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

