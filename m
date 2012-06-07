Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alan@lxorguk.ukuu.org.uk>) id 1ScaGy-00062I-7y
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jun 2012 10:49:00 +0000
Received: from lxorguk.ukuu.org.uk ([81.2.110.251])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ScaGu-0005y8-5x
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jun 2012 10:49:00 +0000
Date: Thu, 7 Jun 2012 11:52:27 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-ID: <20120607115227.6643d1ad@pyramind.ukuu.org.uk>
In-Reply-To: <4FD0802A.1020203@nod.at>
References: <1338841657-30358-1-git-send-email-richard@nod.at>
	<4FCF6748.6020005@panasas.com> <4FD059AC.8050808@panasas.com>
	<4FD06A22.6040002@nod.at> <4FD07F14.50902@panasas.com>
	<4FD0802A.1020203@nod.at>
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

> > I really don't get it. You have not broken anything new. Only
> > not fixed all of the problems. Current code does not work for "non-tty0
> > terminals" as well right?
> 
> No, it works fine.

Not really. You happen to be lucky. Anyway with no tty port the UML code
will soon cease to function completely so a solution of some sort is
needed.
 
> > I don't see Alan's comment at all. This is not a regression it was always
> > like that. Ever since Fedora was working on UML, But these fixes are real
> > live regression crashes.
> > 
> > And I don't see the all "leaving other vendors systems insecure". It just
> > a freaking UML tty. You need to be root 5 times before you have access
> > to all these, and it's only the UML that's compromised not the "all system"
> > And surely the current plain tty0 crash is much less secure then this thing.
> 
> The "TTY problem" is not UML specific.

That one is. The console driver handles stuff its own way and
differently. It's eventually got to tackle the same problem.

I still think we ought to be able to solve it cleanly. It's a case of
getting the tests right so that we allow for the misbehaviour util-linux
does.

As of itself util-linux behaviour doesn't appear to be something we can't
permit as the 

	open
	vhangup

sequence means the file handle that is left from before the vhangup due
to util-linux misbehaving is a hung-up fd so cannot affect the tty.

UML is a good test case for fixing this properly because it's got almost
no users, and those it has are fairly technical 8)


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

