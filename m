Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cdcyg-0006JW-64 for User-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Dec 2004 15:18:10 -0800
Received: from fed1rmmtao11.cox.net ([68.230.241.28])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Cdcyf-0006fa-JZ for User-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Dec 2004 15:18:10 -0800
Received: from [192.168.0.102] (really [68.231.195.29]) by fed1rmmtao11.cox.net
	(InterMail vM.6.01.04.00 201-2131-117-20041022) with ESMTP
	id <20041212231801.PCHE28808.fed1rmmtao11.cox.net@[192.168.0.102]>
	for <User-mode-linux-devel@lists.sourceforge.net>;
	Sun, 12 Dec 2004 18:18:01 -0500
Message-ID: <41BCD1C8.8060701@easyco.com>
From: Doug Dumitru <doug@easyco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Stranded processes on halt with 2.6.9 host (2.4.26 client)
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
Date: Sun, 12 Dec 2004 15:18:32 -0800
To: User-mode-linux-devel@lists.sourceforge.net

I have been running 2.6.7 on the host for some time in SKAs mode.  When 
trying to upgrade to 2.6.9, 2.4.26 clients do run correctly, but upon 
shutdown they leave two processes stranded that cannot be killed (even 
with kill -9).  Both processes show [halt] so this must be very near the 
end of UML shutdown.  Any ideas.  I hunted the message list, but did not 
see anything obvious.

Server is a Dual P-III running fresh Fedora Core 3.  Kernel.org 2.6.9 
kernel has been tried with:

     15957 host-skas3-2.6.7-v1.patch
     23838 host-skas3-2.6.9-rc4-v6.patch
     25510 host-skas3-2.6.9-v7.patch

but they all behave the same way.

--------------------------------------------------------------------
Doug Dumitru     800-470-2756     (610-237-2000)
EasyCo LLC       doug@easyco.com  http://easyco.com
--------------------------------------------------------------------


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
