Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CpAsS-0003OS-6q for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 11:43:28 -0800
Received: from pool-151-203-193-191.bos.east.verizon.net ([151.203.193.191]
	helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CpAsR-0003zF-KU
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 11:43:28 -0800
Message-Id: <200501132205.j0DM5Oha005643@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Thu, 13 Jan 2005 20:08:41 +0100."
	<200501132008.41725.blaisorblade@yahoo.it> 
References: <200501132008.41725.blaisorblade@yahoo.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: Breakage of compilation in .11-rc1 - "code-tidying"
	is broken
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
Date: Thu, 13 Jan 2005 17:05:24 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

blaisorblade@yahoo.it said:
> In fact, including both linux/ptrace.h and sys/ptrace.h is not
> redundant - it  must also be done in the proper order, so I'm writing
> a patch with the  appropriate content. 

Wait till I update my patch list before fixing this.  Bodo send me a patch,
which I am polishing now.

				Jeff



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
