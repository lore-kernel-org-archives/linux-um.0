Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <shane@hathawaymix.org>) id 1LP7gL-00038t-Pf
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2009 03:53:41 +0000
Received: from out02.mta.xmission.com ([166.70.13.232])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LP7gJ-0001Rq-Gw for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2009 03:53:41 +0000
Message-ID: <49753063.8040007@hathawaymix.org>
Date: Mon, 19 Jan 2009 19:01:07 -0700
From: Shane Hathaway <shane@hathawaymix.org>
MIME-Version: 1.0
References: <20090115194033.GA10926@hack.private>	
	<20090116124158.4364e269.akpm@linux-foundation.org>	
	<200901170328.15178.rob@landley.net>	
	<dc84318c0901172223p57872a8cr227d940b1c0a908a@mail.gmail.com>	
	<20090119152104.GC6432@c2.user-mode-linux.org>
	<dc84318c0901191746g31d51c23g65da89190dc8bfd2@mail.gmail.com>
In-Reply-To: <dc84318c0901191746g31d51c23g65da89190dc8bfd2@mail.gmail.com>
Subject: Re: [uml-devel] [Patch] uml: fix a link error
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Daolong Wang <ahlongxp@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, Rob Landley <rob@landley.net>, Am?rico Wang <xiyou.wangcong@gmail.com>, Andrew Morton <akpm@linux-foundation.org>

Daolong Wang wrote:
> On Mon, Jan 19, 2009 at 11:21 PM, Jeff Dike <jdike@addtoit.com> wrote:
>> On Sun, Jan 18, 2009 at 02:23:46PM +0800, Daolong Wang wrote:
>>> I can confirm this link error.
>> In what environment?  I see no problems here.

I can also confirm this link error.  The problem occurs when compiling
either 2.6.28.1 or 2.6.27.12; I didn't try anything earlier.  The patch
suggested at this beginning of this thread did solve the link problem
and the resulting kernel ran for several hours.  However, I think the
patch is still probably incorrect.

I'm going to repost what I said in another message I sent today, this
time with a wider audience:

The problem is that the name "sigprocmask" is getting renamed to
"kernel_sigprocmask" by a compiler directive in arch/um/Makefile, then
that name gets mangled into "sys_kernel_sigprocmask" by the
SYSCALL_DEFINE3(sigprocmask, ...) macro in kernel/signal.c.

So, instead of the patch suggested earlier, I added the following line
to arch/um/sys-i386/sys_call_table.S:

#define sys_sigprocmask sys_kernel_sigprocmask

This made it compile and link correctly.  Look at the symbols generated
by the compile of signal.c to see what I mean:

# nm kernel/signal.o | grep sigprocmask
0000008f r __kstrtab_kernel_sigprocmask
00000040 r __ksymtab_kernel_sigprocmask
00001ea6 T kernel_sigprocmask
00002d67 T sys_kernel_sigprocmask
00001faf T sys_rt_sigprocmask

Unfortunately, it's a mystery to me that others haven't run into this
before.  My host environment is RHEL 4 inside some kind of chroot.

Shane


------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
