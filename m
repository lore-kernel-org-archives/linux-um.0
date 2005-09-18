Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EH036-00054Q-Jh	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Sep 2005 07:21:44 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EH033-0001ea-25
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Sep 2005 07:21:44 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200509181400.39120.blaisorblade@yahoo.it>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Fixing HPPFS
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
Date: Sun, 18 Sep 2005 14:00:38 +0200
To: Antoine Martin <antoine@nagafix.co.uk>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>

Ok, while I was updating hppfs for other things and Al Viro read my patch, he 
went in "Let's check what's left" mode, and discovered a fair amount of crap, 
and requested to fix it - which I've been doing until now.

While looking at it, I also discovered some Oopses fixed in 2.4 and not in 
2.6, and forward ported something else while I was at it.

However, I also had an unconfirmed report from Antoine of some regressions in 
2.6 wrt 2.4 - not better specified, he also talked of a wrong setup so I 
don't know if in the end everything was fixed.

So, I'd like to get these patches reviewed on one side, and tested (from 
Antoine) on the other. When testing, please exclude for now the last patch - 
it's likely to cause more problem than it potentially solves, until reviewed.

Wrapping another FS is funny enough, it seems - especially as no file system 
knows some VFS details, which seem to be totally undocumented.

The code, currently, is totally untested (apart that it compiles).

It seems that the use is simply:

perl honeypot.pl <dir>
it creates <dir>/proc
<run Uml with dir as current directory>
<mount hppfs in /proc>

Ok, nice. I'm going to try it, when I find time (for now I didn't).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
