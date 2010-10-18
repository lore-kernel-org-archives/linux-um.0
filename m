Return-Path: <richard.weinberger@gmail.com>
MIME-Version: 1.0
In-Reply-To: <AANLkTik0dP0hs-a6ofna_UFk8dbzfqzPwD5OzDVhPGBV@mail.gmail.com>
References: <201010131328.06465.toralf.foerster@gmx.de>
	<201010171555.40453.toralf.foerster@gmx.de>
	<20101017201837.GA16458@lst.de>
	<201010181105.17077.toralf.foerster@gmx.de>
	<AANLkTik0dP0hs-a6ofna_UFk8dbzfqzPwD5OzDVhPGBV@mail.gmail.com>
Date: Mon, 18 Oct 2010 11:16:10 +0200
Message-ID: <AANLkTikDc+Gv=L-38cTUzZHWSib5tabvxAjR7GLAMU9c@mail.gmail.com>
Subject: Re: [uml-devel] Fwd: Re: UML kernel crash of v2.6.36-rcX kernel
From: richard -rw- weinberger <richard.weinberger@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>, Christoph Hellwig <hch@lst.de>, Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Al Viro <viro@zeniv.linux.org.uk>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

2010/10/18 Geert Uytterhoeven <geert@linux-m68k.org>:
> 2010/10/18 Toralf F=F6rster <toralf.foerster@gmx.de>:
>> Well, in addition to my last mail the following patch isn't a fix, but i=
t
>> might point to the culprit.
>> If I apply this patch against latest tree, then the crash doesn't occur =
:
>>
>> diff --git a/include/linux/statfs.h b/include/linux/statfs.h
>> index 0166d32..e336e70 100644
>> --- a/include/linux/statfs.h
>> +++ b/include/linux/statfs.h
>> @@ -15,8 +15,8 @@ struct kstatfs {
>> =A0 =A0 =A0 =A0__kernel_fsid_t f_fsid;
>> =A0 =A0 =A0 =A0long f_namelen;
>> =A0 =A0 =A0 =A0long f_frsize;
>> - =A0 long f_flags;
>> =A0 =A0 =A0 =A0long f_spare[4];
>> + long f_flags;
>> =A0};
>
> So it probably is accessing f_spare[4] somewhere...

fs/hostfs/hostfs_user.c does so.
I'll look at this when I'm at home.

Toralf, are you using hostfs?

> Gr{oetje,eeting}s,
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0 =A0=A0 -- Linu=
s Torvalds
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>



--=20
Thanks,
//richard

