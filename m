Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mqju9-00BvJV-4z
 for linux-um@lists.infradead.org; Fri, 26 Nov 2021 22:41:19 +0000
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [tip:x86/core 1/1] arch/x86/um/../lib/csum-partial_64.c:98:12:
 error: implicit declaration of function 'load_unaligned_zeropad'
Date: Fri, 26 Nov 2021 22:41:10 +0000
Message-ID: <8a6fe34e0f2f4739af39a5935a74b823@AcuMS.aculab.com>
References: <CANn89i+hQTn26hK-4CA=cAwCxEMzogqD30PYdqz4NP8kjmH2gg@mail.gmail.com>
 <CANn89i+K6=Kc0weayD_phAPn9YT=2UUje+1BZfg=kUiLp7ELqQ@mail.gmail.com>
 <619eee05.1c69fb81.4b686.4bbc@mx.google.com>
 <CANn89iJdQ1VTLYUKu1hYNm4wF__ZzrwNYr28v_vGM0MCybJpxg@mail.gmail.com>
 <CAFUsyf+5zp+p_0TPFLr-fMNry0M_CnNAFDG30PKDuy2jA5MhNw@mail.gmail.com>
 <CANn89iLtZmSyBYtvJ0nxdrM3CKyf3D9y9AWBC4GVbPCxtjOROw@mail.gmail.com>
 <4dbf7f8d095b46a8a45e285d0ec8f8b0@AcuMS.aculab.com>
 <CANn89iJubuJxjVp4fx78-bjKBN3e9JsdAwZxj4XO6g2_7ZPqJQ@mail.gmail.com>
In-Reply-To: <CANn89iJubuJxjVp4fx78-bjKBN3e9JsdAwZxj4XO6g2_7ZPqJQ@mail.gmail.com>
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
To: 'Eric Dumazet' <edumazet@google.com>
Cc: Noah Goldstein <goldstein.w.n@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, "alexanderduyck@fb.com" <alexanderduyck@fb.com>, "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>, open list <linux-kernel@vger.kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "lkp@intel.com" <lkp@intel.com>, "peterz@infradead.org" <peterz@infradead.org>, X86 ML <x86@kernel.org>

From: Eric Dumazet
> Sent: 26 November 2021 18:10
...
> > AFAICT (from a pdf) bswap32() and ror(x, 8) are likely to be
> > the same speed but may use different execution units.

The 64bit shifts/rotates are also only one clock.
It is the bswap64 that can be two.

> > Intel seem so have managed to slow down ror(x, %cl) to 3 clocks
> > in sandy bridge - and still not fixed it.
> > Although the compiler might be making a pigs-breakfast of the
> > register allocation when you tried setting 'odd = 8'.
> >
> > Weeks can be spent fiddling with this code :-(
> 
> Yes, and in the end, it won't be able to compete with  a
> specialized/inlined ipv6_csum_partial()

I bet most of the gain comes from knowing there is a non-zero
whole number of 32bit words.
The pesky edge conditions cost.

And even then you need to get it right!
The one for summing the 5-word IPv4 header is actually horrid
on Intel cpu prior to Haswell because 'adc' has a latency of 2.
On Sandy bridge the carry output is valid on the next clock,
so adding to alternate registers doubles throughput.
(That could easily be done in the current function and will
make a big different on those cpu.)

But basically the current generic code has the loop unrolled
further than is necessary for modern (non-atom) cpu.
That just adds more code outside the loop.

I did managed to get 12 bytes/clock using adco/adox with only
32 bytes each iteration.
That will require aligned buffers.

Alignment won't matter for 'adc' loops because there are two
'memory read' units - but there is the elephant:

Sandy bridge Cache bank conflicts
Each consecutive 128 bytes, or two cache lines, in the data cache is divided
into 8 banks of 16 bytes each. It is not possible to do two memory reads in
the same clock cycle if the two memory addresses have the same bank number,
i.e. if bit 4 - 6 in the two addresses are the same.
	; Example 9.5. Sandy bridge cache bank conflict
	mov eax, [rsi] ; Use bank 0, assuming rsi is divisible by 40H
	mov ebx, [rsi+100H] ; Use bank 0. Cache bank conflict
	mov ecx, [rsi+110H] ; Use bank 1. No cache bank conflict

That isn't a problem on Haswell, but it is probably worth ordering
the 'adc' in the loop to reduce the number of conflicts.
I didn't try to look for that though.
I only remember testing aligned buffers on Sandy/Ivy bridge.
Adding to alternate registers helped no end.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

