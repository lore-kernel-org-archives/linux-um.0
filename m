Return-Path: <linux-kernel-owner@vger.kernel.org>
References: <1450817041-21236-1-git-send-email-mic@digikod.net>
From: Richard Weinberger <richard@nod.at>
Message-ID: <5679BF5C.2010002@nod.at>
Date: Tue, 22 Dec 2015 22:23:40 +0100
MIME-Version: 1.0
In-Reply-To: <1450817041-21236-1-git-send-email-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] um: Fix pointer cast
To: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>, linux-kernel@vger.kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, Linus Torvalds <torvalds@linux-foundation.org>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 22.12.2015 um 21:44 schrieb Micka=C3=ABl Sala=C3=BCn:
> Fix a pointer cast typo introduced in v4.4-rc5 especially visible for
> the i386 subarchitecture where it results in a kernel crash.
>=20
> Fixes: 8090bfd2bb9a ("um: Fix fpstate handling")
>=20
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>  arch/x86/um/signal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/um/signal.c b/arch/x86/um/signal.c
> index e5f854ce2d72..cbb541b80358 100644
> --- a/arch/x86/um/signal.c
> +++ b/arch/x86/um/signal.c
> @@ -470,7 +470,7 @@ long sys_sigreturn(void)
>  	struct sigcontext __user *sc =3D &frame->sc;
>  	int sig_size =3D (_NSIG_WORDS - 1) * sizeof(unsigned long);
> =20
> -	if (copy_from_user(&set.sig[0], (void *)sc->oldmask, sizeof(set.sig=
[0])) ||
> +	if (copy_from_user(&set.sig[0], (void *)&sc->oldmask, sizeof(set.si=
g[0])) ||
>  	    copy_from_user(&set.sig[1], frame->extramask, sig_size))
>  		goto segfault;

o_O, thanks for catching this!

Thanks,
//richard
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

