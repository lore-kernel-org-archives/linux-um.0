Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bp6fM-000747-7m for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Jul 2004 07:41:24 -0700
Received: from smtp.telkom.net.id ([203.130.196.196])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1Bp6fL-0002zG-9U for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Jul 2004 07:41:24 -0700
From: Mulyadi Santosa <a_mulyadi@telkom.net>
Reply-To: a_mulyadi@telkom.net
Subject: Re: [patch] Re: [uml-devel] Kallsyms on UML
References: <20040726002724.GA11374@kevlar.burdell.org>
	<20040726060108.GA17971@kevlar.burdell.org>
	<200407261618.33778.blaisorblade_spam@yahoo.it>
In-Reply-To: <200407261618.33778.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407262140.50298.a_mulyadi@telkom.net>
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
Date: Mon, 26 Jul 2004 21:40:50 +0700
To: BlaisorBlade <blaisorblade_spam@yahoo.it>, Sonny Rao <sonny@burdell.org>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

hello

> Yes, exactly. (It is not matter of EXPORT_SYMBOL, you're right).
Thanks for correcting me :-)

BTW, why vmlinux might miss the stack trace? is it just because it missed 
kallsysms?

> However, on any 2.6 UML, run cat /dev/kmem (which will panic, the fix is
> known but yet to submit) and say if you can get the stacktrace. For some
> reason, I cannot (even if dump_stack() is invoked); nothing is printed.
> Seems like the printk() are lost (maybe some tricks with bust_spinlock()
> are needed).

BTW, interesting to read tricks to beat lost printk, Paolo....can you share 
your trick to defeat it? Just using bust_spinlock? or....just crazy 
idea...force console/tty flush?

regards

Mulyadi



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
