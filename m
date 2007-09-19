Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IXn6Z-0002WX-D9 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 Sep 2007 17:07:50 -0700
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IXn6Y-0005xa-0r
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 Sep 2007 17:07:47 -0700
Date: Tue, 18 Sep 2007 17:07:33 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <20070918170733.c6399124.akpm@linux-foundation.org>
In-Reply-To: <20070918233336.GA9746@c2.user-mode-linux.org>
References: <20070918233336.GA9746@c2.user-mode-linux.org>
Mime-Version: 1.0
Subject: Re: [uml-devel] [PATCH] UML - Fix irqstack crash
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
To: Jeff Dike <jdike@addtoit.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Tue, 18 Sep 2007 19:33:36 -0400
Jeff Dike <jdike@addtoit.com> wrote:

> ===================================================================
> --- linux-2.6.17.orig/arch/um/os-Linux/signal.c	2007-09-09 11:15:37.000000000 -0400
> +++ linux-2.6.17/arch/um/os-Linux/signal.c	2007-09-18 12:32:40.000000000 -0400
> @@ -119,7 +119,7 @@ void (*handlers[_NSIG])(int sig, struct 
>  
>  void handle_signal(int sig, struct sigcontext *sc)
>  {
> -	unsigned long pending = 0;
> +	unsigned long pending = 1 << sig;

You want 1UL there.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
