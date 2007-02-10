Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HFrOA-0003fp-EC for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Feb 2007 04:31:34 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HFrO5-0001JW-80
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Feb 2007 04:31:34 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sat, 10 Feb 2007 13:31:20 +0100
References: <200702100944.l1A9iSEp008813@shell0.pdx.osdl.net>
In-Reply-To: <200702100944.l1A9iSEp008813@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200702101331.20261.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [patch 094/241] uml: fix error output during early
	boot
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

On Saturday 10 February 2007 10:44, akpm@linux-foundation.org wrote:
> From: Jeff Dike <jdike@addtoit.com>
>
> The startup code panics a lot if anything goes wrong early on.  This is
> wrong for several reasons, like the kernel isn't running, so you can't
> really be calling into it yet, but the harm comes from useful error
> messages being trapped in the printk ring where no one will ever see them.
>
> This patch changes these panics to perror and printf in wrappers which also
> exit.  Normal, informational, prints are also wrapped so that
> fflush(stdout) is called after each one.  This is so the output appears in
> the correct sequence in the event of an error.

libc's printf has an enormous stack usage, so that my_printf is used for 
direct output instead of printf; if this is ok because it's bootup code, then 
*fatal* should be marked as "bootup code only"; otherwise we may reuse 
vsprintf() and write() or fputs(); this should match what happens in 
my_printf, to avoid any unlikely problem with libc's buffering.
-- 
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
