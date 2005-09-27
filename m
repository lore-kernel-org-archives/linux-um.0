Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EKJGI-0005xh-0j	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Sep 2005 10:29:02 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EKJGB-0001DD-VY
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Sep 2005 10:29:01 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200509271846.51804.blaisorblade@yahoo.it>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Uml showstopper bugs for 2.6.14
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
Date: Tue, 27 Sep 2005 18:46:50 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>

Here's a short list of showstoppers for 2.6.14 release, from the UML point of 
view.

I and/or Jeff know about them, and Jeff might add some other ones. Also UML 
users are welcome (please in this case, especially if you aren't sure if 
you're experiencing a bug or a setup problem, don't CC directly Andrew 
Morton, but instead give me and Jeff a chance to act as a filter).

I hope so to avoid the situation of 2.6.10 release, when a bunch of important 
fixes was in -mm, targeted at 2.6.10, but was merged *after* 2.6.10. That has 
not happened any more, but 2.6.14 has a shorter release cycle, so I'm 
worried.

I initially read 2.6.14 ETA's was around October 7, when is it now?

However, here we go with the showstoppers (mostly regression):

1) I broke SKAS3 with the last merge. The fix is trivial, I just want to 
stress-test it a bit more this time (and run the original LTP failing test 
case, i.e. copy_from_user(dest, (void*) -1, n)).

2) problems with UBD (i.e. _the_ uml block driver): this is pretty dangerous 
and untrivial to fix, even if the code exists.

DESCRIPTION:
with the UBD rewrite to use AIO merged before 2.6.14-rc1, the UBD driver does 
GFP_KERNEL allocations under spinlocks and can have a deadlock (there's an 
host IPC pipe, whose buffer can get filled causing the kernel to sleep). Jeff 
Dike has the fixes for this, but they're not trivial, so he's working on 
them. I think he could send them to Jens Axboe, when he feels them ready. 
Agreed, Jeff?

3) I've a problem with KBUILD_OUTPUT, just fixed, recently introduced. Going 
to properly test the fix and submit it.

4) Not a regression:
I have a bunch of fixes for HPPFS, which went under a review from Al Viro. I'm 
incorporating his suggestions, but the patches are invasive, so probably it's 
better to defer them to 2.6.15. I'm not sure, though.

Jeff, have you any further notes to add?
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
