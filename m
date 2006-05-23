Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FiYwn-0006Rw-89 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 May 2006 08:37:25 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FiYwn-0006or-A1 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 May 2006 08:37:25 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FiYwl-0006xl-9r
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 May 2006 08:37:25 -0700
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060523153735.GB4368@ccure.user-mode-linux.org>
References: <20060522212649.GA4946@portableric>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060522212649.GA4946@portableric>
Subject: [uml-devel] Re: [PATCH] Task Size Init cleanup
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
Date: Tue, 23 May 2006 11:37:35 -0400
To: tyler@agat.net, user-mode-linux-devel@lists.sourceforge.net

On Mon, May 22, 2006 at 11:26:49PM +0200, tyler@agat.net wrote:
> I was looking at the code of the UML and more precisely at the functions
> set_task_sizes_tt and set_task_sizes_skas. I noticed that these 2
> functions take a paramater (arg) which is not used : the function is
> always called with the value 0.

You seem not to have tried to compile it, because it doesn't.  You missed
the declarations of set_task_sizes_*.
> 
> I suppose that this value might change in the future (or even can be
> configured), so I added a constant in mem_user.h file.

This is wrong.  set_task_sizes_* use &arg, not arg.

This stuff is fixed, and this patch is in my tree.

				Jeff


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
