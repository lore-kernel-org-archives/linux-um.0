Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19zaA0-0008Tm-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 17 Sep 2003 04:07:48 -0700
Received: from stoneboat.bytemark.co.uk ([212.13.198.52])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19za9y-0001pZ-6s
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 17 Sep 2003 04:07:46 -0700
From: Matthew Bloch <matthew@bytemark.co.uk>
Message-ID: <20030917110739.GA3261@geri.office.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
Subject: [uml-devel] Hang in munmap using 2.4.22-djc2
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 17 Sep 2003 12:07:39 +0100
To: user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

A customer seems to have set his machine up in such a way to trigger this
bug reliably.  It boots up to the login prompt and then a few seconds later
is frozen from the outside, stops responding to ARPs, starts using 100% CPU
on the host; backtrace looks like this:

(gdb) bt
#0  0xa00020c1 in munmap ()
#1  0xa01b7e27 in os_unmap_memory (addr=0x0, len=0) at process.c:128
Cannot access memory at address 0xa48ed000

Can I supply any more helpful information to track this down, or (Jeff) do
you want access to the host machine in question to have a look?

cheers,

- -- 
Matthew Bloch                             Bytemark Hosting
                                  tel. +44 (0) 8707 455026
                        http://www.bytemark-hosting.co.uk/
          Dedicated Linux hosts from 15ukp ($26) per month
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/aEB7T2rVDg8aLXQRApJkAJ9JkERVBPs9vUncFGofZnsmrqc/xwCghZrc
oyczOSf3tYv4d/sWRKd90fI=
=3A95
-----END PGP SIGNATURE-----


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
