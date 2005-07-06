Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.91] (helo=sc8-sf-mx1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DqEHJ-0001ru-7D	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Jul 2005 11:05:45 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1-new.sourceforge.net with smtp (Exim 4.44)
	id 1DqEHG-0007a6-Pi	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Jul 2005 11:05:45 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507062011.58619.blaisorblade@yahoo.it>
Subject: [uml-devel] SKAS0 test tree against 2.6.12
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
Date: Wed, 6 Jul 2005 20:11:58 +0200
To: user-mode-linux-devel@lists.sourceforge.net, Rob Landley <rob@landley.net>
Cc: user-mode-linux-user@lists.sourceforge.net

Ok, it's there. I've simply adapted the two SKAS0 patches for 2.6.12 
(backporting a cleanup and fixing some trivial rejects). More info at the web 
page.

Testing is welcome. In particular, any regression in SKAS3 mode should be 
prompty reported to me and Jeff, because they are not expected at all.

I'll add a simplified "proc_mm=0" switch (it's not the Bodo's patch because 
that is more intrusive and splits that further into proc_mm and faultinfo 
switches).

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
