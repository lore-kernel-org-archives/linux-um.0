Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQ8lp-0004cL-FZ for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 May 2004 10:52:53 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1BQ8lo-00086q-Ry
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 May 2004 10:52:53 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] preemption
Message-ID: <20040518183838.GA29175@ccure.user-mode-linux.org>
References: <20040518134726.36369.qmail@web14002.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040518134726.36369.qmail@web14002.mail.yahoo.com>
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
Date: Tue, 18 May 2004 14:38:38 -0400
To: Sam King <sam_king18@yahoo.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, May 18, 2004 at 06:47:26AM -0700, Sam King wrote:
> >From what I can tell, when the guest kernel takes a
> timer interrupt (SIGALRM) it eventually updates the
> tsk->need_resched parameter for processes that have
> been running for too long.  However, I do not see
> where the actual switch takes place except in the
> interrupt_end() function which is only called as a
> result of guest application system calls and signals. 

Exactly.  Every kernel entrance is either a system call or signal (a UML
signal, not a process signal, BTW), so there is a preemption opportunity
at every return to userspace.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
