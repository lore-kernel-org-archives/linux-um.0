Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <201105201042.15410.toralf.foerster@gmx.de>
References: <201105191526.31904.toralf.foerster@gmx.de>
	<201105200937.15322.toralf.foerster@gmx.de>
	<BANLkTik0oz6ppJvRpufaaiBL1pqcAxNHuA@mail.gmail.com>
	<201105201042.15410.toralf.foerster@gmx.de>
Date: Fri, 20 May 2011 18:24:56 +0200
Message-ID: <BANLkTikfaKJfnDwQoFi9WLX6q+2HHe90HQ@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: kernel 2.6.39 (user mode linux) crashes (2.6.38 works fine)
To: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

2011/5/20 Toralf F=F6rster <toralf.foerster@gmx.de>:
>
> richard -rw- weinberger wrote at 09:56:02
>> 2011/5/20 Toralf F=F6rster <toralf.foerster@gmx.de>:
>> > ...
>> > Kernel panic - not syncing: Kernel mode fault at addr 0x0, ip 0x80=
a9f6b
>>
>> Looks like a NULL-pointer bug.
>> What code is at address 80a9f6b?
>> Use "objdump -d -S | less" to find it.
> =A0 =A0 =A0 =A0if (unlikely(ret !=3D 0))
> =A080a9f3a: =A0 =A0 =A0 85 c0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tes=
t =A0 %eax,%eax
> =A080a9f3c: =A0 =A0 =A0 75 ca =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 jne=
 =A0 =A080a9f08 <futex_wake+0x18>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
>
> =A0 =A0 =A0 =A0hb =3D hash_futex(&key);
> =A080a9f3e: =A0 =A0 =A0 8d 45 e8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0lea =A0=
 =A0-0x18(%ebp),%eax
> =A080a9f41: =A0 =A0 =A0 e8 aa f6 ff ff =A0 =A0 =A0 =A0 =A0call =A0 80=
a95f0 <hash_futex>
> =A080a9f46: =A0 =A0 =A0 89 c2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mov=
 =A0 =A0%eax,%edx
> =A0 =A0 =A0 =A0spin_lock(&hb->lock);
> =A0 =A0 =A0 =A0head =3D &hb->chain;
>
> =A0 =A0 =A0 =A0plist_for_each_entry_safe(this, next, head, list) {
> =A080a9f48: =A0 =A0 =A0 8b 48 08 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mov =A0=
 =A00x8(%eax),%ecx
> =A080a9f4b: =A0 =A0 =A0 83 c2 08 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0add =A0=
 =A0$0x8,%edx
> =A080a9f4e: =A0 =A0 =A0 8d 41 f4 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0lea =A0=
 =A0-0xc(%ecx),%eax
> =A080a9f51: =A0 =A0 =A0 39 ca =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmp=
 =A0 =A0%ecx,%edx
> =A080a9f53: =A0 =A0 =A0 8b 70 0c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mov =A0=
 =A00xc(%eax),%esi
> =A080a9f56: =A0 =A0 =A0 74 6a =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 je =
=A0 =A0 80a9fc2 <futex_wake+0xd2>
> =A080a9f58: =A0 =A0 =A0 89 d9 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mov=
 =A0 =A0%ebx,%ecx
> =A080a9f5a: =A0 =A0 =A0 83 ee 0c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sub =A0=
 =A0$0xc,%esi
> =A080a9f5d: =A0 =A0 =A0 89 d3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mov=
 =A0 =A0%edx,%ebx
> =A080a9f5f: =A0 =A0 =A0 89 fa =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mov=
 =A0 =A0%edi,%edx
> =A080a9f61: =A0 =A0 =A0 89 cf =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mov=
 =A0 =A0%ecx,%edi
> =A080a9f63: =A0 =A0 =A0 eb 12 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 jmp=
 =A0 =A080a9f77 <futex_wake+0x87>
> =A080a9f65: =A0 =A0 =A0 8d 76 00 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0lea =A0=
 =A00x0(%esi),%esi
> =A080a9f68: =A0 =A0 =A0 8d 46 0c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0lea =A0=
 =A00xc(%esi),%eax
> =A080a9f6b: =A0 =A0 =A0 8b 4e 0c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mov =A0=
 =A00xc(%esi),%ecx


Here in futex_wake() happens a NULL pointer dereference.
Steve, any ideas?

--=20
Thanks,
//richard
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

