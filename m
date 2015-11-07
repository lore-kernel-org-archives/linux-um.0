Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1Zv0nK-0000V1-Hv
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 07 Nov 2015 10:32:26 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Zv0nJ-0004wN-79
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 07 Nov 2015 10:32:26 +0000
References: <1446480997-155855-1-git-send-email-aivanov@brocade.com>
	<563D2217.1070002@nod.at> <563DD29F.3060300@kot-begemot.co.uk>
From: Richard Weinberger <richard@nod.at>
Message-ID: <563DD331.8080501@nod.at>
Date: Sat, 7 Nov 2015 11:32:17 +0100
MIME-Version: 1.0
In-Reply-To: <563DD29F.3060300@kot-begemot.co.uk>
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
Subject: Re: [uml-devel] [PATCH v4] um: Switch clocksource to hrtimers
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, user-mode-linux-devel@lists.sourceforge.net
Cc: Thomas Meyer <thomas@m3y3r.de>

Hi!

Am 07.11.2015 um 11:29 schrieb Anton Ivanov:
> Cool,
> 
> Is there a tree I can pull so I can have the next one (the epoll based IRQ controller) incremental?

Sure, it is in uml's next:
https://git.kernel.org/cgit/linux/kernel/git/rw/uml.git/log/?h=linux-next

Thanks,
//richard

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

