Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CP8Iz-0004Eg-En for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Nov 2004 15:43:13 -0800
Received: from mailgate2.uni-paderborn.de ([131.234.22.35])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CP8Iy-00084v-7t
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Nov 2004 15:43:13 -0800
Message-ID: <41881BA8.80102@upb.de>
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
MIME-Version: 1.0
References: <20041029092641.8558.qmail@web26102.mail.ukl.yahoo.com>
	<200411021952.09095.blaisorblade_spam@yahoo.it>
In-Reply-To: <200411021952.09095.blaisorblade_spam@yahoo.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: Stop at startup on 2.6 NPTL hosts
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
Date: Wed, 03 Nov 2004 00:43:36 +0100
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Roland Kaeser <roli8200@yahoo.de>, Nuno Silva <nuno.silva@vgertech.com>, Antoine Martin <antoine@nagafix.co.uk>, Dennis Muhlestein <devel@muhlesteins.com>

> It is one UML bug I've just identified and that I'm trying to fix. This is the 
> faulty code, from arch/um/kernel/skas/process.c:
> 
> static int userspace_tramp(void *arg)
> {
>         init_new_thread_signals(0);
>         enable_timer();
>         ptrace(PTRACE_TRACEME, 0, 0, 0);
>         tkill(gettid(), SIGSTOP);
>         os_stop_process(os_getpid());
>         return(0);
> }
> 
> This is executed by a clone() child. What happens is that, with NPTL, both the 
> father and the son have the same pid, so the SIGSTOP is routed to the wrong 
> thread. However, this is not expected: having the same pid should be reserved 
> to when clone is called with CLONE_THREAD in the flags. I've verified that 
> this is not happening in this case, even with strace (to make sure glibc is 
> not playing any dirty tricks). But for some reasons, the kernel is behaving 
> as if this happened.

This does remind me of something. I've already read the whole thing with 
CLONE_THREAD and clone() somewhere else, but i can't remember where it 
was. Was it on UML-MailingLists? Or was it even on the LKML? If my brain 
would just be a bit more reliable :-(


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
