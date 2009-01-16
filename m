Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jdike@addtoit.com>) id 1LNxVI-0001rH-92
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Jan 2009 22:49:28 +0000
Received: from saraswathi.solana.com ([198.99.130.12])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LNxVG-0005KW-5f
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Jan 2009 22:49:28 +0000
Date: Fri, 16 Jan 2009 16:38:33 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20090116213833.GA11904@c2.user-mode-linux.org>
References: <20090115194033.GA10926@hack.private>
	<20090116124158.4364e269.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20090116124158.4364e269.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: =?iso-8859-1?Q?Am=E9rico?= Wang <xiyou.wangcong@gmail.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Fri, Jan 16, 2009 at 12:41:58PM -0800, Andrew Morton wrote:
> On Thu, 15 Jan 2009 19:40:33 +0000
> Am__rico Wang <xiyou.wangcong@gmail.com> wrote:
> >  #define sys_vm86old sys_ni_syscall
> >  #define sys_vm86 sys_ni_syscall
> > +#define sys_sigprocmask sigprocmask
> >  
> >  #define old_mmap old_mmap_i386
> >  
> 
> For how long has this problem been present?
> 
> Why aren't lots of other people reporting it?

There's no problem AFAICT.

This is just bogus.

As you point out, if sigprocmask were missing, people would have
noticed.  Also, the proposed definition would pull in the libc
system call wrapper, not the UML system call definition.

				Jeff

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
