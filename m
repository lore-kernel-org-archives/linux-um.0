Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQ4wJ-0007Iy-Ja for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 May 2004 06:47:27 -0700
Received: from web14002.mail.yahoo.com ([216.136.175.93])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BQ4wJ-0002ef-Bs for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 May 2004 06:47:27 -0700
Message-ID: <20040518134726.36369.qmail@web14002.mail.yahoo.com>
From: Sam King <sam_king18@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [uml-devel] preemption
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
Date: Tue, 18 May 2004 06:47:26 -0700 (PDT)
To: user-mode-linux-devel@lists.sourceforge.net

Hello!

I am trying to understand how the UML kernel preempts
guest user mode applications in SKAS mode.  I am using
version 2.4.20 of the guest kernel.

From what I can tell, when the guest kernel takes a
timer interrupt (SIGALRM) it eventually updates the
tsk->need_resched parameter for processes that have
been running for too long.  However, I do not see
where the actual switch takes place except in the
interrupt_end() function which is only called as a
result of guest application system calls and signals. 
Since I am sure that the guest kernel supports
preemption, I must be missing something.

Thank you for you help.

--Sam


	
		
__________________________________
Do you Yahoo!?
SBC Yahoo! - Internet access at a great low price.
http://promo.yahoo.com/sbc/


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
