Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CR8dE-0003W3-Vo for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 Nov 2004 04:28:24 -0800
Received: from main.gmane.org ([80.91.229.2])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CR8dD-0006mX-Df for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 Nov 2004 04:28:24 -0800
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1CR8dB-0007XP-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 08 Nov 2004 13:28:21 +0100
Received: from naked.iki.fi ([62.142.249.112])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 08 Nov 2004 13:28:20 +0100
Received: from naked by naked.iki.fi with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 08 Nov 2004 13:28:20 +0100
From: Nuutti Kotivuori <naked@iki.fi>
Message-ID: <871xf4a5kc.fsf@aka.i.naked.iki.fi>
References: <200411041932.39733.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [uml-devel] Re: 2.6.9-bb1, 2.4.27-bs1, SKAS3/2.6-V7 released
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
Date: Mon, 08 Nov 2004 14:28:03 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, user-mode-linux-user@lists.sourceforge.net

Blaisorblade wrote:
> Changes in both 2.6.9 and 2.4.27:
> they run fine on 2.6.9 host kernels, without hanging at the exit.

I want to get this clear:

Every older guest UML kernel will hang on exit on 2.6.9 hosts from now
on, and there's nothing to fix it but to update the guest UML patches?

This is a nasty limitation in general - because it means that on the
update to 2.6.9, every kernel binary needs to be updated - and finding
rock solid versions of kernels + UML patches is not a fast process.

-- Naked




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
