Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kzak@redhat.com>) id 1SpKi8-000155-D1
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Jul 2012 14:49:44 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SpKi3-00008e-0n for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Jul 2012 14:49:44 +0000
Date: Thu, 12 Jul 2012 16:49:28 +0200
From: Karel Zak <kzak@redhat.com>
Message-ID: <20120712144928.GA13700@x2.net.home>
References: <1338841657-30358-1-git-send-email-richard@nod.at>
	<20120604221731.5e378fc2@pyramind.ukuu.org.uk>
	<4FCD4161.7060409@nod.at> <20120605104125.GA14536@x2.net.home>
	<20120605121532.366a6526@pyramind.ukuu.org.uk>
	<4FCDF996.9010205@nod.at> <20120605151719.GA3882@x2.net.home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120605151719.GA3882@x2.net.home>
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
Cc: user-mode-linux-devel@lists.sourceforge.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, jslaby@suse.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>, alan@linux.intel.com

On Tue, Jun 05, 2012 at 05:17:19PM +0200, Karel Zak wrote:
> On Tue, Jun 05, 2012 at 02:20:38PM +0200, Richard Weinberger wrote:
> > Am 05.06.2012 13:15, schrieb Alan Cox:
> > > Actually I'd prefer a clever solution which can spot all the fds are the
> > > same process so we can keep compatibility but I've not found a sensible
> > > way to do that.
> > 
> > Me too.
> > 
> > For UML users the current situation is odd.
> > They have to select between:
> > - Having a UML that crashes randomly on some distros.
> > - Applying the TTY fix and break login on every distro that uses util-linux's login.
> > - Applying the TTY fix and patch util-linux too.
> 
>  I'll follow kernel... so if close-before-vhangup is preferred way
>  than I'll modify util-linux login(1). No problem.

 I just fixed login(1) and agetty (--hangup option). The change will
 be available in util-linux v2.23 (rc1 will be this month).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

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

