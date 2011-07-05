Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Tue, 5 Jul 2011 11:42:39 +0200
References: <1309821347.4527.6.camel@vitaliy-Vostro-1400>
In-Reply-To: <1309821347.4527.6.camel@vitaliy-Vostro-1400>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Message-Id: <201107051142.39733.richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 2/4] uml: helper.c warning corrections
To: vitalivanov@gmail.com
Cc: Jeff Dike <jdike@addtoit.com>, Linus Torvalds <torvalds@linux-foundation.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, lkml <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am Dienstag 05 Juli 2011, 01:15:47 schrieb Vitaliy Ivanov:
> From 7296c5b9770e95cd6ad4e9e71d2d14c972abdfe1 Mon Sep 17 00:00:00 200=
1
> From: Vitaliy Ivanov <vitalivanov@gmail.com>
> Date: Tue, 5 Jul 2011 02:03:06 +0300
> Subject: [PATCH 2/4] uml: helper.c warning corrections
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>=20
> arch/um/os-Linux/helper.c: In function =E2=80=98helper_child=E2=80=99=
:
> arch/um/os-Linux/helper.c:38:7: warning: ignoring return value of =E2=
=80=98write=E2=80=99,
> declared with attribute warn_unused_result

Same question as before...

> Signed-off-by: Vitaliy Ivanov <vitalivanov@gmail.com>
> ---
>  arch/um/os-Linux/helper.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/um/os-Linux/helper.c b/arch/um/os-Linux/helper.c
> index b6b1096..feff22d 100644
> --- a/arch/um/os-Linux/helper.c
> +++ b/arch/um/os-Linux/helper.c
> @@ -28,14 +28,14 @@ static int helper_child(void *arg)
>  {
>  	struct helper_data *data =3D arg;
>  	char **argv =3D data->argv;
> -	int err;
> +	int err, ret;
>=20
>  	if (data->pre_exec !=3D NULL)
>  		(*data->pre_exec)(data->pre_data);
>  	err =3D execvp_noalloc(data->buf, argv[0], argv);
>=20
>  	/* If the exec succeeds, we don't get here */
> -	write(data->fd, &err, sizeof(err));
> +	CATCH_EINTR(ret =3D write(data->fd, &err, sizeof(err)));

Is there really a realistic chance that this write() can be interrupted=
?
helper_child() gets called via clone() in run_helper().

Thanks,
//richard
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

