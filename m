Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ADCx5-0000GI-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 24 Oct 2003 18:10:47 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1ADCwQ-0004uT-BX
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 24 Oct 2003 18:10:06 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h9P0wKj17877
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 24 Oct 2003 20:58:20 -0400
Message-Id: <200310250115.h9P1FPaK004010@ccure.karaya.com>
Subject: Re: [uml-devel] [Fwd: kernel assertion failed] 
In-Reply-To: Your message of "Thu, 23 Oct 2003 09:41:29 EDT."
             <3F97DA89.4010900@enterasys.com> 
References: <3F97DA89.4010900@enterasys.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 24 Oct 2003 21:15:25 -0400
To: Demetrios Tsillas <jtsillas@enterasys.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

jtsillas@enterasys.com said:
> I haven't seen this one before so it may interest UML developers: 
>
> #0  panic (fmt=0xa01f8ccc "kernel BUG at %s:%d!\n") at panic.c:52
> #1  0xa000c7f9 in schedule () at sched.c:681
> #2  0xa00dd826 in __down (sem=0xa024999c) at semaphore.c:80
> #3  0xa00dd9a0 in __down_failed ()
> #4  0xa000f964 in __call_console_drivers (start=4390, end=4431) at 
> printk.c:311

This looks like another manifestation of the broken locking in the UML
console/serial line driver.

				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
