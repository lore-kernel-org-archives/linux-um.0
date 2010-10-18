Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <richard.weinberger@gmail.com>) id 1P7lOP-0002Ke-Nk
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 Oct 2010 08:48:29 +0000
Received: from mail-qy0-f182.google.com ([209.85.216.182])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P7lOO-0003Y9-Uf for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 Oct 2010 08:48:29 +0000
Received: by qyk30 with SMTP id 30so667292qyk.13
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 18 Oct 2010 01:48:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201010181043.14253.toralf.foerster@gmx.de>
References: <201010131328.06465.toralf.foerster@gmx.de>
	<201010171555.40453.toralf.foerster@gmx.de>
	<20101017201837.GA16458@lst.de>
	<201010181043.14253.toralf.foerster@gmx.de>
Date: Mon, 18 Oct 2010 10:48:23 +0200
Message-ID: <AANLkTimQQyYJorR81pt7Y7L8ru7OfPfzBtrT7FeA6m6W@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
Subject: Re: [uml-devel] Fwd: Re: UML kernel crash of v2.6.36-rcX kernel
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Richard Weinberger <richard@nod.at>, Christoph Hellwig <hch@lst.de>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

2010/10/18 Toralf F=F6rster <toralf.foerster@gmx.de>:
>
> Christoph Hellwig wrote at 22:18:37
>> I really can't see any relation to the patch. =A0Can you try the some
>> things in the following order, please:
> ...
>> =A0(4) re-apply the include/linux/statfs.h changes and see if it still
>> =A0 =A0 =A0 boots
>
> The first half of step 4 was it (I did not apply the "Definitions for the=
 flag
> in f_flag.") :
>
> diff --git a/include/linux/statfs.h b/include/linux/statfs.h
> index b34cc82..0166d32 100644
> --- a/include/linux/statfs.h
> +++ b/include/linux/statfs.h
> @@ -2,7 +2,6 @@
> =A0#define _LINUX_STATFS_H
>
> =A0#include <linux/types.h>
> -
> =A0#include <asm/statfs.h>
>
> =A0struct kstatfs {
> @@ -16,7 +15,29 @@ struct kstatfs {
> =A0 =A0 =A0 =A0__kernel_fsid_t f_fsid;
> =A0 =A0 =A0 =A0long f_namelen;
> =A0 =A0 =A0 =A0long f_frsize;
> - =A0 long f_spare[5];
> + long f_flags;
> + long f_spare[4];
> =A0};
>
>
>
> FWIW the uml kernel boots fine even with that commit however it crashed a=
fter
> a special http request : $> wget http://n22_uml/phpsysinfo/

Find out _what_ phpsysinfo does.
On my test bed phpsysinfo works fine, I cannot reproduce the crash.
We need more details.

> --
> MfG/Kind regards
> Toralf F=F6rster
>
> pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>



-- =

Thanks,
//richard

---------------------------------------------------------------------------=
---
Download new Adobe(R) Flash(R) Builder(TM) 4
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly =

Flex(R) Builder(TM)) enable the development of rich applications that run
across multiple browsers and platforms. Download your free trials today!
http://p.sf.net/sfu/adobe-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

