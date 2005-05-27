Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DbTD4-0006AJ-3g	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 May 2005 18:00:22 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DbTCz-0003xr-Tc	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 May 2005 18:00:21 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505270302.07501.blaisorblade@yahoo.it>
Subject: [uml-devel] [patch 0/8] uml: some fixes for 2.6.12
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
Date: Fri, 27 May 2005 03:02:06 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Now I'm sending some other fixes intended for 2.6.12... they are either very 
simple or potentially critical (as the PREEMPT_ACTIVE fix). Some of these 
are/were still in -mm queue, but since they seem to have been dropped and 
anyway haven't been merged, I'm resending them anyway.

Also, we have one big 2.6.10 regression which is still unfixed: top always 
shows ksoftirqd/0 as runnable, while it gets 0% cpu time, and loadavg goes 
then to 1.0, while no real load is generated...

Possible culprits could be the IRQ code rewrite, maybe; I've not found what 
the hell can be arch-specific for this (except that UML does not support 
PREEMPT and that SMP, and locking in general, isn't well tested yet, even if 
the biggest problems are just theoretical, luckily).

I've not yet had the time to analyze it successfully (but while looking at 
this I saw the PREEMPT_ACTIVE problem, which also extends to other archs, see 
my other mail).
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
