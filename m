Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mq8Zm-006Xmr-8P
 for linux-um@lists.infradead.org; Thu, 25 Nov 2021 06:49:47 +0000
Received: by mail-pl1-x636.google.com with SMTP id p18so3782645plf.13
 for <linux-um@lists.infradead.org>; Wed, 24 Nov 2021 22:49:45 -0800 (PST)
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
 <CANn89iJsFZrm5qzAUJDgYczQiBFa6pmvPDrA_yqkGFhfm-6AnQ@mail.gmail.com>
In-Reply-To: <CANn89iJsFZrm5qzAUJDgYczQiBFa6pmvPDrA_yqkGFhfm-6AnQ@mail.gmail.com>
From: Noah Goldstein <goldstein.w.n@gmail.com>
Date: Thu, 25 Nov 2021 00:49:34 -0600
Message-ID: <CAFUsyfLACUMcOZmNF3S_xAaTXTPXAMg+kJ8tV6tKk+xw0XLOtg@mail.gmail.com>
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

On Thu, Nov 25, 2021 at 12:46 AM Eric Dumazet <edumazet@google.com> wrote:
>
> On Wed, Nov 24, 2021 at 10:32 PM Eric Dumazet <edumazet@google.com> wrote:
>
> > -       }
> > +       if (unlikely(odd))
> > +               result = ror32(result, 8);
> >         return (__force __wsum)result;
>
> Oh well, gcc at least removes the conditional and generates a ror and a cmov

Seems like a missed optimization for `unlikely` where dependency breaking
is pretty common.

Although still saves a uop because of `imm8` operand.

>
>         mov    %edx,%eax
>         ror    $0x8,%eax
>         test   %r8,%r8
>         cmove  %edx,%eax
>         ret
>
> clang keeps the cond jmp
>          test   $0x1,%dil
>          je     93
>          rol    $0x18,%eax
> 93:    ret

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

