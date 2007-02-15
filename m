Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HHWtv-0001xA-BP for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Feb 2007 19:03:15 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HHWtt-0000MA-QU
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Feb 2007 19:03:15 -0800
Date: Wed, 14 Feb 2007 21:54:23 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070215025423.GA9300@ccure.user-mode-linux.org>
References: <11715068631914-git-send-email-blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <11715068631914-git-send-email-blaisorblade@yahoo.it>
Subject: Re: [uml-devel] x86_64: fix 2.6.18 regression -
	PTRACE_OLDSETOPTIONS should be accepted
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
To: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>, stable@kernel.org

On Thu, Feb 15, 2007 at 03:34:23AM +0100, Paolo 'Blaisorblade' Giarrusso wrote:
> Index: linux-2.6.git/arch/x86_64/ia32/ptrace32.c
> ===================================================================
> --- linux-2.6.git.orig/arch/x86_64/ia32/ptrace32.c
> +++ linux-2.6.git/arch/x86_64/ia32/ptrace32.c
> @@ -246,6 +246,7 @@ asmlinkage long sys32_ptrace(long reques
>  	case PTRACE_SINGLESTEP:
>  	case PTRACE_DETACH:
>  	case PTRACE_SYSCALL:
> +	case PTRACE_OLDSETOPTIONS:
>  	case PTRACE_SETOPTIONS:
>  	case PTRACE_SET_THREAD_AREA:
>  	case PTRACE_GET_THREAD_AREA:
> 

I sent an equivalent patch in earlier today:

Index: linux-2.6/arch/x86_64/ia32/ptrace32.c
===================================================================
--- linux-2.6.orig/arch/x86_64/ia32/ptrace32.c
+++ linux-2.6/arch/x86_64/ia32/ptrace32.c
@@ -239,6 +239,8 @@ asmlinkage long sys32_ptrace(long reques
 	__u32 val;
 
 	switch (request) { 
+	case PTRACE_OLDSETOPTIONS:
+		request = PTRACE_SETOPTIONS;
 	case PTRACE_TRACEME:
 	case PTRACE_ATTACH:
 	case PTRACE_KILL:

I change the request so that PTRACE_OLDSETOPTIONS doesn't need to
propogate any further.  However, it is present in include/asm-x86_64,
so I guess that counts as being part of the x86_64 ABI.  That being
the case, I guess my patch can be dropped in favor of this one.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
