Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CAuRT-0002UN-Nb for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Sep 2004 11:05:11 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CAuRR-0006Ae-PX
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Sep 2004 11:05:11 -0700
Message-Id: <200409241910.i8OJAPZX003320@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Syscalls breaking out 
In-Reply-To: Your message of "Fri, 24 Sep 2004 15:39:44 +0200."
	<8B6FF516CBA0194AB0996705076B02520F7C39@ABGEX01E.abg.fsc.net> 
References: <8B6FF516CBA0194AB0996705076B02520F7C39@ABGEX01E.abg.fsc.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 24 Sep 2004 15:10:25 -0400
To: "Stroesser, Bodo" <Bodo.Stroesser@fujitsu-siemens.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, BlaisorBlade <blaisorblade_spam@yahoo.it>

Bodo.Stroesser@fujitsu-siemens.com said:
> (It would overlap with my previos patch, should I merge them?) 

I'm looking at your patches and will get back to you on them, but let me just
comment on this issue first.

I'd prefer these patches be split up into as small units as possible.  That'll
make it easier to decide whether they are correct.  It's OK if they overlap
and need to be applied in a particular order.

So, for example, the API changes could be broken out separately.  Even if it's
two lines of change (the caller and the callee), that's a good way to split it
up.  This part of the kernel has some subtleties, so I'd prefer to be careful
here.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
