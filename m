Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HvuFQ-0000Dx-Ms for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Jun 2007 05:04:20 -0700
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HvuFP-0000Lq-7B
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Jun 2007 05:04:20 -0700
Message-ID: <4666A2BA.8000301@nagafix.co.uk>
Date: Wed, 06 Jun 2007 13:04:10 +0100
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
References: <dec0fd580706060422w255ea6e9l52d6f6784252814b@mail.gmail.com>
In-Reply-To: <dec0fd580706060422w255ea6e9l52d6f6784252814b@mail.gmail.com>
Subject: Re: [uml-devel] doubt regarding UML instlation please help me.
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
Cc: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

[snip]
> arch/um/os-Linux/sys-i386/registers.c:139: error: 'JB_BP' undeclared
> (first use in this function)
> 
> make[2]: *** [arch/um/os-Linux/sys-i386/registers.o] Error 1
> 
> make[1]: *** [arch/um/os-Linux/sys-i386] Error 2
> 
> 
> next i went with the latest kernel i.e..linux-2.6.21.tar.bz2
> but when i run command i.e...make ARCH=um
> 
> it's going on exexuting the same sequence of things....finally i could
> NOT get the linux bin image.
> 
> 
> please suggest me which kernel mirror to use which has already uml
> patch built in....
Try this:

http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.17/patches/jmpbuf

Antoine
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGZqK6GK2zHPGK1rsRCmiZAJ9dpqlC1yk7Ikc0t1jT3dgKUih2OACeKtW/
zjnT6NYYv8CKgsZalZzpdbU=
=O+VI
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
