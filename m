Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BsV4Q-0002zK-VG for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 Aug 2004 16:21:18 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1BsV4Q-0008FG-DB
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 Aug 2004 16:21:18 -0700
Message-Id: <200408050020.i750Kwvv009127@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Q: UML thread communication - scheduling oddness 
In-Reply-To: Your message of "Wed, 04 Aug 2004 16:10:28 EDT."
	<411142B4.7000603@nortelnetworks.com> 
References: <411142B4.7000603@nortelnetworks.com> 
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
Date: Wed, 04 Aug 2004 20:20:58 -0400
To: Joe Marzot <gmarzot@nortelnetworks.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Randy Macleod <macleodr@nortelnetworks.com>

gmarzot@nortelnetworks.com said:
> That is, if I run a little busy loop
>   /mnt/plankton/stress --cpu 1 --io 1
> on the server side, the round trip time for messages is greatly
> *improved*. without this activity and a basically dormant server side
> UML the round trip times show considerable variabilty with gaps on the
>  order of seconds. 

How's this for a theory:  The server's host is short on memory.  A UML which
is answering pings every second or so can be considered pretty idle, and thus
a good candidate to have its pages swapped out.  So, this happens, and when
a ping comes in, UML needs to be swapped back in, causing your long and
unpredictable delays.

Running a busy loop in the UML makes it busy from the point of view of the
host and prevents it from being swapped out, giving you nice ping latencies.

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
