Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1312066923.22074.53.camel@i7.infradead.org>
References: <1312066693.22074.50.camel@i7.infradead.org>
	<1312066923.22074.53.camel@i7.infradead.org>
Date: Mon, 1 Aug 2011 00:11:08 +0200
Message-ID: <CAFLxGvy0QqoySDFwZpygHeXvQ7hG-B7z5iZq8qx3GUkFX8w2RQ@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 1/5] um: Use __i386__ in ifdef for vsyscall exports, not SUBARCH_i386
To: David Woodhouse <dwmw2@infradead.org>
Cc: Arnaud Lacombe <lacombar@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sun, Jul 31, 2011 at 1:02 AM, David Woodhouse <dwmw2@infradead.org> =
wrote:
> Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
> ---
> =A0arch/um/os-Linux/Makefile =A0 =A0| =A0 =A02 --
> =A0arch/um/os-Linux/user_syms.c | =A0 =A02 +-
> =A02 files changed, 1 insertions(+), 3 deletions(-)
>
> diff --git a/arch/um/os-Linux/Makefile b/arch/um/os-Linux/Makefile
> index b33f4df..78658a7 100644
> --- a/arch/um/os-Linux/Makefile
> +++ b/arch/um/os-Linux/Makefile
> @@ -13,8 +13,6 @@ USER_OBJS :=3D $(user-objs-y) aio.o elf_aux.o execv=
p.o file.o helper.o irq.o \
> =A0 =A0 =A0 =A0main.o mem.o process.o registers.o sigio.o signal.o st=
art_up.o time.o \
> =A0 =A0 =A0 =A0tty.o tls.o uaccess.o umid.o util.o
>
> -CFLAGS_user_syms.o +=3D -DSUBARCH_$(SUBARCH)
> -
> =A0HAVE_AIO_ABI :=3D $(shell [ -r /usr/include/linux/aio_abi.h ] && \
> =A0 =A0 =A0 =A0echo -DHAVE_AIO_ABI )
> =A0CFLAGS_aio.o +=3D $(HAVE_AIO_ABI)
> diff --git a/arch/um/os-Linux/user_syms.c b/arch/um/os-Linux/user_sym=
s.c
> index 45ffe46..9165513 100644
> --- a/arch/um/os-Linux/user_syms.c
> +++ b/arch/um/os-Linux/user_syms.c
> @@ -45,7 +45,7 @@ EXPORT_SYMBOL(readdir64);
> =A0extern void truncate64(void) __attribute__((weak));
> =A0EXPORT_SYMBOL(truncate64);
>
> -#ifdef SUBARCH_i386
> +#ifdef __i386__
> =A0EXPORT_SYMBOL(vsyscall_ehdr);
> =A0EXPORT_SYMBOL(vsyscall_end);
> =A0#endif

Why do we need this?

--=20
Thanks,
//richard
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

