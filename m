Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <viro@ftp.linux.org.uk>) id 1LRlMN-0003xO-1O
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jan 2009 10:39:59 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LRlMJ-0005zU-NE
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jan 2009 10:39:58 +0000
Date: Tue, 27 Jan 2009 09:23:14 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
Message-ID: <20090127092314.GZ28946@ZenIV.linux.org.uk>
References: <20090115194033.GA10926@hack.private>
	<20090116124158.4364e269.akpm@linux-foundation.org>
	<200901170328.15178.rob@landley.net>
	<dc84318c0901172223p57872a8cr227d940b1c0a908a@mail.gmail.com>
	<20090119152104.GC6432@c2.user-mode-linux.org>
	<dc84318c0901191746g31d51c23g65da89190dc8bfd2@mail.gmail.com>
	<49753063.8040007@hathawaymix.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <49753063.8040007@hathawaymix.org>
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
To: Shane Hathaway <shane@hathawaymix.org>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, Rob Landley <rob@landley.net>, Am?rico Wang <xiyou.wangcong@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Daolong Wang <ahlongxp@gmail.com>

On Mon, Jan 19, 2009 at 07:01:07PM -0700, Shane Hathaway wrote:
> The problem is that the name "sigprocmask" is getting renamed to
> "kernel_sigprocmask" by a compiler directive in arch/um/Makefile, then
> that name gets mangled into "sys_kernel_sigprocmask" by the
> SYSCALL_DEFINE3(sigprocmask, ...) macro in kernel/signal.c.
> 
> So, instead of the patch suggested earlier, I added the following line
> to arch/um/sys-i386/sys_call_table.S:
> 
> #define sys_sigprocmask sys_kernel_sigprocmask

Interesting...  Everything else aside, we have difference in e.g.
SYSCALL_DEFINE0 and SYSCALL_DEFINE3 behaviours: SYSCALL_DEFINE0(name)
will *not* do macro expansion in name and SYSCALL_DEFINE3(name, blah, ...)
will.

The reason is that we have name carried through extra layer of macros
in the latter case.  Argument is *NOT* a subject to expansion when it
is used with ##; however, passing it to another macro will expand it
just fine.

Regardless of the kludge with -D used by uml, I'd say that we want consistency
here; keeping the original behaviour would also be nice.

How about
#define SYSCALL_DEFINE1(name,...)    SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
etc.
with
#define SYSCALL_DEFINEx(x, name, ...)                                   \
        asmlinkage long sys##name(__SC_DECL##x(__VA_ARGS__))
?

That gives consistent behaviour in all cases and avoids the insane side
effects like this one.

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
