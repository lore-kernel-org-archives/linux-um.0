Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C8Uuz-0001gt-Is for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Sep 2004 19:25:41 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1C8Uux-0002sS-9r
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Sep 2004 19:25:41 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] uml, ptrace, and BKL
Message-ID: <20040918033012.GA1618@ccure.user-mode-linux.org>
References: <Pine.LNX.4.58.0409171920470.1171@gradall.private.brainfood.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409171920470.1171@gradall.private.brainfood.com>
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
Date: Fri, 17 Sep 2004 23:30:12 -0400
To: Adam Heath <doogie@brainfood.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, Sep 17, 2004 at 07:23:01PM -0500, Adam Heath wrote:
> What this means to UML, is that there is an upper-bounds on how many instances
> can be on a server at once.  BKL also keeps preemption from occuring.

Please.  UML is a normal process.  It can't do anything to prevent preemption.

You're conflating the UML BKL and host BKL.  They're two separate things.

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
