Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nPl9c-006SjV-Jb
 for linux-um@lists.infradead.org; Thu, 03 Mar 2022 13:06:02 +0000
Date: Thu, 3 Mar 2022 14:05:56 +0100
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 7/7] UAPI: Introduce KUnit userspace compatibility
Message-ID: <YiC9NBjFgGv5T+gF@kroah.com>
References: <20220227184517.504931-1-keescook@chromium.org>
 <20220227184517.504931-8-keescook@chromium.org>
 <CABVgOSn6Oe8Ke=fnuVwgLh2r8HKjBW8pCe44Z35Qo1bVfz9A-A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CABVgOSn6Oe8Ke=fnuVwgLh2r8HKjBW8pCe44Z35Qo1bVfz9A-A@mail.gmail.com>
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
To: David Gow <davidgow@google.com>
Cc: Kees Cook <keescook@chromium.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Vitor Massaru Iha <vitor@massaru.org>, Daniel Latypov <dlatypov@google.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, linux-kbuild@vger.kernel.org, KUnit Development <kunit-dev@googlegroups.com>, llvm@lists.linux.dev, x86@kernel.org, linux-hardening@vger.kernel.org

On Thu, Mar 03, 2022 at 04:27:13PM +0800, David Gow wrote:
> On Mon, Feb 28, 2022 at 2:45 AM Kees Cook <keescook@chromium.org> wrote:
> > diff --git a/include/uapi/misc/kunit.h b/include/uapi/misc/kunit.h
> > new file mode 100644
> > index 000000000000..afdffda583ae
> > --- /dev/null
> > +++ b/include/uapi/misc/kunit.h
> > @@ -0,0 +1,181 @@
> > +#ifndef __UAPI_MISC_KUNIT_H__
> > +#define __UAPI_MISC_KUNIT_H__
> > +/*
> > + * This is a light-weight userspace drop-in replacement for the in-kernel

<snip>

Someone forgot a SPDX license line for the new file.  Didn't checkpatch
complain about this?  :(

thanks,

greg k-h

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

