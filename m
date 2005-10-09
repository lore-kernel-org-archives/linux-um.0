Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EOggN-0002PC-GM	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Oct 2005 12:18:03 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EOggM-0001Nq-4Y
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Oct 2005 12:18:06 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200510092118.21032.blaisorblade@yahoo.it>
Subject: [uml-devel] Uml left showstopper bugs for 2.6.14
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
Date: Sun, 9 Oct 2005 21:18:20 +0200
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>

Here's a short and updated list of showstoppers for 2.6.14 release, from the 
UML point of view.

It's all things for which we (me and Jeff) have fixes, we are just in the 
progress of cleaning them and/or in the queues.

I initially read 2.6.14 ETA's was around October 7, when is it now?

However, here we go with the showstoppers (mostly regression):

1) problems with UBD (i.e. _the_ uml block driver): this is pretty dangerous 
and untrivial to fix, even if the code exists - so I and Jeff agreed to revert 
the change altogether. Jeff will send the thing.

2) Someone broke endianness of COW driver macros in a header cleanup. I have 
fixes.

3) SKAS0 is broken on amd64 hosts, when frame pointers are disabled. Jeff has 
the fix, waiting end of testing.

4) SKAS0 is broken with GCC 3.2.3, and potentially other GCC releases - look 
at arch/um/include/sysdep-i386/stub.h: stub_syscall*() to see how. I have two 
fixes, choosing the safer one (it's all just simply reusing code from 
<asm/unistd.h>).

5) Compile-time regression with SKAS mode disabled, will fix later (I'm going 
to have dinner now).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
