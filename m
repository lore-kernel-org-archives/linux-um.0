Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yqwz-0001lG-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 03:51:21 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yqwy-00032b-Rs
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 15 Sep 2003 03:51:21 -0700
Subject: Re: [uml-devel] Re: pthreads?
From: Henrik Nordstrom <hno@marasystems.com>
In-Reply-To: <Pine.GSO.4.21.0309151127130.3302-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0309151127130.3302-100000@vervain.sonytel.be>
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <1063623075.2123.9.camel@henrik.marasystems.com>
Mime-Version: 1.0
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
Date: 15 Sep 2003 12:51:15 +0200
Content-Transfer-Encoding: quoted-printable
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jeff Dike <jdike@addtoit.com>, User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

m=E5n 2003-09-15 klockan 11.28 skrev Geert Uytterhoeven:

> No, UML only _uses_ those symbols, libpthread redefines them in a way that
> breaks UML.

uml redefines several libc symbols which does conflict with pthreads.
The most notable is that uml overrides malloc/free but I think there is
also a few other overrides due to kernel library calls having the same
name as their libc equivalent calls. If you are to link with pthreads
each of these must be verified to be threads safe to the same level as
their libc/pthreads counterpart. On the positive side most kernel lib
calls most likely are threads safe due to the multithreaded nature of
the kernel, but any lib call making use of locking or other kernel
constructs will almost certainly fail or cause problems if ever invoked
from a pthread.

Regards
Henrik

--=20
Henrik Nordstrom <hno@marasystems.com>
MARA Systems AB



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
