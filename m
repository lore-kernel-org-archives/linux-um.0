Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWevn-00020I-Pr for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Nov 2004 09:58:23 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CWevj-0001ze-Cg for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Nov 2004 09:58:23 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411231900.40463.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] About DevFS
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
Date: Tue, 23 Nov 2004 19:00:40 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Peter <peter@rimuhosting.com>

On Tuesday 23 November 2004 04:09, Peter wrote:
> How will this affect existing UML setups?  Does it mean they would need
> to change if we started them up with a new UML kernel after /dev/ubd/0
> "goes away"?
The other name (see the FAQ on my page to know which one, linked in my 
signature) - is available also in the old instances (both 2.4 and 2.6).

> That would mean quite a disruption to operations (i.e. 
> making changes on lots of UML instances).  Is there a way to acheive
> what you're doing in a backwards-compatible manner?

The other name always exists, even on older instances, so the new syntax is 
backward compatible.

However, I hope the removal of /dev/ubd/0 symlinks can be deferred, so that 
you don't need to rush on this (I'm not sure of this - I don't care, but 
there are other developers complaining). At least, I need to update the Uml 
page.

That said, DevFS is unstable (not in UML, but in general), so people should 
start switching away from it.

Using devfsd probably helps the transiction (i.e. you start using the 
"standard" non-devfs names without removing access to the DevFS ones until 
you complete the transiction).
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
