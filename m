Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1APUWT-0001Xb-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 27 Nov 2003 14:22:05 -0800
Received: from mail.gmx.net ([213.165.64.20])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1APUWS-0001lF-Um
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 27 Nov 2003 14:22:05 -0800
Message-ID: <007501c3b535$79848d10$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <a06010201bbec00ce8036@[192.168.1.10]>
Subject: Re: [uml-devel] process start time in future
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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
Date: Thu, 27 Nov 2003 23:26:16 +0100
To: user-mode-linux-devel@lists.sourceforge.net, Johannes Formann <johannes@formann.de>

hi !
also a effect caused by the serveral times reported "clock skew issue"?

maybe it is solved, soon:
http://sourceforge.net/mailarchive/message.php?msg_id=6499133

btw: is jeff the only person doing development or patchmerging/bugfixing most of 
the time? is uml primarily a "one man" thing and uml dies, if jeff looses interest 
one day? i don`t hope so... but i really wonder anyway, that there is so few traffic 
on the mailinglists. is uml still so "exotic" that so few people actually seem to be
interested? maybe everybody has vmware already... ;)


regards
roland


----- Original Message ----- 
From: "Johannes Formann" <johannes@formann.de>
To: <user-mode-linux-devel@lists.sourceforge.net>
Sent: Thursday, November 27, 2003 8:31 PM
Subject: [uml-devel] process start time in future


> Hi,
> 
> I've a problem, when I'm running an UML for a few days, the starttime 
> of new prozesses are slowly drifting into the future.
> 
> I'ven seen that with 2.4.21-6, 2.4.22-5um and 2.4.22-6um.
> 
> Can anyone explain/fix it?
> 
> An exampel is shown below.
> 
> $  ps -f ; date
> UID        PID  PPID  C STIME TTY          TIME CMD
> johannes  8967  8966  0 23:54 pts/1    00:00:00 -bash
> johannes  9117  8967  0 Nov28 pts/1    00:00:00 ps -f
> Thu Nov 27 19:27:52 UTC 2003
> 
> # ps -f ; date
> UID        PID  PPID  C STIME TTY          TIME CMD
> root      5256  5254  0 23:55 pts/0    00:00:00 -bash
> root      5376  5256  0 Nov28 pts/0    00:00:00 ps -f
> Thu Nov 27 19:27:46 UTC 2003
> 
> 
> Greetings Johannes
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?  SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
> 


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
