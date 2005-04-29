Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DRSAV-0005tx-Lo	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Apr 2005 02:52:19 -0700
Received: from fra-del-04.spheriq.net ([195.46.51.100])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)	id 1DRSAU-0005RL-LE
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Apr 2005 02:52:19 -0700
Received: from fra-out-01.spheriq.net (fra-out-01.spheriq.net [195.46.51.129])
	by fra-del-04.spheriq.net with ESMTP id j3T9q6Cr018668
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 29 Apr 2005 09:52:06 GMT
Received: from fra-cus-02.spheriq.net (fra-cus-02.spheriq.net [195.46.51.38])
	by fra-out-01.spheriq.net with ESMTP id j3T9q1oT004274
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 29 Apr 2005 09:52:03 GMT
From: Alex LIU <alex.liu@st.com>
Subject: RE: [uml-devel] Question about kernel_thread in UML TT mode
Message-ID: <001f01c54c9f$7d9dc5d0$90b3c68a@SHZ.ST.COM>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
In-Reply-To: <200504292220.48040.blaisorblade@yahoo.it>
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
Date: Fri, 29 Apr 2005 17:40:31 +0800
Content-Transfer-Encoding: 8bit
To: 'Blaisorblade' <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

On Thursday 29 April 2005, Blaisorblade wrote:
> What's kernel_thread_helper? 

kernel_thread_helper and kernel_thread are defined in i386 as following:
-----------------------------------------------
/*
 * This gets run with %ebx containing the
 * function to call, and %edx containing
 * the "args".
 */
extern void kernel_thread_helper(void);
__asm__(".section .text\n"
	".align 4\n"
	"kernel_thread_helper:\n\t"
	"movl %edx,%eax\n\t"
	"pushl %edx\n\t"
	"call *%ebx\n\t"
	"pushl %eax\n\t"
	"call do_exit\n"
	".previous");

/*
 * Create a kernel thread
 */
int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
{
	struct pt_regs regs;

	/* BProc: (SLAVE) kernel forks are not subject to BProc's
	 * remote process management stuff. */
	bproc_kcall();

	memset(&regs, 0, sizeof(regs));

	regs.ebx = (unsigned long) fn;
	regs.edx = (unsigned long) arg;

	regs.xds = __USER_DS;
	regs.xes = __USER_DS;
	regs.orig_eax = -1;
	regs.eip = (unsigned long) kernel_thread_helper;
	regs.xcs = __KERNEL_CS;
	regs.eflags = X86_EFLAGS_IF | X86_EFLAGS_SF | X86_EFLAGS_PF | 0x2;

	/* Ok, create the new process.. */
	return do_fork(flags | CLONE_VM | CLONE_UNTRACED, 0, &regs, 0, NULL, NULL);
}
-----------------------------------------------

I think kernel_thread_helper make the new generated kernel thread to call the function and then exit. But in UML there is no kernel_thread_helper. Then how does UML make its kernel thread call the function and then exit? Thanks a lot!

Alex




-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id5hix
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
