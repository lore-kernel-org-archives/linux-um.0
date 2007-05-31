Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HtuMl-0000pm-4F for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 31 May 2007 16:47:39 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HtuMj-0006mK-M9
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 31 May 2007 16:47:39 -0700
Date: Thu, 31 May 2007 19:39:46 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070531233946.GA12493@c2.user-mode-linux.org>
References: <20070531181923.GA9904@c2.user-mode-linux.org>
	<20070531220716.GL5488@mami.zabbo.net>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070531220716.GL5488@mami.zabbo.net>
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
To: Zach Brown <zach.brown@oracle.com>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Thu, May 31, 2007 at 03:07:16PM -0700, Zach Brown wrote:
> Can you explain what motivated you to send out this patch?
> 
> It used to return 0.  It was changed because, unlike the syslet
> syscalls, sys_io_submit() doesn't have a simple 0 value to indicate
> success.  The current implementation wants to return the number of iocbs
> that were processed, including the one which blocked, from the cachemiss
> thread.  So before calling into an operation it sets task_ret_ret() so
> that the cachemiss thread can return it if it takes over.
> task_ret_reg() is holding a return value that is being returned by the
> cachemiss thread on behalf of a sys_io_submit() which blocked.
> 
> When I made the change I didn't really audit its effect on the other
> paths.  I suppose it's time to do that, and you could help by telling me
> if you saw something bad happen :).

The bad thing was sys_async_exec returning -NOSYS every time a new
cachemiss thread was created.

Without this patch, you'll see sys_async_exec failures with either of
the demos I sent out.  Dunno about the existing ones, but I bet they do
the same.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
