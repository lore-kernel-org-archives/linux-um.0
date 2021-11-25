Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mq5da-006Knt-VN
 for linux-um@lists.infradead.org; Thu, 25 Nov 2021 03:41:32 +0000
Received: by mail-pl1-x630.google.com with SMTP id z6so3509365plk.6
 for <linux-um@lists.infradead.org>; Wed, 24 Nov 2021 19:41:30 -0800 (PST)
MIME-Version: 1.0
References: <CANn89i+hQTn26hK-4CA=cAwCxEMzogqD30PYdqz4NP8kjmH2gg@mail.gmail.com>
 <CANn89i+K6=Kc0weayD_phAPn9YT=2UUje+1BZfg=kUiLp7ELqQ@mail.gmail.com>
 <619eee05.1c69fb81.4b686.4bbc@mx.google.com>
 <CANn89iJdQ1VTLYUKu1hYNm4wF__ZzrwNYr28v_vGM0MCybJpxg@mail.gmail.com>
In-Reply-To: <CANn89iJdQ1VTLYUKu1hYNm4wF__ZzrwNYr28v_vGM0MCybJpxg@mail.gmail.com>
From: Noah Goldstein <goldstein.w.n@gmail.com>
Date: Wed, 24 Nov 2021 21:41:19 -0600
Message-ID: <CAFUsyf+5zp+p_0TPFLr-fMNry0M_CnNAFDG30PKDuy2jA5MhNw@mail.gmail.com>
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

On Wed, Nov 24, 2021 at 8:56 PM Eric Dumazet <edumazet@google.com> wrote:
>
> On Wed, Nov 24, 2021 at 5:59 PM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
> >
>
> >
> > Hi, I'm not sure if this is intentional or not, but I noticed that the output
> > of 'csum_partial' is different after this patch. I figured that the checksum
> > algorithm is fixed so just wanted mention it incase its a bug. If not sorry
> > for the spam.
> >
> > Example on x86_64:
> >
> > Buff: [ 87, b3, 92, b7, 8b, 53, 96, db, cd, 0f, 7e, 7e ]
> > len : 11
> > sum : 0
> >
> > csum_partial new : 2480936615
> > csum_partial HEAD: 2472089390
>
> No worries.
>
> skb->csum is 32bit, but really what matters is the 16bit folded value.
>
> So make sure to apply csum_fold() before comparing the results.
>
> A minimal C and generic version of csum_fold() would be something like
>
> static unsigned short csum_fold(u32 csum)
> {
>   u32 sum = csum;
>   sum = (sum & 0xffff) + (sum >> 16);
>   sum = (sum & 0xffff) + (sum >> 16);
>   return ~sum;
> }
>
> I bet that csum_fold(2480936615) == csum_fold(2472089390)
>

Correct :)

The outputs seem to match if `buff` is aligned to 64-bit. Still see
difference with `csum_fold(csum_partial())` if `buff` is not 64-bit aligned.

The comment at the top says it's "best" to have `buff` 64-bit aligned but
the code logic seems meant to support the misaligned case so not
sure if it's an issue.

Example:

csum_fold(csum_partial) new : 0x3764
csum_fold(csum_partial) HEAD: 0x3a61

buff        : [ 11, ea, 75, 76, e9, ab, 86, 48 ]
buff addr   : ffff88eaf5fb0001
len         : 8
sum_in      : 25

> It would be nice if we had a csum test suite, hint, hint ;)

Where in the kernel would that belong?

>
> Thanks !

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

