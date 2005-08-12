Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3eMv-0005pg-1d	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:35:01 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E3eMt-0004mE-8P
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:35:01 -0700
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20050812174641.GA8746@ccure.user-mode-linux.org>
References: <200508121855.02633.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508121855.02633.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: sys_ptrace consolidation and S390 port
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
Date: Fri, 12 Aug 2005 13:46:41 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, user-mode-linux-devel@lists.sourceforge.net

On Fri, Aug 12, 2005 at 06:55:02PM +0200, Blaisorblade wrote:
> I just ran through this article:
> 
> http://lwn.net/Articles/146973/
> 
> and it seems that it's dropping some of the early bits of s390 merge (I 
> guess). Note the mention to SUBARCH_PTRACE_SPECIAL - I guess that's there for 
> s390, right Bodo?
> 
> This patch is not going to be merged today, but it'll be soon I guess.

Yeah, I guessed the same, but it was premature to get that in mainline
without the actual port being ready.

So, we can look at that and see if we can do it without
unconsolidating sys_ptrace.  If that's not possible, then we just
revert the UML portion of the patch.

				Jeff


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
