Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Au5TV-0005rf-Oe
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 19 Feb 2004 23:53:29 -0800
Received: from mx1.elte.hu ([157.181.1.137])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1Au5Nm-0003Dk-UP
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 19 Feb 2004 23:47:35 -0800
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [uml-devel] Re: Diagnosed and repeatable kernel mode panic in schedule() for 2.6!
Message-ID: <20040220074831.GA673@elte.hu>
References: <200402151911.11890.blaisorblade_spam@yahoo.it> <200402162025.24853.blaisorblade_spam@yahoo.it> <200402170446.i1H4kUsq026113@ccure.user-mode-linux.org> <200402192001.26102.blaisorblade_spam@yahoo.it> <200402200206.i1K265QH004886@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402200206.i1K265QH004886@ccure.user-mode-linux.org>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 20 Feb 2004 08:48:31 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

* Jeff Dike <jdike@addtoit.com> wrote:

> I'm seeing two things, which don't happen deterministically :
> 	an exited process scheduling to itself, causing the exit.c BUG -
> I don't see what prevents a TASK_ZOMBIE process from being schedulable
> offhand. It doesn't seem to be dequeued from any runqueues as a result
> of calling exit().

a zombie task schedules away and is thus removed from the runqueue
within schedule() itself - and it's never (supposed to be) woken up.

	Ingo


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
