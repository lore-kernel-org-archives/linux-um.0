Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IziPM-0007nY-Ne for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Dec 2007 16:46:36 -0800
Received: from ruby.spiritone.com ([216.99.193.130])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IziPM-0006QO-E2
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Dec 2007 16:46:36 -0800
Message-ID: <4755F4EC.4050902@BitWagon.com>
Date: Tue, 04 Dec 2007 16:46:36 -0800
From: John Reiser <jreiser@BitWagon.com>
MIME-Version: 1.0
References: <4755E360.4030505@BitWagon.com>
	<20071205002223.GC10763@c2.user-mode-linux.org>
In-Reply-To: <20071205002223.GC10763@c2.user-mode-linux.org>
Subject: Re: [uml-devel] reading uninit memory in do_io (ubd_kern.c)
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
To: Jeff Dike <jdike@addtoit.com>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

> Have you actually got UML running under valgrind?

It's up to the point of user mode for process 1; see log below.
That means much of initialization, annotating the slab allocator
(kmalloc) enough to "hide" the allocation structures from outside access
but allow the allocator to reference them itself, and enough changes
to valgrind to tolerate more forms of clone() and to handle switching
stacks via longjmp().  I sent my changes for valgrind-3.2.3 to
valgrind-developers last weekend.

----- console transcript running UML under memcheck
  [snip]
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Initialized stdio console driver
Console initialized on /dev/tty0
Initializing software serial port version 1
**24577** new_thread_handler  fn=0x807FD8C  arg=0x822AF48
  [snip: panic due to SIGSEGV seen from wait_stub_done()]
-----

-- 
John Reiser, jreiser@BitWagon.com

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
