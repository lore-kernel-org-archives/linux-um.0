Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1SEIOs-0002TG-P0
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Apr 2012 10:52:47 +0000
Received: from mail-lpp01m010-f47.google.com ([209.85.215.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1SEIOs-0008Ct-0a
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Apr 2012 10:52:46 +0000
Received: by lagw12 with SMTP id w12so3126411lag.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 01 Apr 2012 03:52:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201204011009.38287.toralf.foerster@gmx.de>
References: <201204011009.38287.toralf.foerster@gmx.de>
Date: Sun, 1 Apr 2012 12:52:39 +0200
Message-ID: <CAFLxGvw+O8JRkdf4ovxF-Kbi5o_fPf5KX28M+es4ViOFYvcarA@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] 3 cc warnings while compiling an UML kernel
To: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

2012/4/1 Toralf F=F6rster <toralf.foerster@gmx.de>:
> Hello,
>
> today I build an UML kernel with 3.4-rc1 sources and got the follwoing co=
mpile warnings :
>
> arch/um/kernel/skas/mmu.c: In function =91uml_setup_stubs=92:
> arch/um/kernel/skas/mmu.c:106:16: warning: unused variable =91pages=92

A fix for this has already been posted.
It's queued for -rc2

> security/keys/keyctl.c: In function =91keyctl_session_to_parent=92:
> security/keys/keyctl.c:1520:2: warning: #warning TIF_NOTIFY_RESUME not im=
plemented
>
> fs/nfs/nfs4xdr.c: In function =91encode_exchange_id.clone.78=92:
> fs/nfs/nfs4xdr.c:1718:1: warning: the frame size of 1036 bytes is larger =
than 1024 bytes
>

Don't know whether these two are UML specific.
I'll look at it.

-- =

Thanks,
//richard

---------------------------------------------------------------------------=
---
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here =

http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

