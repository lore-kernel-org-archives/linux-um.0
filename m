MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1261222401.435.6.camel@localhost>
References: <1261222401.435.6.camel@localhost>
Date: Sun, 20 Dec 2009 10:07:03 +0100
Message-ID: <10f740e80912200107v4ffeee81k77e291ffaebac837@mail.gmail.com>
Subject: Re: [uml-devel] linux-2.6.32 uml Segmentation fault
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: clownix <clownix@clownix.net>, David Howells <dhowells@redhat.com>, James Morris <jmorris@namei.org>, stable <stable@kernel.org>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>, uml-user <user-mode-linux-user@lists.sourceforge.net>, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sat, Dec 19, 2009 at 12:33, clownix <clownix@clownix.net> wrote:
> Hello
> For the 2.6.32 kernel there are 2 problems:
>
> 1: Compile error, this patch works for it:
> --------------------------------------------
>
> diff -Naur old_linux-2.6.32.1/security/keys/keyctl.c
> linux-2.6.32.1/security/keys/keyctl.c
> --- old_linux-2.6.32.1/security/keys/keyctl.c =C2=A0 2009-12-14
> 18:47:25.000000000 +0100
> +++ linux-2.6.32.1/security/keys/keyctl.c =C2=A0 =C2=A0 =C2=A0 2009-12-15=
 22:40:32.565286766
> +0100
> @@ -1236,6 +1236,7 @@
> =C2=A0*/
> =C2=A0long keyctl_session_to_parent(void)
> =C2=A0{
> +#ifdef TIF_NOTIFY_RESUME
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct task_struct *me, *parent;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct cred *mycred, *pcred;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct cred *cred, *oldcred;
> @@ -1326,6 +1327,9 @@
> =C2=A0error_keyring:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0key_ref_put(keyring_r);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> +#else /* !TIF_NOTIFY_RESUME */
> + =C2=A0 =C2=A0 =C2=A0 return -EOPNOTSUPP;
> +#endif /* !TIF_NOTIFY_RESUME */
> =C2=A0}

Aha, UML is also affected.

Commit a00ae4d21b2fa9379914f270ffffd8d3bec55430 ("Keys:
KEYCTL_SESSION_TO_PARENT needs TIF_NOTIFY_RESUME architecture
support") should be in 2.6.32-stable as it fixes a regression, but
apparently the `Cc: stable@kernel.org' got lost?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
							    -- Linus Torvalds

