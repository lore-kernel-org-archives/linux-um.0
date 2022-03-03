Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 3 Mar 2022 09:28:04 -0800
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3 7/7] UAPI: Introduce KUnit userspace compatibility
Message-ID: <202203030927.2D794F4@keescook>
References: <20220227184517.504931-1-keescook@chromium.org>
 <20220227184517.504931-8-keescook@chromium.org>
 <CABVgOSn6Oe8Ke=fnuVwgLh2r8HKjBW8pCe44Z35Qo1bVfz9A-A@mail.gmail.com>
 <YiC9NBjFgGv5T+gF@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiC9NBjFgGv5T+gF@kroah.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: David Gow <davidgow@google.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Vitor Massaru Iha <vitor@massaru.org>, Daniel Latypov <dlatypov@google.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, linux-kbuild@vger.kernel.org, KUnit Development <kunit-dev@googlegroups.com>, llvm@lists.linux.dev, x86@kernel.org, linux-hardening@vger.kernel.org
List-ID: <linux-um.lists.infradead.org>

On Thu, Mar 03, 2022 at 02:05:56PM +0100, Greg KH wrote:
> On Thu, Mar 03, 2022 at 04:27:13PM +0800, David Gow wrote:
> > On Mon, Feb 28, 2022 at 2:45 AM Kees Cook <keescook@chromium.org> wrote:
> > > diff --git a/include/uapi/misc/kunit.h b/include/uapi/misc/kunit.h
> > > new file mode 100644
> > > index 000000000000..afdffda583ae
> > > --- /dev/null
> > > +++ b/include/uapi/misc/kunit.h
> > > @@ -0,0 +1,181 @@
> > > +#ifndef __UAPI_MISC_KUNIT_H__
> > > +#define __UAPI_MISC_KUNIT_H__
> > > +/*
> > > + * This is a light-weight userspace drop-in replacement for the in-kernel
> 
> <snip>
> 
> Someone forgot a SPDX license line for the new file.  Didn't checkpatch
> complain about this?  :(

Yeah, that file has a bunch of problems. ;) The UAPI header checking
logic also freaks out, etc, etc. I'll being fixing that and the other
issues.

-- 
Kees Cook

