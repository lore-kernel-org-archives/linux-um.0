Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EQk9n-0006Ym-DQ	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 15 Oct 2005 04:24:55 -0700
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EQk9i-0001Oc-RY
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 15 Oct 2005 04:24:55 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510151325.50461.blaisorblade@yahoo.it>
Subject: [uml-devel] 2.6.13.4-bs4 released - fixes for SKAS0 problems -
	careful about COW
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
Date: Sat, 15 Oct 2005 13:25:49 +0200
To: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net, Kai Tan <mineown@hotmail.com>
Cc: Jeff Dike <jdike@addtoit.com>, Nix <nix@esperi.org.uk>

Ok, I've batched together the existing fixes and released -bs4.
It's really nice, it fixes various problems, as indicated on the website. But 
it also restores the 2.6.12 COW format (see below) - so please beware to your 
COW files!

Changelog follows

* -bs3 didn't apply on top of 2.6.13.3, because one of his patches was merged 
in it. So remove it from -bs. 

* CAREFUL : 2.6.13 kernel changed the COW format from all previous kernels in 
an unintended way (and it wasn't our fault). -bs4 restores the previous 
format, but this means you likely won't be able to use the same COW files 
when switching from any 2.6.13 to -bs4; but -bs4 has the same format as any 
<= 2.6.12 or >= 2.6.14 UML kernel. 

*  fix compilation of UML on x86_64 with SKAS0 

* fix compilation of UML on i386 without SKAS mode 

* fix SKAS0 mode assembly code - this could stop it from working on some old 
GCC compilers (this happened, for instance, on GCC 3.2.3, and on RH 9).

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________
Yahoo! Mail -  proteggi la tua casella di posta da virus
e posta indesiderata
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
