Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ASPk8-0000jt-66
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 05 Dec 2003 15:52:16 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1ASPk5-0002bH-PG
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 05 Dec 2003 15:52:13 -0800
Message-Id: <200312060005.hB605FAv008248@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Valgrinding Linux kernel with UML 
In-Reply-To: Your message of "Sun, 30 Nov 2003 23:34:48 +0200."
             <Law10-F99ny3O76JOTB00020380@hotmail.com> 
References: <Law10-F99ny3O76JOTB00020380@hotmail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 05 Dec 2003 19:05:15 -0500
To: derry shribman <derrysh@hotmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

derrysh@hotmail.com said:
> Still - valgrind+UML crashed immediately.
> Did anyone try out valgrind+UML? 

There is a config option (double the size of the kernel stack) that you need
to set in order for Valgrind to have a chance.

There are also a bunch of Valgrind fixes which are necessary, and I don't
know whether they've made it in yet.

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
