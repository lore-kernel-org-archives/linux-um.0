Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mq5wO-006LUs-Qa
 for linux-um@lists.infradead.org; Thu, 25 Nov 2021 04:00:58 +0000
Received: by mail-wm1-x32a.google.com with SMTP id
 p3-20020a05600c1d8300b003334fab53afso7190592wms.3
 for <linux-um@lists.infradead.org>; Wed, 24 Nov 2021 20:00:56 -0800 (PST)
MIME-Version: 1.0
References: <CANn89i+hQTn26hK-4CA=cAwCxEMzogqD30PYdqz4NP8kjmH2gg@mail.gmail.com>
 <CANn89i+K6=Kc0weayD_phAPn9YT=2UUje+1BZfg=kUiLp7ELqQ@mail.gmail.com>
 <619eee05.1c69fb81.4b686.4bbc@mx.google.com>
 <CANn89iJdQ1VTLYUKu1hYNm4wF__ZzrwNYr28v_vGM0MCybJpxg@mail.gmail.com>
 <CAFUsyf+5zp+p_0TPFLr-fMNry0M_CnNAFDG30PKDuy2jA5MhNw@mail.gmail.com>
In-Reply-To: <CAFUsyf+5zp+p_0TPFLr-fMNry0M_CnNAFDG30PKDuy2jA5MhNw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 24 Nov 2021 20:00:43 -0800
Message-ID: <CANn89iLtZmSyBYtvJ0nxdrM3CKyf3D9y9AWBC4GVbPCxtjOROw@mail.gmail.com>
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

On Wed, Nov 24, 2021 at 7:41 PM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
>
> On Wed, Nov 24, 2021 at 8:56 PM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Wed, Nov 24, 2021 at 5:59 PM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
> > >
> >
> > >
> > > Hi, I'm not sure if this is intentional or not, but I noticed that the output
> > > of 'csum_partial' is different after this patch. I figured that the checksum
> > > algorithm is fixed so just wanted mention it incase its a bug. If not sorry
> > > for the spam.
> > >
> > > Example on x86_64:
> > >
> > > Buff: [ 87, b3, 92, b7, 8b, 53, 96, db, cd, 0f, 7e, 7e ]
> > > len : 11
> > > sum : 0
> > >
> > > csum_partial new : 2480936615
> > > csum_partial HEAD: 2472089390
> >
> > No worries.
> >
> > skb->csum is 32bit, but really what matters is the 16bit folded value.
> >
> > So make sure to apply csum_fold() before comparing the results.
> >
> > A minimal C and generic version of csum_fold() would be something like
> >
> > static unsigned short csum_fold(u32 csum)
> > {
> >   u32 sum = csum;
> >   sum = (sum & 0xffff) + (sum >> 16);
> >   sum = (sum & 0xffff) + (sum >> 16);
> >   return ~sum;
> > }
> >
> > I bet that csum_fold(2480936615) == csum_fold(2472089390)
> >
>
> Correct :)
>
> The outputs seem to match if `buff` is aligned to 64-bit. Still see
> difference with `csum_fold(csum_partial())` if `buff` is not 64-bit aligned.
>
> The comment at the top says it's "best" to have `buff` 64-bit aligned but
> the code logic seems meant to support the misaligned case so not
> sure if it's an issue.
>

It is an issue in general, not in standard cases because network
headers are aligned.

I think it came when I folded csum_partial() and do_csum(), I forgot
to ror() the seed.

I suspect the following would help:

diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
index 1eb8f2d11f7c785be624eba315fe9ca7989fd56d..ee7b0e7a6055bcbef42d22f7e1d8f52ddbd6be6d
100644
--- a/arch/x86/lib/csum-partial_64.c
+++ b/arch/x86/lib/csum-partial_64.c
@@ -41,6 +41,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
        if (unlikely(odd)) {
                if (unlikely(len == 0))
                        return sum;
+               temp64 = ror32((__force u64)sum, 8);
                temp64 += (*(unsigned char *)buff << 8);
                len--;
                buff++;




> Example:
>
> csum_fold(csum_partial) new : 0x3764
> csum_fold(csum_partial) HEAD: 0x3a61
>
> buff        : [ 11, ea, 75, 76, e9, ab, 86, 48 ]
> buff addr   : ffff88eaf5fb0001
> len         : 8
> sum_in      : 25
>
> > It would be nice if we had a csum test suite, hint, hint ;)
>
> Where in the kernel would that belong?

This could be a module, like lib/test_csum.c

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

