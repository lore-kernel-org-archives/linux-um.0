Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AEbwI-000777-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 28 Oct 2003 14:03:46 -0800
Received: from smtp01.web.de ([217.72.192.180] helo=smtp.web.de)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1AEbvg-00073R-Bh
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 28 Oct 2003 14:03:08 -0800
Received: from [141.30.214.193] (helo=matrix)
	by smtp.web.de with asmtp (WEB.DE 4.99 #459)
	id 1AEbvZ-0003MN-00
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 28 Oct 2003 23:03:01 +0100
From: Torsten Boob <ddflatrate@web.de>
Message-Id: <20031028230244.0382a7e2.ddflatrate@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Kernel Panic
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
Date: Tue, 28 Oct 2003 23:02:44 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Hi,
i have a problem that i cant solve.

I'm coding a Module using UML. That module calls

tcp_alloc_pskb()

inside the kernel. That function allocates memory for a socket buffer inside the network sending path used inside the kernel. 
But iam calling it inside my module.

But calling it in my module gives me a:

Kernel panic: Kernel mode fault at addr 0x28, ip 0xa003d050

And then the whole UML goes down. No chance to make a backtrace, because gdb is killed too.


While playing with breakpoints i got that message, but only one time:

0xa0109d14 in sig_handler (sig=-1610608640, sc= {gs = 1024, __gsh = 0, fs = 64304, __fsh = 40959, es = 53718, __esh = 16406, ds = 28232, __dsh = 16417, edi = 1075922592, esi = 1075922592, ebp = 1073912488, esp = 1, ebx = 0, edx = 1073911876, ecx = 8, eax = 2, trapno = 2684353328, err = 1075922600, eip = 1412, cs = 18080, __csh = 16417, eflags = 0, esp_at_signal = 2684353276, ss = 9185, __ssh = 16405, fpstate = 0x9ffffb30, oldmask = 12, cr2 = 1075908832}) at trap_user.c:105 105 } (gdb)

That gave me the hint, that it could possibly a uml specific problem.

Can anybody please help me to solve my problem ?

Is there any chance to make a backtrace even if gdb was completly killed ?

What does that error message mean ? Where can i start searching for the error ?

Or any other ideas ?

Many Thanks
  Torsten Boob



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
