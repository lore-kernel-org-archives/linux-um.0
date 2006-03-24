Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMcnt-0005oA-SR for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Mar 2006 19:17:33 -0800
Received: from zproxy.gmail.com ([64.233.162.195])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FMcnr-0001bp-Ic
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Mar 2006 19:17:33 -0800
Received: by zproxy.gmail.com with SMTP id n29so644820nzf
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 23 Mar 2006 19:17:30 -0800 (PST)
Message-ID: <442365B7.1010501@gmail.com>
From: Mikado <mikado4vn@gmail.com>
Reply-To: mikado4vn@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] bug: lsattr on mount point using hostfs - kernel panic
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 24 Mar 2006 10:21:27 +0700
To: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I 'chattr +i' /mnt/a and mount (using hostfs) it on UML /mnt/b then
'lsattr' /mnt/b on UML will panic the kernel.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEI2W3NWc9T2Wr2JcRAjTKAKClaWX8lOGrcdXuwXOWebZGRd6/OwCfarl0
4OAi21FAL2axZHEykJL1HLQ=
=U7yP
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
