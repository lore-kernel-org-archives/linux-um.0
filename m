Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CGRmo-0002VQ-2o for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 09 Oct 2004 17:42:06 -0700
Received: from main.gmane.org ([80.91.229.2])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CGRml-0000ZL-61 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 09 Oct 2004 17:42:06 -0700
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1CGRmk-0007hO-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 10 Oct 2004 02:42:02 +0200
Received: from 209-6-22-202.c3-0.smr-ubr1.sbo-smr.ma.cable.rcn.com
	([209.6.22.202]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 10 Oct 2004 02:42:02 +0200
Received: from lars by 209-6-22-202.c3-0.smr-ubr1.sbo-smr.ma.cable.rcn.com
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 10 Oct 2004 02:42:02 +0200
From: Lars Kellogg-Stedman <lars@oddbit.com>
Message-ID: <lars-37F7DA.20415609102004@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Kernel panic "read of switch_pipe failed" in 2.6.8.1
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
Date: Sat, 09 Oct 2004 20:41:56 -0400
To: user-mode-linux-devel@lists.sourceforge.net

I'm occasionally seeing the following during the UML boot process:

  Kernel panic: read of switch_pipe failed, errno = 9

At which point UML hangs after printing out a call trace.

I'm starting UML like this:

  linux umid=uml1 ubd0=/tmp/root_fs \
    con0=fd:0,fd:1 con=port:9001 eth0=mcast

Has anyone seen this behavior?  It's not happening frequently -- for 
example, I've restarted UML several times while typing this message in 
an attempt to capture the call trace without triggering the panic.

-- Lars



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
