MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <CAFLxGvwE=ecLXN=RLhpSDO9JyDPeS5gr66inS0H2W6soiYUt0A@mail.gmail.com>
References: <4FE03E76.7090400@dit.upm.es>
	<CAFLxGvwqcM4Ajy+DQdpAO8rgc+X_e919_EXKiA8DkTyUQunTOw@mail.gmail.com>
	<62D36CCF-34D9-4CF9-A563-33D1D5896B73@dit.upm.es>
	<CAFLxGvxHSwzZe_o=NztS+p=-Sz-MhDqM2MzC-3FsO-bXeENG3Q@mail.gmail.com>
	<4FE20217.2080101@dit.upm.es>
	<CAFLxGvw4=mcfqd_0HbP17AR5ZqR-NqMSVgPgFyYamTSu=vgfOQ@mail.gmail.com>
	<4FE32FBE.4050201@dit.upm.es>
	<CAFLxGvwE=ecLXN=RLhpSDO9JyDPeS5gr66inS0H2W6soiYUt0A@mail.gmail.com>
Date: Thu, 21 Jun 2012 16:49:28 +0200
Message-ID: <CAMuHMdXNJokhVmmAOUgoXynguHUe9fqQ4W7nwx+hkHSy77mVoQ@mail.gmail.com>
Subject: Re: [uml-devel] ubd option parsing problem when using cow filesystems
 in kernel 3.4
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: =?UTF-8?Q?David_Fern=C3=A1ndez?= <david@dit.upm.es>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, Jun 21, 2012 at 4:42 PM, richard -rw- weinberger
<richard.weinberger@gmail.com> wrote:
> On Thu, Jun 21, 2012 at 4:29 PM, David Fern=C3=A1ndez <david@dit.upm.es> =
wrote:
>>
>> What command should I use to revert that specific commit? I'm not an exp=
ert
>> in git, in fact I just learnt what a 'git bisect' is after your message
>> ...:-)
>
> E.g:
> $ git show 026cee00 > sucker.diff
> $ patch -p1 -R < sucker.diff

    git revert 026cee00

or

    git revert -n 026cee00

if you don't want to commit the revert.

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

