Return-Path: <linux-kernel-owner@vger.kernel.org>
References: <1450876627-4814-1-git-send-email-mic@digikod.net>
From: Richard Weinberger <richard@nod.at>
Message-ID: <567AEA7E.2090207@nod.at>
Date: Wed, 23 Dec 2015 19:39:58 +0100
MIME-Version: 1.0
In-Reply-To: <1450876627-4814-1-git-send-email-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v2] um: Fix pointer cast
To: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>, linux-kernel@vger.kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, Linus Torvalds <torvalds@linux-foundation.org>, user-mode-linux-devel@lists.sourceforge.net, Al Viro <viro@ZenIV.linux.org.uk>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 23.12.2015 um 14:17 schrieb Micka=C3=ABl Sala=C3=BCn:
> Fix a pointer cast typo introduced in v4.4-rc5 especially visible for
> the i386 subarchitecture where it results in a kernel crash.
>=20
> Fixes: 8090bfd2bb9a ("um: Fix fpstate handling")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Al Viro <viro@ZenIV.linux.org.uk>
> ---
>  arch/x86/um/signal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/um/signal.c b/arch/x86/um/signal.c
> index e5f854ce2d72..14fcd01ed992 100644
> --- a/arch/x86/um/signal.c
> +++ b/arch/x86/um/signal.c
> @@ -470,7 +470,7 @@ long sys_sigreturn(void)
>  	struct sigcontext __user *sc =3D &frame->sc;
>  	int sig_size =3D (_NSIG_WORDS - 1) * sizeof(unsigned long);
> =20
> -	if (copy_from_user(&set.sig[0], (void *)sc->oldmask, sizeof(set.sig=
[0])) ||
> +	if (copy_from_user(&set.sig[0], &sc->oldmask, sizeof(set.sig[0])) |=
|
>  	    copy_from_user(&set.sig[1], frame->extramask, sig_size))
>  		goto segfault;

=46YI Linus already merged your patch. :-)
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Dde3793796f78e293cc0873744a75588c99ed2fdd

Thanks,
//richard
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

