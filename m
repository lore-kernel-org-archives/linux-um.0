Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vegard.nossum@gmail.com>) id 1a0RGu-0008KX-OP
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Nov 2015 09:49:24 +0000
Received: from mail-pa0-f42.google.com ([209.85.220.42])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1a0RGt-0003Ux-Nd
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Nov 2015 09:49:24 +0000
Received: by pabfh17 with SMTP id fh17so166275753pab.0
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 22 Nov 2015 01:49:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAKD1Yr3CmWnSK8Kp6O90jhaV0UBCwy=qjB-_0noRhZqGE_Jq3g@mail.gmail.com>
References: <56426AED.8030005@nod.at>
	<CAOMGZ=Hz_jBY0rNUDsNUyJBMM1PVFsv2M4O=h-FJNE4GiNMvdA@mail.gmail.com>
	<5651780A.3010302@kot-begemot.co.uk>
	<CAKD1Yr3CmWnSK8Kp6O90jhaV0UBCwy=qjB-_0noRhZqGE_Jq3g@mail.gmail.com>
Date: Sun, 22 Nov 2015 10:49:18 +0100
Message-ID: <CAOMGZ=E+xsDs8nGctsLWDeke45o=L2sUCC9xg-R97P88=dO0sQ@mail.gmail.com>
From: Vegard Nossum <vegard.nossum@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [GIT PULL] UML updates for 4.4-rc1
To: Lorenzo Colitti <lorenzo@google.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On 22 November 2015 at 10:23, Lorenzo Colitti <lorenzo@google.com> wrote:
>
> On Sun, Nov 22, 2015 at 5:08 PM, Anton Ivanov
> <anton.ivanov@kot-begemot.co.uk> wrote:
> > set_timer needs -lrt which the patch adds to the link arguments. For some
> > reason on your config it is not in the correct location in the command line.
> >
> > This is being discussed on the list, lorenzo@google.com was working on a
> > patch.
>
> I sent out the patch a few days ago:
> http://sourceforge.net/p/user-mode-linux/mailman/message/34629247/

That patch fixes the problem for me, thanks!


Vegard

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

