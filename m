Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BNvsC-0001eM-Vw for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 May 2004 08:42:20 -0700
Received: from goliath.nmsrv.com ([69.28.204.18] helo=mail.praize.com)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BNvsB-00025w-L1 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 May 2004 08:42:19 -0700
Message-ID: <20040512154215.7674.qmail@praize.com>
From: "gboutwel" <gboutwel@praize.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Patch 2.6.6
Content-Type: Text/Plain;
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
Date: 12 May 2004 15:42:15 -0000
To: blaisorblade_spam@yahoo.it
Cc: user-mode-linux-devel@lists.sourceforge.net

> > Reversed (or previously applied) patch detected!  Assume
-R? [n]

> > Apply anyway? [n] y

> > Hunk #1 FAILED at 1.

> > Hunk #2 FAILED at 19.

> > 2 out of 2 hunks FAILED -- saving rejects to file include/asm-um/irq.h.rej



> same problem here!

> there seems something to be wrong with patching irq.h



I got an working 2.6.6 UML today.  It's doing an gentoo emerge
as we speak. :)



I had to modify the include/asm-um/irq.h file, to remove the
um_rquest_irq function, after doing that everything build fine.



HTH,



George



--------------------------------

Looking for that favorite verse?

Search for it in Praize Bible

http://www.praize.com/bible/



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
