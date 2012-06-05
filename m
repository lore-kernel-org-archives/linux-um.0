Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alan@lxorguk.ukuu.org.uk>) id 1SbrgE-0004nB-Jc
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Jun 2012 11:12:06 +0000
Received: from lxorguk.ukuu.org.uk ([81.2.110.251])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SbrgA-00071i-EY
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Jun 2012 11:12:06 +0000
Date: Tue, 5 Jun 2012 12:15:32 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-ID: <20120605121532.366a6526@pyramind.ukuu.org.uk>
In-Reply-To: <20120605104125.GA14536@x2.net.home>
References: <1338841657-30358-1-git-send-email-richard@nod.at>
	<20120604221731.5e378fc2@pyramind.ukuu.org.uk>
	<4FCD4161.7060409@nod.at> <20120605104125.GA14536@x2.net.home>
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
To: Karel Zak <kzak@redhat.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org, jslaby@suse.cz, alan@linux.intel.com

>  open_tty() closes all the old file descriptors after tty open:

It needs to close them before.
> 
>     vhangup();
>     ...
> 	fd = open(tty, O_RDWR | O_NONBLOCK);
>     ...
> 
> 	flags = fcntl(fd, F_GETFL);
> 	flags &= ~O_NONBLOCK;
> 	fcntl(fd, F_SETFL, flags);
> 
> 	for (i = 0; i < fd; i++)
> 		close(i);
> 	for (i = 0; i < 3; i++)
> 		if (fd != i)
> 			dup2(fd, i);
> 	if (fd >= 3)
> 		close(fd);
> 
> we use this for pretty long time (17+ years).
> 
> > If I add:
> >         fclose(stdin);
> >         fclose(stdout);
> >         fclose(stderr);
> > before the call to vhangup() login works like charm. :-)
> > 
> > Karel, what do you think?
> 
>  It's probably no problem to close all the file descriptors before
>  vhangup(), but it would be nice to know why we need this change after
>  20 years :-)

Because we want to actually fix the standards (and security) violation
that means it has happened to work on the console for 20 years.

Actually I'd prefer a clever solution which can spot all the fds are the
same process so we can keep compatibility but I've not found a sensible
way to do that.

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

