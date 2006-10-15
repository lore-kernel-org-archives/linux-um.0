Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GZ9x5-0000Np-QG for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 15 Oct 2006 10:39:07 -0700
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GZ9x2-00004x-OY
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 15 Oct 2006 10:39:07 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sun, 15 Oct 2006 19:35:48 +0200
References: <451E9BAB.5030009@linuxbox.cz>
	<200610140223.09328.blaisorblade@yahoo.it>
	<1160817830.11878.9.camel@nik-nb>
In-Reply-To: <1160817830.11878.9.camel@nik-nb>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200610151935.48276.blaisorblade@yahoo.it>
Subject: Re: [uml-devel]
	=?iso-8859-1?q?SKAS_mode_not_working=2C_x86=5F64_SMP_?=
	=?iso-8859-1?q?host=2C_x86=5F64=09guest_=2C_problems_with_noprocmm?=
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
To: user-mode-linux-devel@lists.sourceforge.net, nikola.ciprich@linuxbox.cz

On Saturday 14 October 2006 11:23, Nikola Ciprich wrote:
> Hi,
> thanks for tips! actually I'm really glad for them as I'd like to help
> in any way and later even join development if I'll be able to do sth ;).
> Actually there are two questions regarding to this I have:
> 1) You mentioned GIT, do You use it? or Jeff?

I use it, I was thinking about the Linus' git branch. If you use that, head 
Makefile won't tell you the whole truth (it won't tell you which commit you 
are on).

> I haven't noticed any UML 
> git branch...

Right, we queue our patches with quilt and send them through -mm. Jeff 
publishes his *development* quilt tree on UML homepage.

> 2) I'm still worried about this halt problem on amd64, can You give me
> some tips I could track it down?? I't only thing which is preventing me
> from migrating users on new machine, otherwise it seems to be working
> great (but of course I'm still really looking forward for full SKAS ;))

A 100%-cpu loop without messages is difficult to diagnose - the first answer 
is "check if SMP is enabled on that UML binary, disable SMP, and see if it 
disappears". SMP does not work; when Jeff will announce "SMP support ready" 
then it will be possible to start using it again.

Otherwise, if you enable debug info and recompile it, try attaching gdb to the 
process using 100% cpu (type gdb $vmlinux_binary $pid) and then type bt at 
the prompt. While recompiling, under "Kernel hacking" try enabling every 
debug option (excluding "kobject debugging" and a few others) - this is what 
I have on testing kernels, for reference (comes from a GIT head kernel):

CONFIG_PRINTK_TIME=y
CONFIG_ENABLE_MUST_CHECK=y
# CONFIG_UNUSED_SYMBOLS is not set
CONFIG_DEBUG_KERNEL=y
CONFIG_LOG_BUF_SHIFT=15
CONFIG_DETECT_SOFTLOCKUP=y
CONFIG_SCHEDSTATS=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_SLAB_LEAK=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_PI_LIST=y
CONFIG_RT_MUTEX_TESTER=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_FS is not set
CONFIG_DEBUG_VM=y
CONFIG_DEBUG_LIST=y
CONFIG_FRAME_POINTER=y
CONFIG_UNWIND_INFO=y
# CONFIG_FORCED_INLINING is not set
CONFIG_RCU_TORTURE_TEST=m
# CONFIG_CMDLINE_ON_HOST is not set
# CONFIG_PT_PROXY is not set
# CONFIG_GCOV is not set

> thanks a lot for Your patience with me...
> nik

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
