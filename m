Return-Path: <david@dit.upm.es>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=iso-8859-1
From: =?iso-8859-1?Q?David_Fern=E1ndez?= <david@dit.upm.es>
In-Reply-To: <CAMuHMdXNJokhVmmAOUgoXynguHUe9fqQ4W7nwx+hkHSy77mVoQ@mail.gmail.com>
Date: Mon, 25 Jun 2012 02:30:17 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <63E079BF-179B-4CE8-BB7D-E215F5DE6433@dit.upm.es>
References: <4FE03E76.7090400@dit.upm.es> <CAFLxGvwqcM4Ajy+DQdpAO8rgc+X_e919_EXKiA8DkTyUQunTOw@mail.gmail.com> <62D36CCF-34D9-4CF9-A563-33D1D5896B73@dit.upm.es> <CAFLxGvxHSwzZe_o=NztS+p=-Sz-MhDqM2MzC-3FsO-bXeENG3Q@mail.gmail.com> <4FE20217.2080101@dit.upm.es> <CAFLxGvw4=mcfqd_0HbP17AR5ZqR-NqMSVgPgFyYamTSu=vgfOQ@mail.gmail.com> <4FE32FBE.4050201@dit.upm.es> <CAFLxGvwE=ecLXN=RLhpSDO9JyDPeS5gr66inS0H2W6soiYUt0A@mail.gmail.com> <CAMuHMdXNJokhVmmAOUgoXynguHUe9fqQ4W7nwx+hkHSy77mVoQ@mail.gmail.com>
Subject: Re: [uml-devel] ubd option parsing problem when using cow filesystems in kernel 3.4
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: richard -rw- weinberger <richard.weinberger@gmail.com>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>


Hi,=20

I have just repeated the git bisect and confirmed that:
- the problem was introduced in 026cee00 =20
- reverting 026cee00 the problem goes away

That commit includes some modifications in kernel/params.c file. =
Probably the bug has been introduced by that modifications.

Best regards,
David


El 21/06/2012, a las 16:49, Geert Uytterhoeven escribi=F3:

> On Thu, Jun 21, 2012 at 4:42 PM, richard -rw- weinberger
> <richard.weinberger@gmail.com> wrote:
>> On Thu, Jun 21, 2012 at 4:29 PM, David Fern=E1ndez <david@dit.upm.es> =
wrote:
>>>=20
>>> What command should I use to revert that specific commit? I'm not an =
expert
>>> in git, in fact I just learnt what a 'git bisect' is after your =
message
>>> ...:-)
>>=20
>> E.g:
>> $ git show 026cee00 > sucker.diff
>> $ patch -p1 -R < sucker.diff
>=20
>    git revert 026cee00
>=20
> or
>=20
>    git revert -n 026cee00
>=20
> if you don't want to commit the revert.
>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- =
geert@linux-m68k.org
>=20
> In personal conversations with technical people, I call myself a =
hacker. But
> when I'm talking to journalists I just say "programmer" or something =
like that.
>                                 -- Linus Torvalds


