Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ak1hx-0006OD-Rn for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Jan 2004 05:50:49 -0800
Received: from mx2.elte.hu ([157.181.151.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Ak1hu-0006C8-Fz for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Jan 2004 05:50:46 -0800
From: Ingo Molnar <mingo@elte.hu>
Message-ID: <20040123135112.GA26758@elte.hu>
References: <20040120191706.GA32711@elte.hu> <20040120194328.GA1518@elte.hu>
	<20040120200105.GA2289@elte.hu> <20040122162139.GA28167@elte.hu>
	<20040123093541.GA21763@elte.hu>
	<20040123135647.GA6768@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040123135647.GA6768@ccure.user-mode-linux.org>
Subject: [uml-devel] Re: [patch] uml fixes, 2.6.1-mm5-A2
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
Date: Fri, 23 Jan 2004 14:51:12 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net


* Jeff Dike <jdike@addtoit.com> wrote:

> On Fri, Jan 23, 2004 at 10:35:41AM +0100, Ingo Molnar wrote:
> > hm, there's this code in arch/um/sys-i386/bugs.c:arch_handle_signal():
> > 
> >         ip = UPT_IP(regs);
> >         if((*((char *) ip) != 0x0f) || ((*((char *) (ip + 1)) & 0xf0) != 0x40))
> >                 return(0);
> > 
> > we are running in the UML kernel context here. Is the dereferencing of
> > IP safe? 
> 
> No, it's not.  There needs to be a copy_from_user in there.

ok - partial patch below. (Couldnt figure out how to include the proper
uaccess.h file to get copy_from_user() - so the build will fail with
this patch for the time being.)

	Ingo

--- linux/arch/um/sys-i386/bugs.c.orig	
+++ linux/arch/um/sys-i386/bugs.c	
@@ -183,15 +183,16 @@ void arch_check_bugs(void)
 
 int arch_handle_signal(int sig, union uml_pt_regs *regs)
 {
-	unsigned long ip;
+	unsigned char tmp[2];
 
 	/* This is testing for a cmov (0x0f 0x4x) instruction causing a
 	 * SIGILL in init.
 	 */
 	if((sig != SIGILL) || (TASK_PID(get_current()) != 1)) return(0);
 
-	ip = UPT_IP(regs);
-	if((*((char *) ip) != 0x0f) || ((*((char *) (ip + 1)) & 0xf0) != 0x40))
+	if (copy_from_user(tmp, UPT_IP(regs), 2))
+		panic("SIGILL in init, could not read instructions!\n");
+	if((tmp[0] != 0x0f) || ((tmp[1] & 0xf0) != 0x40))
 		return(0);
 
 	if(host_has_cmov == 0)


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
