Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C97d2-00021n-8k for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 19 Sep 2004 12:45:44 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1C97d0-00075I-Gt for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 19 Sep 2004 12:45:44 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409192142.44820.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Released 2.6.7 SKAS3-v5
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
Date: Sun, 19 Sep 2004 21:42:44 +0200
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
Cc: Gerd Knorr <kraxel@bytesex.org>

Today I've released the SKAS3-v5 patch, fixing some little bugs in -v4 (the 
SYSEMU support). They could affect running strace on patched host (or 
anything using PTRACE_SYSCALL). Thanks for identifying it to Gerd Knorr 
<kraxel@bytesex.org>. Details are also available on the web-site.

You will be able to find the patch on this web-site, as always:

http://www.user-mode-linux.org/~blaisorblade/

However, in this moment the name-server has problems (see below), so you may 
reach it only by its IP:

http://66.59.111.166/~blaisorblade/

Btw, this is the error from dig (a tool for name-space resolution):
$ dig +nssearch www.user-mode-linux.org
dig: Couldn't find server 'ganesha.solana.com': Temporary failure in name 
resolution

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
