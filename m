Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Adh7F-0007bj-29 for User-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Jan 2004 18:38:45 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1Adh7E-0002Dp-II
	for User-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Jan 2004 18:38:44 -0800
Message-Id: <200401060258.i062wNFI023072@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] NPTL + UML? 
In-Reply-To: Your message of "Fri, 02 Jan 2004 15:22:50 EST."
	<3FF5D31A.8050503@timesys.com> 
References: <3FF5D31A.8050503@timesys.com> 
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
Date: Mon, 05 Jan 2004 21:58:23 -0500
To: "La Monte H.P. Yarroll" <piggy@timesys.com>
Cc: User-mode-linux-devel@lists.sourceforge.net

piggy@timesys.com said:
> Is anybody out there working on getting thread-local storage (i.e.
> NPTL)  working with UML?  I see that set_thread_area(2) and
> get_thread_area(2)  are both sys_ni_syscall in arch/um/kernel/
> sys_call_table.c. 

I've punted on some of the new 2.6 stuff for now.  I'll catch up on that
and other things (modules, hugetlbfs, etc) when I get a free moment or two.

				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
