Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yaPK-0007Cv-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 14 Sep 2003 10:11:31 -0700
Received: from smtp018.mail.yahoo.com ([216.136.174.115])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19yaPK-0007eX-Dq
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 14 Sep 2003 10:11:30 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [PATCH] Starting a command inside UML from mconsole
References: <200309131820.45833.blaisorblade_spam@yahoo.it> <200309140233.h8E2X5e4007952@ccure.karaya.com>
In-Reply-To: <200309140233.h8E2X5e4007952@ccure.karaya.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309141910.57952.blaisorblade_spam@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 14 Sep 2003 19:10:57 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Alle 04:33, domenica 14 settembre 2003, Jeff Dike ha scritto:
> blaisorblade_spam@yahoo.it said:

> > I'm writing a patch which adds a new command to the mconsole ones:
> > exec nomeprog args
> > which starts a new program with root privileges.

I must recall this part of my message:
> > Since that thread showed that running  commands without logging in is
> > something needed
> OK, what's so horrible about logging in?
> 				Jeff
However, ask to the admins who wanted to poweroff the UML guest without 
logging in and which decided to change the cad handler. This is, for me, a 
cleaner and more general way to do such things.
In fact, I already thought about such things(), but mconsole is already an 
exception to the "logging in" rule. And has no big security implication, 
since to start mconsole you need anyway the privileges of UML owner on the 
host, and can already halt or reboot whatever.
Beyond, I've read an article about the possibilities of the VMWare GUI(I think 
that UMLd is already something such), and to recreate them I thought that 
something such was useful.
-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
