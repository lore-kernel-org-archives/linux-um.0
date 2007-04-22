Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hfh25-0001w4-87 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Apr 2007 11:43:33 -0700
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hfh22-0000IM-T7
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Apr 2007 11:43:33 -0700
Received: from [192.168.0.6] (82-45-252-239.cable.ubr02.camd.blueyonder.co.uk
	[82.45.252.239])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: antoine@nagafix.co.uk)
	by mail.nagafix.co.uk (Postfix) with ESMTP id 97CE2C7A78
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 22 Apr 2007 19:43:22 +0100 (BST)
Message-ID: <462BACC9.7010303@nagafix.co.uk>
Date: Sun, 22 Apr 2007 19:43:21 +0100
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
Subject: [uml-devel] regression: pcap broken in 2.6.20.x
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: UML devel <user-mode-linux-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Using the exact same kernel config with 2.6.19.x works but not with 2.6.20.x

# ifconfig eth1 0.0.0.0 promisc up
SIOCSIFADDR: No such device
eth1: unknown interface: No such device
eth1: unknown interface: No such device
eth1: unknown interface: No such device

Antoine
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGK6zIGK2zHPGK1rsRCvlWAJ4mPnP1dQQgol4Bpx4+CFt/bnEHOgCfQfDC
7KG75RhnxZiS98gsVA+nURE=
=wsN+
-----END PGP SIGNATURE-----

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
