Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IpP9o-00023D-C0 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Nov 2007 06:11:56 -0800
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IpP9m-0006By-7S
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Nov 2007 06:11:55 -0800
Date: Tue, 6 Nov 2007 14:11:43 +0000
From: Al Viro <viro@ftp.linux.org.uk>
Message-ID: <20071106141143.GI8181@ftp.linux.org.uk>
References: <20071106114602.GB7652@hacking>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071106114602.GB7652@hacking>
Subject: Re: [uml-devel] UML defconfig building failed again
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: WANG Cong <xiyou.wangcong@gmail.com>
Cc: jdike@karaya.com, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

On Tue, Nov 06, 2007 at 07:46:02PM +0800, WANG Cong wrote:
> 
> Hi, Jeff!
> 
> I used today's linus-tree and defconfig to compile uml, but it failed. Error messages are
> things like:
> 
> In file included from include/asm/processor-generic.h:13,
>                  from include/asm/processor.h:77,
>                  from include/asm/thread_info.h:11,
>                  from include/linux/thread_info.h:21,
>                  from include/linux/preempt.h:9,
>                  from include/linux/spinlock.h:49,
>                  from include/linux/seqlock.h:29,
>                  from include/linux/time.h:8,
>                  from include/linux/timex.h:57,
>                  from include/linux/sched.h:53,
>                  from arch/um/include/sysdep/kernel-offsets.h:2,
>                  from arch/um/kernel/asm-offsets.c:1:
> include/asm/ptrace.h:50: warning: ???struct user_fxsr_struct??? declared inside parameter list
> include/asm/ptrace.h:50: warning: its scope is only this definition or declaration, which is probably not what you want
> include/asm/ptrace.h:52: warning: ???struct user_fxsr_struct??? declared inside parameter list
> In file included from include/linux/timer.h:5,
>                  from include/linux/sched.h:87,
>                  from arch/um/include/sysdep/kernel-offsets.h:2,
>                  from arch/um/kernel/asm-offsets.c:1:
> include/linux/ktime.h: In function ???ktime_set???:
> include/linux/ktime.h:84: warning: comparison is always false due to limited range of data type
> 
> {snip}
> 
> It seems like CONFIG_X86_32 was not set. Any ideas?

Sigh...  Kbuild breakage this time...  See if %s/\<[AC]FLAGS\>/KBUILD_&/g
in arch/um/Makefile-i386 helps.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
