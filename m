Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bsmo0-0003K1-9G for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Aug 2004 11:17:32 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1Bsmnz-0000su-Pn
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Aug 2004 11:17:32 -0700
Message-Id: <200408051917.i75JHDCi003746@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Q: UML thread communication - scheduling oddness 
In-Reply-To: Your message of "Thu, 05 Aug 2004 12:45:04 EDT."
	<41126410.6040008@nortelnetworks.com> 
References: <200408050020.i750Kwvv009127@ccure.user-mode-linux.org>
	<41126410.6040008@nortelnetworks.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Thu, 05 Aug 2004 15:17:13 -0400
To: Joe Marzot <gmarzot@nortelnetworks.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Randy Macleod <macleodr@nortelnetworks.com>

gmarzot@nortelnetworks.com said:
> thinking about this a bit more...some doubts...note: the regular
> 'pings'  which are serviced purely by kernel resident code/ kernel
> thread do not  exhibit the delays. It is only when the communication
> involved a  userspace app as the responder to the 'app-level-ping'
> that the delays  come. Is the memory for the userspace app seperately
> swappable from that  of the kernel thread?

The userspace app is all of UML, including the parts of the kernel which
respond to pings.  It can all be swapped out by the host.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
