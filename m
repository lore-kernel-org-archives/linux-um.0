Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aw6uC-0005qo-0x for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Feb 2004 13:49:24 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1Aw6lB-0003O4-7e
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Feb 2004 13:40:05 -0800
Received: from hirsch.in-berlin.de (localhost [127.0.0.1])
	by hirsch.in-berlin.de (8.12.11/8.12.11/Debian-1) with ESMTP id
	i1PLe2kq002440 for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 25 Feb 2004 22:40:02 +0100
Received: (from uucp@localhost)
	by hirsch.in-berlin.de (8.12.11/8.12.11/Debian-1) with UUCP id
	i1PLP209000725 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Feb 2004 22:25:02 +0100
Received: from bytesex.org (kraxel@localhost [127.0.0.1])
	by bytesex.org (8.12.3/8.12.3/Debian-6.6) with ESMTP id i1PLCZnW024008
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 25 Feb 2004 22:12:35 +0100
References: <20040223172012.GA29046@bytesex.org>
	<200402252047.59002.blaisorblade_spam@yahoo.it>
From: Gerd Knorr <kraxel@bytesex.org>
In-Reply-To: <200402252047.59002.blaisorblade_spam@yahoo.it>
Message-ID: <87smgyamnx.fsf@bytesex.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [uml-devel] Re: post-2.6.3 build error
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
Date: 25 Feb 2004 22:12:34 +0100
To: user-mode-linux-devel@lists.sourceforge.net

BlaisorBlade <blaisorblade_spam@yahoo.it> writes:

> __NR_sched_yield ] = (syscall_handler_t *) yield
> 
> It should refer to sys_sched_yield. yield() is not even asmlinkage, so this 
> could case serious problems, and it is commented as "for kernel usage". Also 
> I checked i386 syscall table, and it uses sys_sched_yield.

There is another related one (asmlinkage where it shouldn't be) in
mprotect.c.  With the new CONFIG_REGPARM config option it becomes
really important to get that right ...

  Gerd

Index: linux-2.6.3/mm/mprotect.c
===================================================================
--- linux-2.6.3.orig/mm/mprotect.c
+++ linux-2.6.3/mm/mprotect.c
@@ -221,7 +221,7 @@ fail:
 	return error;
 }
 
-asmlinkage long
+long
 do_mprotect(struct mm_struct *mm, unsigned long start, size_t len, 
 	     unsigned long prot)
 {


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
