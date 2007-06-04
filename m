Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HvA7u-0001AI-Uf for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Jun 2007 03:49:30 -0700
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HvA7t-0005vE-CY
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Jun 2007 03:49:30 -0700
Message-ID: <4663EE2F.9050302@nagafix.co.uk>
Date: Mon, 04 Jun 2007 11:49:19 +0100
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
References: <dec0fd580706032228o64eb38f3t1f033db768d175db@mail.gmail.com>
In-Reply-To: <dec0fd580706032228o64eb38f3t1f033db768d175db@mail.gmail.com>
Subject: Re: [uml-devel] Query ....
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
To: battipatisainagendra Bhavaniprasad <sainagendrabhavaniprasad@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

battipatisainagendra Bhavaniprasad wrote:
> I have been beating my head against the wall trying to get a working UML for several days, so any help is greatly appreciated!I have downloaded
> "linux-2.6.16.tar" (which has UML patch In built) followed by the commands.....
> 
> 
> make defconfig ARCH=um
> 
> make ARCH=um
> 
> but i am getting the following errors...
> 
> arch/um/os-Linux/sys-i386/registers.c: In function 'get_thread_regs':
> 
> arch/um/os-Linux/sys-i386/registers.c:137: error: 'JB_PC' undeclared (first use in this function)
> arch/um/os-Linux/sys-i386/registers.c:137: error: (Each undeclared identifier is reported only once
> arch/um/os-Linux/sys-i386/registers.c:137: error: for each function it appears in.)
> 
> arch/um/os-Linux/sys-i386/registers.c:138: error: 'JB_SP' undeclared (first use in this function)
> arch/um/os-Linux/sys-i386/registers.c:139: error: 'JB_BP' undeclared (first use in this function)
> make[2]: *** [arch/um/os-Linux/sys-i386/registers.o] Error 1
> 
> make[1]: *** [arch/um/os-Linux/sys-i386] Error 2
> 
> Please help me.....
Search the archives, this problem was discussed before and there is a
patch for it.
But the easiest way to fix it is to use something more recent.
Try 2.6.21.3

Antoine



> 
> rgds,
> Prasad.
> 
> 
> 
> 
> ------------------------------------------------------------------------
> 
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGY+4vGK2zHPGK1rsRCvPbAJ9W7H1OBtp2Vi67VF5hyLVcQJaEfACfXtx3
biMqgPVjDH28dXcyKdlpAWc=
=g7p7
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
