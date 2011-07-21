MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1311239914-8301-9-git-send-email-richard@nod.at>
References: <1311239914-8301-1-git-send-email-richard@nod.at>
	<1311239914-8301-9-git-send-email-richard@nod.at>
Date: Thu, 21 Jul 2011 11:38:11 +0200
Message-ID: <CAMuHMdUg6xCWFDkN0ApBhPE2Yw4gCcU2Aew60k8J-7oB518FAQ@mail.gmail.com>
Subject: Re: [uml-devel] [PATCH 09/10] um: Ajdust size of pid_buf
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Richard Weinberger <richard@nod.at>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, Jul 21, 2011 at 11:18, Richard Weinberger <richard@nod.at> wrote:
> Linux can have pids up to 4*1024*1024.
> To handle such huge numbers pid_buf needs to be larger.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
> =C2=A0arch/um/drivers/harddog_user.c | =C2=A0 =C2=A02 +-
> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/um/drivers/harddog_user.c b/arch/um/drivers/harddog_use=
r.c
> index b56f8e0..84dce3f 100644
> --- a/arch/um/drivers/harddog_user.c
> +++ b/arch/um/drivers/harddog_user.c
> @@ -32,7 +32,7 @@ int start_watchdog(int *in_fd_ret, int *out_fd_ret, cha=
r *sock)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dog_data data;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int in_fds[2], out_fds[2], pid, n, err;
> - =C2=A0 =C2=A0 =C2=A0 char pid_buf[sizeof("nnnnn\0")], c;
> + =C2=A0 =C2=A0 =C2=A0 char pid_buf[sizeof("nnnnnnn\0")], c;

Why not make it handle the full 32-bit? That's just a few bytes extra
on the stack...

> =C2=A0 =C2=A0 =C2=A0 =C2=A0char *pid_args[] =3D { "/usr/bin/uml_watchdog"=
, "-pid", pid_buf, NULL };
> =C2=A0 =C2=A0 =C2=A0 =C2=A0char *mconsole_args[] =3D { "/usr/bin/uml_watc=
hdog", "-mconsole", NULL,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL };
> --
> 1.7.6

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds

