Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1SXqnU-00049F-Hw
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 May 2012 09:27:00 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SXqnS-0003uP-57
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 May 2012 09:27:00 +0000
Message-ID: <4FBF505A.1020808@nod.at>
Date: Fri, 25 May 2012 11:26:50 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <161124411.50124.1337931613542.JavaMail.root@sigma-star.at>
	<4FBF4EAB.7030904@panasas.com>
In-Reply-To: <4FBF4EAB.7030904@panasas.com>
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
Subject: Re: [uml-devel] UML: Please help with __module_text_address crashing
To: Boaz Harrosh <bharrosh@panasas.com>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On 25.05.2012 11:19, Boaz Harrosh wrote:
> Whats keeping this patch from hitting mainline? to much ugliness?
> Is there a way to work without it (somehow)
>

UML's tty driver is a corner case. (It is a console but does not support
virtual consoles, etc...)
TTY folks are currently moving most drivers to the new tty_port 
interface. UML has also to use tty_port. But as of writing of the my 
tty-patch tty_port was not fully ready for consoles.
Anyway, I'll checkout what's the current state of tty_port is and 
rewrite UML's TTY mess^Wdriver again. :)

Thanks,
//richard

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

