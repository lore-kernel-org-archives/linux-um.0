Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BibNS-0005My-O4 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Jul 2004 09:04:02 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1BibNS-0004hA-3G for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Jul 2004 09:04:02 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407081804.40148.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] I'm out for some time - SKAS host leak diagnosis.
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
Date: Thu, 8 Jul 2004 18:04:40 +0200
To: user-mode-linux-devel@lists.sourceforge.net

1) From 9 to 18 July, I'll be away for study - so I won't be able to 
participate in the UML development. Sadly, after coming back I'll be far away 
from Internet, after a short time; however I think I'll be able to do 
something before starting again (and while away I'll have my new laptop, so 
I'll have plenty of time for coding).

2) Especially, I'm near to fixing the host SKAS leak... seems like it's a race 
condition when calling alloc_ldt(): one of the two values is overwritten by 
the other, and so never freed. In fact for each mm init_new_context() is 
called when open()ing it, while __init_new_context() is called when writing a 
MM_COPY_SEGMENTS request onto /proc/mm (which happens shortly after).
The mm->context is not locked anyway, and this is a SKAS bug: it makes sense 
in mainline, but not when using SKAS. The strange thing is that on 
host/kernel configurations where it happens, it is repeatable, i.e. does not 
seem a race condition. However the locking must be anyway added.

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
