Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AcVp8-0000TV-Av for User-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Jan 2004 12:23:10 -0800
Received: from [65.117.135.105] (helo=kartuli.timesys)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1AcVp6-0007wg-Qp
	for User-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Jan 2004 12:23:08 -0800
Received: from timesys.com (tsqali.timesys [192.168.2.47])
	by kartuli.timesys (8.12.5/8.12.5) with ESMTP id i02KN5V8024324
	for <User-mode-linux-devel@lists.sourceforge.net>;
	Fri, 2 Jan 2004 15:23:05 -0500
Message-ID: <3FF5D31A.8050503@timesys.com>
From: "La Monte H.P. Yarroll" <piggy@timesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] NPTL + UML?
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
Date: Fri, 02 Jan 2004 15:22:50 -0500
To: User-mode-linux-devel@lists.sourceforge.net

Is anybody out there working on getting thread-local storage (i.e. NPTL) 
working with UML?  I see that set_thread_area(2) and get_thread_area(2) 
are both sys_ni_syscall in arch/um/kernel/sys_call_table.c.

The lack of NPTL support causes me a lot of grief...



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
