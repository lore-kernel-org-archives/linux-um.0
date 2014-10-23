Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1XhDtL-0004l5-DC
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Oct 2014 08:37:07 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XhDtJ-0002yK-Qw
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Oct 2014 08:37:07 +0000
Message-ID: <5448BE29.6080103@nod.at>
Date: Thu, 23 Oct 2014 10:36:57 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <1413236904.13916.13.camel@localhost.localdomain>	<543CB6BA.9030907@kot-begemot.co.uk>	<543CC5FE.4000601@kot-begemot.co.uk>	<1413271301.13744.13.camel@localhost.localdomain>	<543CD148.7010904@kot-begemot.co.uk>	<1413730776.2991.16.camel@localhost.localdomain>	<5443E097.2000801@kot-begemot.co.uk>	<1413747337.2991.36.camel@localhost.localdomain>
	<1413835305.2991.46.camel@localhost.localdomain>
	<5448AF6E.6090201@kot-begemot.co.uk>
In-Reply-To: <5448AF6E.6090201@kot-begemot.co.uk>
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
Subject: Re: [uml-devel] kernel stalls in balance_dirty_pages_ratelimited()
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, user-mode-linux-devel@lists.sourceforge.net

Anton,

Am 23.10.2014 um 09:34 schrieb Anton Ivanov:
> Hi Richard,
> 
> I have had a question in my mind on this for quite a while around this bug (and a quite a few others).

Fell free to ask, I'll try hand to find time to answer.

> UML by the nature of being UP includes the generic spinlock definition for UP which does very little if any.

Correct. IIRC they are a NOP on UML as it does not support preemption.

> How exactly does this work on a multicore host if you have a different thread hitting the same critical section and that thread is running on a different core? Isn't that
> effectively a form of weird SMP (which in turn requires stricter locking). Am I missing something here?

>>From the host side of view the UML kernel a single process and therefore there is no parallel execution at all.

Does this help?

Thanks,
//richard

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

