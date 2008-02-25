Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JTlwQ-0004LX-5U for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Feb 2008 14:36:58 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JTlwO-0006Cg-Kc
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Feb 2008 14:36:57 -0800
Received: from [192.168.0.6] (80-195-236-49.cable.ubr02.camd.blueyonder.co.uk
	[80.195.236.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: antoine@nagafix.co.uk)
	by mail.nagafix.co.uk (Postfix) with ESMTP id 77AD543B5D
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 25 Feb 2008 22:36:52 +0000 (GMT)
Message-ID: <47C34303.7000205@nagafix.co.uk>
Date: Mon, 25 Feb 2008 22:36:51 +0000
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
Subject: [uml-devel] fakehd
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi Jeff,

Can you point me in the right direction for re-enacting the fake ide/hd
stuff?
I've got some images I need to be able to move from real systems to UML
and back - changing the /etc/fstab is just not an option.
It should be fairly simple to register the correct major number to
emulate ide (or even scsi)
Had a play with arch/um/drivers/ubd_kern.c but couldn't get it to work.

Cheers
Antoine
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHw0MDGK2zHPGK1rsRCkDpAKCAk8/rhEfJ+MmGKHlPtQsfQNea6gCfVWMY
BbB5XOhnIPUPe0vfmDonXIg=
=LR6Z
-----END PGP SIGNATURE-----

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
