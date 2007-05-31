Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Htsp5-0007rj-9S for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 31 May 2007 15:08:48 -0700
Received: from rgminet01.oracle.com ([148.87.113.118])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Htsp3-0000MV-TW
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 31 May 2007 15:08:47 -0700
Date: Thu, 31 May 2007 15:07:16 -0700
From: Zach Brown <zach.brown@oracle.com>
Message-ID: <20070531220716.GL5488@mami.zabbo.net>
References: <20070531181923.GA9904@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070531181923.GA9904@c2.user-mode-linux.org>
Subject: Re: [uml-devel] [PATCH] Syslets - Fix cachemiss_thread return value
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

> cachemiss_thread should explicitly return 0 or error instead of
> task_ret_reg(current) (which is -ENOSYS anyway) because
> async_thread_helper is careful to put the return value in eax anyway.

Can you explain what motivated you to send out this patch?

It used to return 0.  It was changed because, unlike the syslet
syscalls, sys_io_submit() doesn't have a simple 0 value to indicate
success.  The current implementation wants to return the number of iocbs
that were processed, including the one which blocked, from the cachemiss
thread.  So before calling into an operation it sets task_ret_ret() so
that the cachemiss thread can return it if it takes over.
task_ret_reg() is holding a return value that is being returned by the
cachemiss thread on behalf of a sys_io_submit() which blocked.

When I made the change I didn't really audit its effect on the other
paths.  I suppose it's time to do that, and you could help by telling me
if you saw something bad happen :).

- z

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
