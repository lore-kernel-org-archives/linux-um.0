Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1APRre-0006Zj-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 27 Nov 2003 11:31:46 -0800
Received: from 62-241-36-148.kunde.vdserver.de ([62.241.36.148] ident=mail)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1APRre-00015A-5e
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 27 Nov 2003 11:31:46 -0800
Received: from p5082fc7b.dip.t-dialin.net ([80.130.252.123] helo=[192.168.1.10])
	by 62-241-36-148.kunde.vdserver.de with asmtp (Exim 3.35 #1 (Debian))
	id 1APRrU-0002NF-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 27 Nov 2003 19:31:37 +0000
Mime-Version: 1.0
Message-Id: <a06010201bbec00ce8036@[192.168.1.10]>
From: Johannes Formann <johannes@formann.de>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Subject: [uml-devel] process start time in future
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
Date: Thu, 27 Nov 2003 20:31:39 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

I've a problem, when I'm running an UML for a few days, the starttime 
of new prozesses are slowly drifting into the future.

I'ven seen that with 2.4.21-6, 2.4.22-5um and 2.4.22-6um.

Can anyone explain/fix it?

An exampel is shown below.

$  ps -f ; date
UID        PID  PPID  C STIME TTY          TIME CMD
johannes  8967  8966  0 23:54 pts/1    00:00:00 -bash
johannes  9117  8967  0 Nov28 pts/1    00:00:00 ps -f
Thu Nov 27 19:27:52 UTC 2003

# ps -f ; date
UID        PID  PPID  C STIME TTY          TIME CMD
root      5256  5254  0 23:55 pts/0    00:00:00 -bash
root      5376  5256  0 Nov28 pts/0    00:00:00 ps -f
Thu Nov 27 19:27:46 UTC 2003


Greetings Johannes


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
