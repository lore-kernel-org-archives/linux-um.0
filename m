Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alan@lxorguk.ukuu.org.uk>) id 1SbebC-0007uO-Er
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Jun 2012 21:14:02 +0000
Received: from lxorguk.ukuu.org.uk ([81.2.110.251])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SbebB-0007Dt-9Y
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Jun 2012 21:14:02 +0000
Date: Mon, 4 Jun 2012 22:17:31 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-ID: <20120604221731.5e378fc2@pyramind.ukuu.org.uk>
In-Reply-To: <1338841657-30358-1-git-send-email-richard@nod.at>
References: <1338841657-30358-1-git-send-email-richard@nod.at>
Mime-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] um: TTY fixes (?)
To: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, jslaby@suse.cz, alan@linux.intel.com

> 	On all other ttys login works but bash dies because of of -EIO.
> 	After vhangup() the tty returns -EIO upon read()/write().

You can't re-open the tty because a process is holding on to it, not
closing it and not killable. Fedora shouldn't be holding these devices
open this way. The behaviour we have of refusing to reopen them why this
is the case is both a) what the spec seems to say b) good security.

We can half ignore it on console for the simple reason that you don't
"dial in" to the console. I suspect it may be abusable but I've not found
a way to do so.

> I have no idea what's the root cause of this, there seems to be a lot of black magic
> involved.
> Alan, do you think the issues are caused by Fedora's broken user space?

See what fuser says about open file handles and if that is what is going
on.

Alan

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

