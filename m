Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.91] (helo=sc8-sf-mx1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DpVJ5-0008Ru-Hw	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Jul 2005 11:04:35 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1-new.sourceforge.net with smtp (Exim 4.44)
	id 1DpVJ1-0004xx-0e	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Jul 2005 11:04:35 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507042008.39422.blaisorblade@yahoo.it>
Subject: [uml-devel] Updates for 2.6.12 kernel: -bs1, SKAS3-v8 and -v9-pre4
	released
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
Date: Mon, 4 Jul 2005 20:08:38 +0200
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, Antoine Martin <antoine@nagafix.co.uk>

Ok, for SKAS they are just updates, so there's nothing to note (except that 
for now I recommend sticking to -V8 rather than SKAS prereleases; I am 
suspicious of SKAS for the breakpoints problem while debugging UML).

Then, I've included the fix for the recent TT mode problem into -bs1, as 
previously announced. I hope you enjoy it. There's also the HPPFS fix.

Then, I'm going to release a version of the SKAS0 patch 2.6.12, so that it can 
be tested widely. I will include also the list of known bugs with the 
announcement (some of them are fixed by patches still to clean up a bit).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
