Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Tue, 5 Jul 2011 14:02:50 +0200
References: <1309821347.4527.6.camel@vitaliy-Vostro-1400> <201107051142.39733.richard@nod.at> <CAGTPOqebcT_Dd5nPSNEkrDvnCgYhqcU=ayjEA8L7Zh0Wr_pj5w@mail.gmail.com>
In-Reply-To: <CAGTPOqebcT_Dd5nPSNEkrDvnCgYhqcU=ayjEA8L7Zh0Wr_pj5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Message-Id: <201107051402.50533.richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 2/4] uml: helper.c warning corrections
To: Vitaliy Ivanov <vitalivanov@gmail.com>
Cc: Jeff Dike <jdike@addtoit.com>, Linus Torvalds <torvalds@linux-foundation.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, lkml <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am Dienstag 05 Juli 2011, 13:45:06 schrieb Vitaliy Ivanov:
> Richard,
>=20
> On Tue, Jul 5, 2011 at 12:42 PM, Richard Weinberger <richard@nod.at> =
wrote:
> > Am Dienstag 05 Juli 2011, 01:15:47 schrieb Vitaliy Ivanov:
> >> From 7296c5b9770e95cd6ad4e9e71d2d14c972abdfe1 Mon Sep 17 00:00:00 =
2001
> >> From: Vitaliy Ivanov <vitalivanov@gmail.com>
> >> Date: Tue, 5 Jul 2011 02:03:06 +0300
> >> Subject: [PATCH 2/4] uml: helper.c warning corrections
> >> MIME-Version: 1.0
> >> Content-Type: text/plain; charset=3DUTF-8
> >> Content-Transfer-Encoding: 8bit
> >>=20
> >> arch/um/os-Linux/helper.c: In function =91helper_child=92:
> >> arch/um/os-Linux/helper.c:38:7: warning: ignoring return value of
> >> =91write=92, declared with attribute warn_unused_result
> >=20
> > Same question as before...
>=20
> Same answer is here:)
>=20
> >> Signed-off-by: Vitaliy Ivanov <vitalivanov@gmail.com>
> >> ---
> >>  arch/um/os-Linux/helper.c |    4 ++--
> >>  1 files changed, 2 insertions(+), 2 deletions(-)
> >>=20
> >> diff --git a/arch/um/os-Linux/helper.c b/arch/um/os-Linux/helper.c
> >> index b6b1096..feff22d 100644
> >> --- a/arch/um/os-Linux/helper.c
> >> +++ b/arch/um/os-Linux/helper.c
> >> @@ -28,14 +28,14 @@ static int helper_child(void *arg)
> >>  {
> >>       struct helper_data *data =3D arg;
> >>       char **argv =3D data->argv;
> >> -     int err;
> >> +     int err, ret;
> >>=20
> >>       if (data->pre_exec !=3D NULL)
> >>               (*data->pre_exec)(data->pre_data);
> >>       err =3D execvp_noalloc(data->buf, argv[0], argv);
> >>=20
> >>       /* If the exec succeeds, we don't get here */
> >> -     write(data->fd, &err, sizeof(err));
> >> +     CATCH_EINTR(ret =3D write(data->fd, &err, sizeof(err)));
> >=20
> > Is there really a realistic chance that this write() can be interru=
pted?
> > helper_child() gets called via clone() in run_helper().
>=20
> It's always better not to think whether it's possible but simply kill
> all the chances for this to happen.
> In this case that's pretty trivial thing and also it solves issue wit=
h
> warning.

Defensive programming is not a solution for everything.
CPU time and memory are not for free, especially in kernel land.

Anyway, when this patch removes a real warning, it's fine for me.
Applied.

Thanks,
//richard
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

