Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CDBfW-00071k-52 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Sep 2004 17:53:06 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CDBfM-0000aj-If
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Sep 2004 17:53:06 -0700
Message-Id: <200410010159.i911xDqR004636@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Signal handling: use the kernels restorer 
In-Reply-To: Your message of "Thu, 30 Sep 2004 21:59:08 +0200."
	<8B6FF516CBA0194AB0996705076B02520F7C40@ABGEX01E.abg.fsc.net> 
References: <8B6FF516CBA0194AB0996705076B02520F7C40@ABGEX01E.abg.fsc.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Thu, 30 Sep 2004 21:59:13 -0400
To: "Stroesser, Bodo" <Bodo.Stroesser@fujitsu-siemens.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, BlaisorBlade <blaisorblade_spam@yahoo.it>

Can you fix your mailer so that it doesn't wrap patches?

I mostly applied that (by hand since it was corrupt :-).

> But if a user directly calls sys_sigaction() without glibc being
> involved (e.g. via "int 0x80"), he can reset SA_RESTORER. Now the
> kernel should use it's own restorer-stub. On i386 it's located in the
> vsyscall-page. UML must use the old method of putting it onto the
> stack. The patch modifies the signal-stack-setup to get the restorer
> on the stack working.

This is the part I didn't apply.  As the comment says, gdb uses that as
a signature, and I don't want to change it for that reason.  Let's just 
leave it the same as as x86, even if that's wrong.

> While testing that stuff, I could crash UML by using the wrong
> systemcall-number in the restorer-stub (has been wrong for
> sys_sigreturn). I think, there is no check in sys_(rt_)sigreturn(),
> whether the contents of the stack is wrong.

If the syscall number is wrong, then it'll never hit sys_sigreturn.  It
sounds like there's some other sanity-checking that's missing.

> Unfortunately at the moment I can't see, what UML prints out, because
> messages to console are not displayed (don't know why, yet). If the
> system runs, I can use dmesg, but when it is crashed ... 

At gdb, printf "%s", log_buf

				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
