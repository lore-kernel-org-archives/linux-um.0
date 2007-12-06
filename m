Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J05i5-0000GM-Hd for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Dec 2007 17:39:29 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1J05i3-0002AZ-Uo
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Dec 2007 17:39:29 -0800
Date: Wed, 5 Dec 2007 20:39:20 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071206013920.GA10961@c2.user-mode-linux.org>
References: <200712051853.45801.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200712051853.45801.stf_xl@wp.pl>
Subject: Re: [uml-devel] [PATCH] Avoid not intended gdb breakpoints removal
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Dec 05, 2007 at 06:53:45PM +0100, Stanislaw Gruszka wrote:
> Sometimes when UML is debugged gdb miss breakpoints.  

> So I do fix for UML,
> it simply do not call clone() with both SIGCHLD and CLONE_VM flags together. 
> Additionally __WALL flag is used for waitpid() to assure not miss clone
> and normal process events.

Woo!  You're my favorite person this week[1].

This has bugged me forever, and I was too scared to go into gdb to
figure out what its problem was.

A couple of comments:
1 - I think I would prefer to use __WCLONE instead of __WALL since
we know what type of process we are creating, and it seems clearer in
the code to say specifically what we want

1a - I think I would like to stick all those waits under some API in
helper.c as we already have an interface for creating children, and as
it stands now, the callers have knowlege about the internal aspects of
child creation that they probably shouldn't.

2 - I want to get this into mainline quickly, and I need a
Signed-off-by: from you before it goes anywhere.


				Jeff

[1] Narrowly beating out John Reiser, who will be my favorite person
of the week that he manages to boot UML under valgrind.

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
