Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EBEzT-0006fN-MF	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Sep 2005 10:06:11 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EBEzS-0001B5-25
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Sep 2005 10:06:11 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] stack and scheduler patches
Message-ID: <20050902165935.GA6651@ccure.user-mode-linux.org>
References: <431637F9.6030101@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <431637F9.6030101@oracle.com>
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
Date: Fri, 2 Sep 2005 12:59:35 -0400
To: Allan Graves <allan.graves@oracle.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Aug 31, 2005 at 07:06:33PM -0400, Allan Graves wrote:
> Jeff,
> Here's the patches.  Hope these meet your approval!
> Allan

Some comments - I have these all fixed:

	+        struct task_struct *from=(struct task_struct*)prev;
	+        struct task_struct *to=(struct task_struct*)next;
There's no need to cast when the source is a void *

	+          CHOOSE_MODE(switch_to_tt(prev, next),
	+             switch_to_skas(prev, next));
There's a CHOOSE_MODE_PROC which lets you avoid repeating common argument
lists, although I was doing this wrong here too.

	+extern int switch_to_skas(void *prev, void *next);
	+extern int switch_to_tt(void *prev, void *next);
Since these can't do anything but return 0, they might as well be void

	+        if (0==sscanf(ptr, "%d", &pid_requested) || pid_requested==-1) {
The pid_requested==-1 is redundant - if sscanf failed, we just want to bail out

	+        if((!to) || (pid_requested == 0)) {
Why the check against 0?

	+		next=(void *)current->thread.saved_task;
	+		prev=(void*)current;
No need to cast when the target is a void * either

Also, OK for me to add a Signed-off-by: you?

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
