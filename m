Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yD7N-0001gq-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 13 Sep 2003 09:19:25 -0700
Received: from smtp014.mail.yahoo.com ([216.136.173.58])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19yD7M-0008NK-Tb
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 13 Sep 2003 09:19:24 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200309131820.45833.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] [PATCH] Starting a command inside UML from mconsole
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
Date: Sat, 13 Sep 2003 18:20:45 +0200
To: user-mode-linux-devel@lists.sourceforge.net

I'm writing a patch which adds a new command to the mconsole ones:
exec nomeprog args
which starts a new program with root privileges. I've already done the hard 
part(starting the program) and it seems to basically work(no crash still), 
which is done mostly reusing code from kernel/kmod.c; I'll post the patch 
only when I'll have written also the simple part, i.e., the code to parse the 
command-line.

Reason for this: time ago, someone requested how to execute a command from 
mconsole. The discussion ended up by saying "use cad, after having changed 
the related line in /etc/inittab". The command needed was the one to poweroff 
the PC, but this applies generally. Since that thread showed that running 
commands without logging in is something needed, I decided to implement it.

I'd like a discussion about this(how much interest in this there is, 
suggestions, requests). Especially:
- is the ability to read arguments with spaces(within quotes) needed even for 
the program name?
About the way I'm doing it, I'll ask when the true patch is ready(it's just 
too young, so I want to study more before making you lose your time).
Thanks for the attention.
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
