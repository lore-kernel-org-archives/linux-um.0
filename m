Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Awd9B-0000Zr-UQ for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Feb 2004 00:15:01 -0800
Received: from gate2.mailgate.de ([62.116.129.39] helo=web4.internetx.de)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Awcks-000804-Kj for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Feb 2004 23:49:54 -0800
From: Sebastian Wiesinger <sw@internetx.de>
Subject: Re: [uml-devel] Problem: copy_thread : pipe failed, err = 24
Message-ID: <20040227080446.GB21666@lain.intern.internetx.de>
References: <20040220092607.GA8007@lain.intern.internetx.de>
	<200402261734.11621.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402261734.11621.blaisorblade_spam@yahoo.it>
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
Date: Fri, 27 Feb 2004 09:04:46 +0100
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

* BlaisorBlade <blaisorblade_spam@yahoo.it> [2004-02-26 19:39]:
> > copy_thread : pipe failed, err = 24
> 
> This is EMFILE. Either you "ulimit"ed your UML's (and one UML needs a lot of 
> filehandles) or you need to increase the filehandle limit where it is 
> happening.

Yes, it was the ulimit, I increased the file handles now

> > This error appears first after a few hours of running and the boxes
> > with this error is no longer reachable.
> 
> *Very* strange. If you mean that you can no longer login / do anything that 
> needs to create a new process inside UML, I understand it.

Yes, that's the problem. :)


> > The following other errors
> > also appear:
> >
> > flush_thread : new thread failed, errno = 1
> > copy_thread : clone failed - errno = 11
> > copy_thread : clone failed - errno = 1
> > copy_thread : clone failed - errno = 1
> 
> EPERM (very strange) and EAGAIN (too many processes running). Checking the 
> source for sys_clone could be needed to diagnose EPERM (unless you have 
> something as GrSecurity active).

No, vanilla 2.4.25 Kernel.

Greetings, Sebastian


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
