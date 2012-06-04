Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alan@lxorguk.ukuu.org.uk>) id 1SbZcw-0005UI-Jn
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Jun 2012 15:55:30 +0000
Received: from lxorguk.ukuu.org.uk ([81.2.110.251])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SbZcq-0006b5-M4
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Jun 2012 15:55:30 +0000
Date: Mon, 4 Jun 2012 16:58:36 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-ID: <20120604165836.664abac5@pyramind.ukuu.org.uk>
In-Reply-To: <4FCCD44A.3090500@nod.at>
References: <1338809738-18967-1-git-send-email-jslaby@suse.cz>
	<1338809738-18967-14-git-send-email-jslaby@suse.cz>
	<4FCCA3A6.8080608@nod.at> <4FCCD224.1020307@suse.cz>
	<4FCCD44A.3090500@nod.at>
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
Subject: Re: [uml-devel] [PATCH 13/24] TTY: um/line, use tty from tty_port
To: Richard Weinberger <richard@nod.at>
Cc: Jiri Slaby <jirislaby@gmail.com>, user-mode-linux-devel@lists.sourceforge.net, gregkh@linuxfoundation.org, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Jiri Slaby <jslaby@suse.cz>, alan@linux.intel.com

> Two days ago I did so but still faced the problems described here:
> https://lkml.org/lkml/2012/3/10/163

If you are running a Fedora like distro it's because the user space is
broken. At some point we are going to have to make them fix the userspace
not to sit with ttys held open.


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

