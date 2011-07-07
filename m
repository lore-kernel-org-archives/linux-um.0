Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1310011371.3309.2.camel@offbook>
References: <1310011371.3309.2.camel@offbook>
Date: Thu, 7 Jul 2011 16:08:22 +0300
Message-ID: <CAGTPOqdm7_PP68mKLQT3gigmUMD6wpoKk3sSWfXk9jeJPX+_6A@mail.gmail.com>
From: Vitaliy Ivanov <vitalivanov@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] uml: free resources
To: dave@gnu.org
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, uml <user-mode-linux-devel@lists.sourceforge.net>, lkml <linux-kernel@vger.kernel.org>, Jim Meyering <meyering@redhat.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, Jul 7, 2011 at 7:02 AM, Davidlohr Bueso <dave@gnu.org> wrote:
> From: Davidlohr Bueso <dave@gnu.org>
>
> When creating the temp file there's a memory and file descriptor leak=
 upon error.
>
> Signed-off-by: Davidlohr Bueso <dave@gnu.org>
> ---
> =A0arch/um/os-Linux/mem.c | =A0 =A06 ++++--
> =A01 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/um/os-Linux/mem.c b/arch/um/os-Linux/mem.c
> index e696144..62878cf 100644
> --- a/arch/um/os-Linux/mem.c
> +++ b/arch/um/os-Linux/mem.c
> @@ -176,7 +176,7 @@ static int __init make_tempfile(const char *templ=
ate, char **out_tempname,
>
> =A0 =A0 =A0 =A0find_tempdir();
> =A0 =A0 =A0 =A0if ((tempdir =3D=3D NULL) || (strlen(tempdir) >=3D MAX=
PATHLEN))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>
> =A0 =A0 =A0 =A0if (template[0] !=3D '/')
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strcpy(tempname, tempdir);
> @@ -191,13 +191,15 @@ static int __init make_tempfile(const char *tem=
plate, char **out_tempname,
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0if (do_unlink && (unlink(tempname) < 0)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0perror("unlink");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto close;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0if (out_tempname) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*out_tempname =3D tempname;
> =A0 =A0 =A0 =A0} else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free(tempname);
> =A0 =A0 =A0 =A0return fd;
> +close:
> + =A0 =A0 =A0 close(fd);
> =A0out:
> =A0 =A0 =A0 =A0free(tempname);
> =A0 =A0 =A0 =A0return -1;
> --

Reviewed-by: Vitaliy Ivanov <vitalivanov@gmail.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

