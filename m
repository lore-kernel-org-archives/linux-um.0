Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nQ6LL-009pAN-PC
 for linux-um@lists.infradead.org; Fri, 04 Mar 2022 11:43:33 +0000
Received: by mail-il1-x131.google.com with SMTP id i1so6330095ila.7
 for <linux-um@lists.infradead.org>; Fri, 04 Mar 2022 03:43:30 -0800 (PST)
MIME-Version: 1.0
References: <20220303090643.241747-1-davidgow@google.com>
 <YiD7R2wRxoWxtVq7@dev-arch.thelio-3990X>
 <202203030947.E2FA3D9@keescook> <YiEISsoS/XrbEtbm@thelio-3990X>
 <CAKwvOdkA1c3U6+-6hB3Nj9m2Z8eYzsFWm5X4se2eq_cF3NB2jA@mail.gmail.com>
In-Reply-To: <CAKwvOdkA1c3U6+-6hB3Nj9m2Z8eYzsFWm5X4se2eq_cF3NB2jA@mail.gmail.com>
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Fri, 4 Mar 2022 12:42:54 +0100
Message-ID: <CA+icZUXf9m13GrqvCLkDRsnQt0X2VQ=yVrJRYz=6fhCJXR4-Xg@mail.gmail.com>
Subject: Re: [PATCH] um: clang: Strip out -mno-global-merge from USER_CFLAGS
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Reply-To: sedat.dilek@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Kees Cook <keescook@chromium.org>, David Gow <davidgow@google.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Masahiro Yamada <masahiroy@kernel.org>, linux-um@lists.infradead.org, linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org

On Thu, Mar 3, 2022 at 9:43 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Thu, Mar 3, 2022 at 10:26 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > On Thu, Mar 03, 2022 at 10:04:28AM -0800, Kees Cook wrote:
> > > How does -mno-global-merge get KBUILD_CFLAGS in the first place? If it's
> > > arm/arm64 only, shouldn't that get relocated to those architectures?
> > >
> > > *time travel* found it:
> > >
> > > 61163efae020 ("kbuild: LLVMLinux: Add Kbuild support for building kernel with Clang")
> > >
> > > So I think this may have been universally true long ago, and now only
> > > arm/arm64 need it?
>
> Looks like that's the case from LLVM sources.
>
> <snip>
>
> > > diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> > > index a2391b8de5a5..dcab28c44c26 100644
> > > --- a/arch/arm/Makefile
> > > +++ b/arch/arm/Makefile
> > > @@ -48,6 +48,13 @@ CHECKFLAGS += -D__ARMEL__
> > >  KBUILD_LDFLAGS       += -EL
> > >  endif
> > >
> > > +ifdef CONFIG_CC_IS_CLANG
> > > +# CLANG uses a _MergedGlobals as optimization, but this breaks modpost, as the
> > > +# source of a reference will be _MergedGlobals and not on of the whitelisted names.
>
> I think there's a typo in the original comment.
> s/on of/one of/ ?
>
> Also, I'm not sure what's meant by _MergedGlobals. Perhaps this is an
> opportunity to make this clearer?
>
> "Clang's "global-merge" pass (implemented only for arm and aarch64)
> may break modpost Pattern 2 if symbols are renamed and thus don't
> appear on modpost's allowlist.
>
> > > +# See modpost pattern 2
> > > +KBUILD_CFLAGS        += -mno-global-merge
> > > +endif
> > > +
>

I can remember on x86-64 I was able to build and boot by dropping it entirely.

- Sedat -

>
>
> --
> Thanks,
> ~Nick Desaulniers

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

