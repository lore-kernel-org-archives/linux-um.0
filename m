Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EEAaB-0008Oj-MH	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Sep 2005 12:00:11 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)	id 1EEAa9-0002J7-D5
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Sep 2005 12:00:11 -0700
From: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20050910174630.063774000@zion.home.lan>
Message-ID: <Pine.LNX.4.58.0509101157170.30958@g5.osdl.org>
References: <20050910174452.907256000@zion.home.lan>
	<20050910174630.063774000@zion.home.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] Re: [patch 7/7] uml: retry host close() on EINTR
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
Date: Sat, 10 Sep 2005 12:00:01 -0700 (PDT)
To: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net



On Sat, 10 Sep 2005, Paolo 'Blaisorblade' Giarrusso wrote:
>
> When calling close() on the host, we must retry the operation when we get
> EINTR.

Actually, no.

If close() return EINTR, the file descriptor _will_ have been closed. The
error return just tells you that soem error happened on the file: for
example, in the case of EINTR, the close() may not have flushed all the
pending data synchronously.

Re-doing the close() is the wrong thing to do, since in a threaded 
environment, something else might have opened another file, gotten the 
same file descriptor, and you now close _another_ file.

(Normally, re-doing the close will just return EBADF, of course).

I'm going to drop this patch, but in case you've ever seen a case where 
EINTR actually means that the fd didn't get closed, please holler, and we 
need to fix it.

			Linus


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
