Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1Zqelh-0001MD-Qn
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Oct 2015 10:12:45 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Zqelb-0002y0-OM
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Oct 2015 10:12:45 +0000
References: <1445416947-824802-1-git-send-email-aivanov@brocade.com>
	<562D236E.7020108@kot-begemot.co.uk>
From: Richard Weinberger <richard@nod.at>
Message-ID: <562DFC90.9030308@nod.at>
Date: Mon, 26 Oct 2015 11:12:32 +0100
MIME-Version: 1.0
In-Reply-To: <562D236E.7020108@kot-begemot.co.uk>
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
Subject: Re: [uml-devel] [PATCH v3] um: Switch clocksource to hrtimers
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, user-mode-linux-devel@lists.sourceforge.net

Hi!

Am 25.10.2015 um 19:46 schrieb Anton Ivanov:
> Hi List, hi Richard,
> 
> I am going to sort out the UBD patchset next as that has no dependencies on timer and the other stuff which is waiting in the queue behind the timers.
> 
> That should give UML a significant boost. It is nothing particularly revolutionary (qemu has been using some of that for ages).
> 
> I should be able to get these out of the door early on this week.

Nice!

> A.
> 
> P.S. If there is anything to fix on the timer one, please shout.

Looks good so far. Unless it breaks a lot it will be part of the 4.4 merge window. :)

Thanks,
//richard

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

