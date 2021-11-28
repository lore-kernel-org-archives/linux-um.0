Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mrOwo-00GTDi-Tg
 for linux-um@lists.infradead.org; Sun, 28 Nov 2021 18:30:50 +0000
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [tip:x86/core 1/1] arch/x86/um/../lib/csum-partial_64.c:98:12:
 error: implicit declaration of function 'load_unaligned_zeropad'
Date: Sun, 28 Nov 2021 18:30:40 +0000
Message-ID: <670c2043e9104d6c8d516cc54edef38e@AcuMS.aculab.com>
References: <CANn89i+hQTn26hK-4CA=cAwCxEMzogqD30PYdqz4NP8kjmH2gg@mail.gmail.com>
 <CANn89i+K6=Kc0weayD_phAPn9YT=2UUje+1BZfg=kUiLp7ELqQ@mail.gmail.com>
 <619eee05.1c69fb81.4b686.4bbc@mx.google.com>
 <CANn89iJdQ1VTLYUKu1hYNm4wF__ZzrwNYr28v_vGM0MCybJpxg@mail.gmail.com>
 <CAFUsyf+5zp+p_0TPFLr-fMNry0M_CnNAFDG30PKDuy2jA5MhNw@mail.gmail.com>
 <CANn89iLtZmSyBYtvJ0nxdrM3CKyf3D9y9AWBC4GVbPCxtjOROw@mail.gmail.com>
 <4dbf7f8d095b46a8a45e285d0ec8f8b0@AcuMS.aculab.com>
 <CANn89iJubuJxjVp4fx78-bjKBN3e9JsdAwZxj4XO6g2_7ZPqJQ@mail.gmail.com>
 <8a6fe34e0f2f4739af39a5935a74b823@AcuMS.aculab.com>
 <CAFUsyfJmpFFzuMhHrH+oBVzcHggW0QZM9dvXtPQW88kAw_2_BQ@mail.gmail.com>
In-Reply-To: <CAFUsyfJmpFFzuMhHrH+oBVzcHggW0QZM9dvXtPQW88kAw_2_BQ@mail.gmail.com>
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
To: 'Noah Goldstein' <goldstein.w.n@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Johannes Berg <johannes@sipsolutions.net>, "alexanderduyck@fb.com" <alexanderduyck@fb.com>, "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>, open list <linux-kernel@vger.kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "lkp@intel.com" <lkp@intel.com>, "peterz@infradead.org" <peterz@infradead.org>, X86 ML <x86@kernel.org>

From: Noah Goldstein
> Sent: 26 November 2021 23:04
> 
> On Fri, Nov 26, 2021 at 4:41 PM David Laight <David.Laight@aculab.com> wrote:
> >
> > From: Eric Dumazet
> > > Sent: 26 November 2021 18:10
> > ...
> > > > AFAICT (from a pdf) bswap32() and ror(x, 8) are likely to be
> > > > the same speed but may use different execution units.
> >
> > The 64bit shifts/rotates are also only one clock.
> > It is the bswap64 that can be two.
> >
> > > > Intel seem so have managed to slow down ror(x, %cl) to 3 clocks
> > > > in sandy bridge - and still not fixed it.
> > > > Although the compiler might be making a pigs-breakfast of the
> > > > register allocation when you tried setting 'odd = 8'.
> > > >
> > > > Weeks can be spent fiddling with this code :-(
> > >
> > > Yes, and in the end, it won't be able to compete with  a
> > > specialized/inlined ipv6_csum_partial()
> >
> > I bet most of the gain comes from knowing there is a non-zero
> > whole number of 32bit words.
> > The pesky edge conditions cost.
> >
> > And even then you need to get it right!
> > The one for summing the 5-word IPv4 header is actually horrid
> > on Intel cpu prior to Haswell because 'adc' has a latency of 2.
> > On Sandy bridge the carry output is valid on the next clock,
> > so adding to alternate registers doubles throughput.
> > (That could easily be done in the current function and will
> > make a big different on those cpu.)
> >
> > But basically the current generic code has the loop unrolled
> > further than is necessary for modern (non-atom) cpu.
> > That just adds more code outside the loop.
> >
> > I did managed to get 12 bytes/clock using adco/adox with only
> > 32 bytes each iteration.
> > That will require aligned buffers.
> >
> > Alignment won't matter for 'adc' loops because there are two
> > 'memory read' units - but there is the elephant:
> >
> > Sandy bridge Cache bank conflicts
> > Each consecutive 128 bytes, or two cache lines, in the data cache is divided
> > into 8 banks of 16 bytes each. It is not possible to do two memory reads in
> > the same clock cycle if the two memory addresses have the same bank number,
> > i.e. if bit 4 - 6 in the two addresses are the same.
> >         ; Example 9.5. Sandy bridge cache bank conflict
> >         mov eax, [rsi] ; Use bank 0, assuming rsi is divisible by 40H
> >         mov ebx, [rsi+100H] ; Use bank 0. Cache bank conflict
> >         mov ecx, [rsi+110H] ; Use bank 1. No cache bank conflict
> >
> > That isn't a problem on Haswell, but it is probably worth ordering
> > the 'adc' in the loop to reduce the number of conflicts.
> > I didn't try to look for that though.
> > I only remember testing aligned buffers on Sandy/Ivy bridge.
> > Adding to alternate registers helped no end.
> 
> Cant that just be solved by having the two independent adcx/adox chains work
> from region that are 16+ bytes apart? For 40 byte ipv6 header it will be simple.

Not relevant, adcx/adox are only supported haswell/broadwell onwards
which don't have the 'cache bank conflict' issue.

In any case using adx[oc] for only 40 bytes isn't worth the effort.

The other issue with adcx/adoc is that some cpu that support them
have very slow decode times - so unless you' got them in a loop
it will be horrid.
Trying to 'loop carry' both the 'carry' and 'overflow' flags is also
fraught. The 'loop' instruction would do it - but that is horribly
slow on Intel cpu (I think it is ok an AMD ones).
You can use jcxz at the top of the loop and an unconditional jump at the bottom.
There might be an obscure method of doing a 64bit->32bit move into %recx
and then a jrcxz at the loop bottom!

For Ivy/Sandy bridge it is noted:
There is hardly any penalty for misaligned memory access with operand sizes
of 64 bits or less, except for the effect of using multiple cache banks.

That might mean that you can do a misaligned read every clock.
With the only issues arising for that that is trying to do 2 reads/clock.
Given the checksum code needs to do 'adc', the carry flag constrains
you to 1 read/clock - so there may actually be no real penalty for
a misaligned buffer at all.

No one (except me) has actually noticed that the adc chain takes two
clocks per adc on sandy bridge, so if the misaligned memory reads
take two clocks it makes no difference.

(info from pdf's from www.agner.org/optimize)

I've not got the test systems and program I used back in May 2020
to hand any more.

I certainly found that efficiently handling the 'odd 7 bytes'
was actually more difficult than it might seem.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

