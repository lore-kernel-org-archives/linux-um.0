Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alan@lxorguk.ukuu.org.uk>) id 1ScgQC-0008FH-Lf
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jun 2012 17:22:56 +0000
Received: from lxorguk.ukuu.org.uk ([81.2.110.251])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ScgQA-0002U5-7g
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jun 2012 17:22:56 +0000
Date: Thu, 7 Jun 2012 18:26:15 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-ID: <20120607182615.39877547@pyramind.ukuu.org.uk>
In-Reply-To: <4FD0D9AF.4000605@nod.at>
References: <1338841657-30358-1-git-send-email-richard@nod.at>
	<4FCF6748.6020005@panasas.com> <4FD059AC.8050808@panasas.com>
	<4FD06A22.6040002@nod.at> <4FD07F14.50902@panasas.com>
	<4FD0802A.1020203@nod.at>
	<20120607115227.6643d1ad@pyramind.ukuu.org.uk>
	<4FD0C64D.2050302@nod.at>
	<20120607173711.22ae146f@bob.linux.org.uk>
	<4FD0D7AA.4010506@nod.at>
	<20120607175024.696be664@bob.linux.org.uk>
	<4FD0D9AF.4000605@nod.at>
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
Cc: user-mode-linux-devel@lists.sourceforge.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, jslaby@suse.cz, Alan Cox <alan@linux.intel.com>

> What about the not nice ways?
> Having a ugly driver until 3.7 is better than having no driver...

If you are willing to go do the work then yes.

> I'm wondering why does drivers/tty/vt/vt.c work?
> Can't I model the UML driver after it?

Possibly although the vt driver has its own locking model to watch out
for.

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

