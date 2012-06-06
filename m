Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <bharrosh@panasas.com>) id 1ScH6s-0004Wf-5y
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Jun 2012 14:21:18 +0000
Received: from natasha.panasas.com ([67.152.220.90])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ScH6r-0001st-5J for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Jun 2012 14:21:18 +0000
Message-ID: <4FCF6748.6020005@panasas.com>
Date: Wed, 6 Jun 2012 17:20:56 +0300
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
References: <1338841657-30358-1-git-send-email-richard@nod.at>
In-Reply-To: <1338841657-30358-1-git-send-email-richard@nod.at>
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

On 06/04/2012 11:27 PM, Richard Weinberger wrote:

> This patch set moves the UML console driver to the new TTY port interface.
> It does ref counting and uses the tty_port_*-helpers.
> Please note, it's not yet UML mconsole safe!
> 
> Anyway, I see some really strange things and I'm not sure whether my patch
> is sane or not...
> 
> If I implement tty_operations->hangup() the following happens:
> 
> FC12:
> 	Login on tty0 works fine.
> 	On all other ttys login works but bash dies because of of -EIO.
> 	After vhangup() the tty returns -EIO upon read()/write().
> FC16:
> 	Login broken on all ttys (bash dies with EIO like on FC12).
> 	If I start UML with rootfs read-only login works on tty0. - WTF?!
> Debian 6.0:
> 	Login works perfectly fine on all ttys
> 
> Without tty_operations->hangup() the following happens:
> FC12:
> 	Login on tty0 works fine.


Horray I'm back to my old self. Thanks I'll give it a run
and report of any new problems

Thanks a million Richard
Boaz

> 	mingetty is unable to start on anything else than tty0.
> 	It exits after a few seconds.
> FC16:
> 	Unable to start any mingetty (like on FC12 it exits after a few seconds)
> 	With read-only rootfs mingetty starts at least on tty0 and login works. (Again, WTF?)
> Debian 6.0
> 	Login works perfectly fine on all ttys.
> 
> I have no idea what's the root cause of this, there seems to be a lot of black magic
> involved.
> Alan, do you think the issues are caused by Fedora's broken user space?
> How can we fix this?
> 
> Thanks,
> //richard (wearing a voodoo priests robe)
> 
> [PATCH 1/6] TTY: um/line, add tty_port
> [PATCH 2/6] TTY: um/line, use tty from tty_port
> [PATCH 3/6] um: remove line_ioctl()
> [PATCH 4/6] um: Remove dead code
> [PATCH 5/6] um: fully use tty_port
> [PATCH 6/6] um: remove count_lock
> 
> ------------------------------------------------------------------------------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and 
> threat landscape has changed and how IT managers can respond. Discussions 
> will include endpoint security, mobile security and the latest in malware 
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel



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

