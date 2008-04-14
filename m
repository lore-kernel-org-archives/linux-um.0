Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JlQAA-0008Ov-6h for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Apr 2008 08:00:06 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JlQ9p-0002ax-Cm
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Apr 2008 07:59:50 -0700
Date: Mon, 14 Apr 2008 10:59:17 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080414145917.GC7186@c2.user-mode-linux.org>
References: <20080412.171747.26924099.xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080412.171747.26924099.xiyou.wangcong@gmail.com>
Subject: Re: [uml-devel] [Patch] arch/um/os-Linux/sys-i386/task_size.c:
	improve a bit
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
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Sat, Apr 12, 2008 at 05:17:47PM +0800, WANG Cong wrote:
> Improve this code a bit: check sigaction's return value and remove a useless
> fflush().

This looks fine.  BTW, some of the fflushing is on purpose, although
the one you removed does indeed look useless.  I want all output from
early boot to hit the screen as soon as possible, even in the absence
(so far) of a newline.  So, if there's any doubt about whether a
printf has a newline in it, it's flushed.

       	     	     Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
