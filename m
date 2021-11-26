Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mqerz-00BI74-3h
 for linux-um@lists.infradead.org; Fri, 26 Nov 2021 17:18:44 +0000
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [tip:x86/core 1/1] arch/x86/um/../lib/csum-partial_64.c:98:12:
 error: implicit declaration of function 'load_unaligned_zeropad'
Date: Fri, 26 Nov 2021 17:18:34 +0000
Message-ID: <4dbf7f8d095b46a8a45e285d0ec8f8b0@AcuMS.aculab.com>
References: <CANn89i+hQTn26hK-4CA=cAwCxEMzogqD30PYdqz4NP8kjmH2gg@mail.gmail.com>
 <CANn89i+K6=Kc0weayD_phAPn9YT=2UUje+1BZfg=kUiLp7ELqQ@mail.gmail.com>
 <619eee05.1c69fb81.4b686.4bbc@mx.google.com>
 <CANn89iJdQ1VTLYUKu1hYNm4wF__ZzrwNYr28v_vGM0MCybJpxg@mail.gmail.com>
 <CAFUsyf+5zp+p_0TPFLr-fMNry0M_CnNAFDG30PKDuy2jA5MhNw@mail.gmail.com>
 <CANn89iLtZmSyBYtvJ0nxdrM3CKyf3D9y9AWBC4GVbPCxtjOROw@mail.gmail.com>
In-Reply-To: <CANn89iLtZmSyBYtvJ0nxdrM3CKyf3D9y9AWBC4GVbPCxtjOROw@mail.gmail.com>
MIME-Version: 1.0
Content-Language: en-US
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
To: 'Eric Dumazet' <edumazet@google.com>, Noah Goldstein <goldstein.w.n@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, "alexanderduyck@fb.com" <alexanderduyck@fb.com>, "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>, open list <linux-kernel@vger.kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "lkp@intel.com" <lkp@intel.com>, "peterz@infradead.org" <peterz@infradead.org>, X86 ML <x86@kernel.org>

From: Eric Dumazet
> Sent: 25 November 2021 04:01
...
> > The outputs seem to match if `buff` is aligned to 64-bit. Still see
> > difference with `csum_fold(csum_partial())` if `buff` is not 64-bit aligned.
> >
> > The comment at the top says it's "best" to have `buff` 64-bit aligned but
> > the code logic seems meant to support the misaligned case so not
> > sure if it's an issue.
> >
> 
> It is an issue in general, not in standard cases because network
> headers are aligned.
> 
> I think it came when I folded csum_partial() and do_csum(), I forgot
> to ror() the seed.
> 
> I suspect the following would help:
> 
> diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
> index 1eb8f2d11f7c785be624eba315fe9ca7989fd56d..ee7b0e7a6055bcbef42d22f7e1d8f52ddbd6be6d
> 100644
> --- a/arch/x86/lib/csum-partial_64.c
> +++ b/arch/x86/lib/csum-partial_64.c
> @@ -41,6 +41,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
>         if (unlikely(odd)) {
>                 if (unlikely(len == 0))
>                         return sum;
> +               temp64 = ror32((__force u64)sum, 8);
>                 temp64 += (*(unsigned char *)buff << 8);
>                 len--;
>                 buff++;

You can save an instruction (as if this path matters) by:
			temp64 = sum + *(unsigned char *)buff;
			temp64 <<= 8;
Although that probably falls foul of 64bit shifts being slow.
So maybe just:
			sum += *(unsigned char *)buff;
			temp64 = bswap32(sum);
AFAICT (from a pdf) bswap32() and ror(x, 8) are likely to be
the same speed but may use different execution units.

Intel seem so have managed to slow down ror(x, %cl) to 3 clocks
in sandy bridge - and still not fixed it.
Although the compiler might be making a pigs-breakfast of the
register allocation when you tried setting 'odd = 8'.

Weeks can be spent fiddling with this code :-(

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

