Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JlesS-00037Q-Tm for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Apr 2008 23:42:51 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JlesR-0002wI-1C
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Apr 2008 23:42:48 -0700
Date: Mon, 14 Apr 2008 23:42:37 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <20080414234237.48ac4609.akpm@linux-foundation.org>
In-Reply-To: <20080413.005559.143852921.xiyou.wangcong@gmail.com>
References: <20080413.005559.143852921.xiyou.wangcong@gmail.com>
Mime-Version: 1.0
Subject: Re: [uml-devel] [Patch] UML: Clean up arch/um/drivers/ubd_kern.c
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
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Sun, 13 Apr 2008 00:55:59 +0800 (CST) WANG Cong <xiyou.wangcong@gmail.com> wrote:

> Make some global functions and variables static.
> 
> And remove some useless declarations for local functions, since we just
> need to move their definitions ahead.

omg, when checkpatch bit into this patch my CPU melted.

ho hum.

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
