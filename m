MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20101018114039.503233da.akpm@linux-foundation.org>
References: <1287419814-20086-1-git-send-email-richard@nod.at>
	<20101018114039.503233da.akpm@linux-foundation.org>
Date: Mon, 18 Oct 2010 21:22:31 +0200
Message-ID: <AANLkTimpmcZEV-V6rhZtJXnXLdtB_HRTxM+ExM-YyWmh@mail.gmail.com>
Subject: Re: [uml-devel] [PATCH 1/1] hostfs: fix UML crash
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Richard Weinberger <richard@nod.at>, toralf.foerster@gmx.de, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, viro@zeniv.linux.org.uk
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Mon, Oct 18, 2010 at 20:40, Andrew Morton <akpm@linux-foundation.org> wr=
ote:
> On Mon, 18 Oct 2010 18:36:54 +0200 Richard Weinberger <richard@nod.at> wr=
ote:
>> 365b1818 resized f_spare within struct statfs.
>> hostfs accesses f_spare directly and needs an update.
>>
>> Signed-off-by: Richard Weinberger <richard@nod.at>
>> Reported-by: Toralf F__rster <toralf.foerster@gmx.de>
>> Tested-by: Toralf F__rster <toralf.foerster@gmx.de>
>> ---
>> =C2=A0fs/hostfs/hostfs_user.c | =C2=A0 =C2=A02 +-
>> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/fs/hostfs/hostfs_user.c b/fs/hostfs/hostfs_user.c
>> index 6777aa0..ce2f168 100644
>> --- a/fs/hostfs/hostfs_user.c
>> +++ b/fs/hostfs/hostfs_user.c
>> @@ -388,6 +388,6 @@ int do_statfs(char *root, long *bsize_out, long long=
 *blocks_out,
>> =C2=A0 =C2=A0 =C2=A0 spare_out[1] =3D buf.f_spare[1];
>> =C2=A0 =C2=A0 =C2=A0 spare_out[2] =3D buf.f_spare[2];
>> =C2=A0 =C2=A0 =C2=A0 spare_out[3] =3D buf.f_spare[3];
>> - =C2=A0 =C2=A0 spare_out[4] =3D buf.f_spare[4];
>> +
>> =C2=A0 =C2=A0 =C2=A0 return 0;
>> =C2=A0}
>
> Thanks.
>
> Is there any reason for hostfs to be playing with the f_spare field at al=
l?

It just copies it from struct statfs64 on the host to struct kstatfs
on the guest.
Probably a memcpy() is more future-safe, if it's combined with a
BUILD_BUG_ON(sizeof(statfs64.f_spare) !=3D sizeof(kstatfs.f_spare)).

Still, currently it doesn't copy the recently added f_flags field.
To protect against future changes like that, an explicit
BUILD_BUG_ON(sizeof(kstatfs.f_spare) !=3D 4*sizeof(long)) may be even
better...

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

