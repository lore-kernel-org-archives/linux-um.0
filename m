Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CpUo7-0004wi-PQ for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 14 Jan 2005 09:00:19 -0800
Received: from pool-151-203-218-166.bos.east.verizon.net ([151.203.218.166]
	helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CpUo4-0002St-0P
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 14 Jan 2005 09:00:17 -0800
Message-Id: <200501141922.j0EJMKnV003227@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Thu, 13 Jan 2005 22:00:51 +0100."
	<20050113210051.99326AB30@zion> 
References: <20050113210051.99326AB30@zion> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: [patch 02/11] uml: fix compilation for missing headers
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
Date: Fri, 14 Jan 2005 14:22:20 -0500
To: blaisorblade_spam@yahoo.it
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

blaisorblade_spam@yahoo.it said:
> If you think it cannot make sense to include both <sys/ptrace.h> and
> <linux/ptrace.h> (as userspace process, i.e. host includes), go
> complaining with glibc, or follow the linux-abi includes idea.

> However, the compilation failure is possibly glibc-version (or better
> glibc includes version) related - what I now is that the failure
> happens on my system with a glibc 2.3.4 (from Gentoo).

> Also, remove some syscalls from the syscall table, since some syscalls
> were added which are only inside -mm currently, and this prevents
> currently compilation. 

Hold off on this one.  I have different fixes for this in my tree.

The system ptrace headers (asm/ptrace.h, sys/ptrace.h, linux/ptrace.h) have
varying effects, depending on distro and architecture.  So, I decided to put
sysdep/ptrace_user.h in charge of supplying the system ptrace information to
the rest of UML.  This has some ripple effects which I am in the process of
sorting out.

On the system calls, I have them indef-ed depending on whether one of the
__NR_vperf symbols are defined.  This will go away when the entry points
are in both -mm and -linus.

				Jeff



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
