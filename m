Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oP5nL-00Ajfv-Vm
	for linux-um@lists.infradead.org; Fri, 19 Aug 2022 17:28:33 +0000
Received: by mail-lj1-x234.google.com with SMTP id x25so5118547ljm.5
        for <linux-um@lists.infradead.org>; Fri, 19 Aug 2022 10:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220819170053.2686006-1-ndesaulniers@google.com> <Yv/Ff3mAfyCeWtmo@mail.local>
In-Reply-To: <Yv/Ff3mAfyCeWtmo@mail.local>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 19 Aug 2022 10:28:14 -0700
Message-ID: <CAKwvOdnCGywz02Mf220njrS16fm4vTnFRFKALtJCqMbQY8Xz_w@mail.gmail.com>
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
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, kvm@vger.kernel.org, llvm@lists.linux.dev, Linus Torvalds <torvalds@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>

On Fri, Aug 19, 2022 at 10:16 AM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 19/08/2022 10:00:53-0700, Nick Desaulniers wrote:
> > GCC has supported asm goto since 4.5, and Clang has since version 9.0.0.
> > The minimum supported versions of these tools for the build according to
> > Documentation/process/changes.rst are 5.1 and 11.0.0 respectively.
> >
> > Remove the feature detection script, Kconfig option, and clean up some
> > fallback code that is no longer supported.
> >
> > The removed script was also testing for a GCC specific bug that was
> > fixed in the 4.7 release.
> >
> > The script was also not portable; users of Dash shell reported errors
> > when it was invoked.
> >
>
> To be clear, the script was portable, what is not working with dash is
> the current detection of CC_HAS_ASM_GOTO_TIED_OUTPUT. I'll try the other
> suggestion from Masahiro.

Ah, that was his point about echo; that makes more sense.

Unless a v2 is required, perhaps Masahiro would be kind enough to drop
this sentence from the commit message when applying?

>
> > --- a/arch/x86/include/asm/cpufeature.h
> > +++ b/arch/x86/include/asm/cpufeature.h
> > @@ -155,11 +155,11 @@ extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
> >
> >  #define setup_force_cpu_bug(bit) setup_force_cpu_cap(bit)
> >
> > -#if defined(__clang__) && !defined(CONFIG_CC_HAS_ASM_GOTO)
> > +#if defined(__clang__) && __clang_major__ < 9
>
> Shouldn't we simply mandates clang >= 9 and drop the whole section? This
> is what you do later on.

I considered it, but I don't think it would be safe to do so in this
header.  If you look at the comment block below it, it mentions that
these kernel headers are being sucked into UAPI headers that are used
outside of the kernel builds, such as when building eBPF programs.  So
we don't know what userspace tools might be consuming these headers.
The original intent of the guard was to not break eBPF compilation
with older clang releases, so I've retained. that functionality.

+ Alexei to review
(author of
commit b1ae32dbab50 ("x86/cpufeature: Guard asm_volatile_goto usage
for BPF compilation")
).
-- 
Thanks,
~Nick Desaulniers

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

