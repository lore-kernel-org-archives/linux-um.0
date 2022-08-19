Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from conssluserg-04.nifty.com ([210.131.2.83])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oP60s-00AoWP-5V
	for linux-um@lists.infradead.org; Fri, 19 Aug 2022 17:42:31 +0000
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51]) (authenticated)
	by conssluserg-04.nifty.com with ESMTP id 27JHg1sX027785
	for <linux-um@lists.infradead.org>; Sat, 20 Aug 2022 02:42:01 +0900
Received: by mail-wr1-f51.google.com with SMTP id h5so5154499wru.7
        for <linux-um@lists.infradead.org>; Fri, 19 Aug 2022 10:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220819170053.2686006-1-ndesaulniers@google.com>
 <Yv/Ff3mAfyCeWtmo@mail.local> <CAKwvOdnCGywz02Mf220njrS16fm4vTnFRFKALtJCqMbQY8Xz_w@mail.gmail.com>
In-Reply-To: <CAKwvOdnCGywz02Mf220njrS16fm4vTnFRFKALtJCqMbQY8Xz_w@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 20 Aug 2022 02:41:13 +0900
Message-ID: <CAK7LNAQy66UAWy+tyLYpzf51brdwVESAK8igcHud=4=-v5QxmQ@mail.gmail.com>
Subject: Re: [PATCH] Kconfig: eradicate CC_HAS_ASM_GOTO
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
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-um@lists.infradead.org, kvm@vger.kernel.org, clang-built-linux <llvm@lists.linux.dev>, Linus Torvalds <torvalds@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>

On Sat, Aug 20, 2022 at 2:28 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Aug 19, 2022 at 10:16 AM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> >
> > On 19/08/2022 10:00:53-0700, Nick Desaulniers wrote:
> > > GCC has supported asm goto since 4.5, and Clang has since version 9.0.0.
> > > The minimum supported versions of these tools for the build according to
> > > Documentation/process/changes.rst are 5.1 and 11.0.0 respectively.
> > >
> > > Remove the feature detection script, Kconfig option, and clean up some
> > > fallback code that is no longer supported.
> > >
> > > The removed script was also testing for a GCC specific bug that was
> > > fixed in the 4.7 release.
> > >
> > > The script was also not portable; users of Dash shell reported errors
> > > when it was invoked.
> > >
> >
> > To be clear, the script was portable, what is not working with dash is
> > the current detection of CC_HAS_ASM_GOTO_TIED_OUTPUT. I'll try the other
> > suggestion from Masahiro.
>
> Ah, that was his point about echo; that makes more sense.
>
> Unless a v2 is required, perhaps Masahiro would be kind enough to drop
> this sentence from the commit message when applying?

I can if there is nothing else to fix.


And, Alexandre's Reported-by is irrelevant.

As for the subject prefix "Kconfig:",
I prefer something else, for example,
"asm goto:" or "jump label:".

I want to reserve "Kconfig:" for changes in scripts/kconfig/.


>
> >
> > > --- a/arch/x86/include/asm/cpufeature.h
> > > +++ b/arch/x86/include/asm/cpufeature.h
> > > @@ -155,11 +155,11 @@ extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
> > >
> > >  #define setup_force_cpu_bug(bit) setup_force_cpu_cap(bit)
> > >
> > > -#if defined(__clang__) && !defined(CONFIG_CC_HAS_ASM_GOTO)
> > > +#if defined(__clang__) && __clang_major__ < 9
> >
> > Shouldn't we simply mandates clang >= 9 and drop the whole section? This
> > is what you do later on.
>
> I considered it, but I don't think it would be safe to do so in this
> header.  If you look at the comment block below it, it mentions that
> these kernel headers are being sucked into UAPI headers that are used
> outside of the kernel builds, such as when building eBPF programs.  So
> we don't know what userspace tools might be consuming these headers.
> The original intent of the guard was to not break eBPF compilation
> with older clang releases, so I've retained. that functionality.
>
> + Alexei to review
> (author of
> commit b1ae32dbab50 ("x86/cpufeature: Guard asm_volatile_goto usage
> for BPF compilation")


I am not sure at this point.
Wait for the input from Alexei.






> ).
> --
> Thanks,
> ~Nick Desaulniers



-- 
Best Regards
Masahiro Yamada

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

