Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <201010181105.17077.toralf.foerster@gmx.de>
References: <201010131328.06465.toralf.foerster@gmx.de>
	<201010171555.40453.toralf.foerster@gmx.de>
	<20101017201837.GA16458@lst.de>
	<201010181105.17077.toralf.foerster@gmx.de>
Date: Mon, 18 Oct 2010 11:31:31 +0200
Message-ID: <AANLkTi=UyWg6PUrE_jEs0oqZ_tVw1mMQsoUrDnnqtcHa@mail.gmail.com>
Subject: Re: Fwd: Re: UML kernel crash of v2.6.36-rcX kernel
From: richard -rw- weinberger <richard.weinberger@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
Cc: Christoph Hellwig <hch@lst.de>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>, Al Viro <viro@zeniv.linux.org.uk>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

2010/10/18 Toralf F=EF=BF=BDrster <toralf.foerster@gmx.de>:
> Well, in addition to my last mail the following patch isn't a fix, but it
> might point to the culprit.
> If I apply this patch against latest tree, then the crash doesn't occur :
>
> diff --git a/include/linux/statfs.h b/include/linux/statfs.h
> index 0166d32..e336e70 100644
> --- a/include/linux/statfs.h
> +++ b/include/linux/statfs.h
> @@ -15,8 +15,8 @@ struct kstatfs {
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BD__kernel_fsid_t f_fsid;
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDlong f_namelen;
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDlong f_frsize;
> - =EF=BF=BD long f_flags;
> =EF=BF=BD =EF=BF=BD =EF=BF=BD =EF=BF=BDlong f_spare[4];
> + long f_flags;
> =EF=BF=BD};
>
>
>
> Christoph Hellwig wrote at 22:18:37
>> On Sun, Oct 17, 2010 at 03:55:39PM +0200, Toralf F?rster wrote:
>> > I bisected it again w/ a fixed test script, got the same bad commit
>> > script and double checked, that this commit is really the culprit which
>> > crashes a user mode linux kernel at my 32bix x86 stable Gentoo running
>> > 2.6.35.6 vanilla kernel as host system and 2/ gcc version 4.4.3 (Gentoo
>> > 4.4.3-r2 p1.2) and glibc-2.11.2-r1 in the tool chain.
>>
>> I really can't see any relation to the patch. =EF=BF=BDCan you try the s=
ome
>> things in the following order, please:
>>
>> =EF=BF=BD(1) git-revert 365b18189789bfa1acd9939e6312b8a4b4577b28 on curr=
ent
>> =EF=BF=BD =EF=BF=BD =EF=BF=BDLinus tree and see it it works.
>> =EF=BF=BD =EF=BF=BD =EF=BF=BDIf it works try the next, else the bisect m=
ust have been a weird
>> =EF=BF=BD =EF=BF=BD =EF=BF=BDconicidence and I can't really help more.
>> =EF=BF=BD(2) re-apply only the changes to include/asm-generic/statfs.h f=
rom
>> =EF=BF=BD =EF=BF=BD =EF=BF=BD365b18189789bfa1acd9939e6312b8a4b4577b28 an=
d see if that still
>> =EF=BF=BD =EF=BF=BD =EF=BF=BDboots.
>> =EF=BF=BD(3) re-apply the arch/mips/include/asm/statfs.h and
>> =EF=BF=BD =EF=BF=BD =EF=BF=BDarch/s390/include/asm/statfs.h changes and =
see if it still boots
>> =EF=BF=BD(4) re-apply the include/linux/statfs.h changes and see if it s=
till
>> =EF=BF=BD =EF=BF=BD =EF=BF=BD boots
>> =EF=BF=BD(5) re-apply the fs/statfs.c changes, and by now it really shou=
ldn't
>> =EF=BF=BD =EF=BF=BD =EF=BF=BDboot anymore
>> =EF=BF=BD(6) verify the code really is the same again as in current Linu=
s' tree
>
>
> --
> MfG/Kind regards
> Toralf F=EF=BF=BDrster
>
> pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =EF=BF=BDhttp://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =EF=BF=BDhttp://www.tux.org/lkml/
>

Does this help?

--- linux-2.6.36-rc8/fs/hostfs/hostfs_user.c.orig       2010-10-18
11:24:33.844592000 +0200
+++ linux-2.6.36-rc8/fs/hostfs/hostfs_user.c    2010-10-18
11:24:44.594679000 +0200
@@ -388,6 +388,6 @@
        spare_out[1] =3D buf.f_spare[1];
        spare_out[2] =3D buf.f_spare[2];
        spare_out[3] =3D buf.f_spare[3];
-       spare_out[4] =3D buf.f_spare[4];
+
        return 0;
 }

--=20
Thanks,
//richard
