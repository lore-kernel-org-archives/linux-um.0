Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FlU28-0002w8-9W for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 31 May 2006 09:59:00 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FlU28-0006k6-Ea for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 31 May 2006 09:59:00 -0700
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FlU24-0005G3-MI
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 31 May 2006 09:59:00 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605302013.00091.blaisorblade@yahoo.it>
Subject: [uml-devel] Randomize on MAC address when bringing up ethernet iface
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
Date: Tue, 30 May 2006 20:12:59 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

I've being thinking to this and I'm wondering why we shouldn't do it. When we 
have set no IP or 0.0.0.0, which is not a unique IP, and we bring it up, we 
should choose a random MAC to use.
Conditions: the broadcast bit must be 0 and the "locally-assigned address 
flag" must be 1 (as likely we already do).

For which bits they are, I've a doubt.
On Tanenbaum's book they're marked as the two most significant (leftmost) bits 
(broadcast being the most significant one), but since we've longly known the 
broadcast bit is the lowest-order one of the highest bit, I suspect that MACs 
are read in little-endian bit order (which likely implies the same for the 
whole packets). I can't verify this, but bytes in many fields are moved to be 
in network order i.e. big-endian order (MACs are always used in the network 
order).

So possibly bit-swap is also used before going on the wire.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 



-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
