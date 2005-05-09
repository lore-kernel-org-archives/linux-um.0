Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DVHZ8-0002Xs-0c	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 May 2005 16:21:34 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DVHZ2-0006Ub-PQ	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 May 2005 16:21:33 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505100110.16920.blaisorblade@yahoo.it>
Subject: [uml-devel] [patch 0/6] latest bugfixes for 2.6.12
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
Date: Tue, 10 May 2005 01:10:15 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

Here are some more fixes intended for 2.6.12 (and well tested). Can you merge 
them soon, Andrew? Thanks.

The first is a particularly bad one since it shows up when you *start* 
compiling UML (due to a quilt patch -> normal patch conversion problem, a 
file wasn't actually deleted, but it was when applied through quilt). Was 
this too quick a merge, maybe? What's your "merging policy" (if any) for 
patches?

Also, I had marked some of the patches I sent as needing some staging time in 
-mm (especially "uml: redo console locking"), while I had marked other ones 
as needing immediate merge. Jeff instead has sent some "cleanup / groundwork 
for future work" (which anyway were mostly trivial) together with some urgent 
fixes.

Actually they aren't a problem (especially because UML has almost no support 
for SMP) however this policy risks breaking things.

We had the exactly opposite problem for 2.6.10 release - some important fixes 
which were sent by Jeff just before 2.6.10 release to be merged in it (but 
which weren't explicitly marked as such) were merged in 2.6.10-mm1.
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
