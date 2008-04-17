Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JmLZa-000100-Bk for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Apr 2008 21:18:10 -0700
Received: from qb-out-0506.google.com ([72.14.204.234])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JmLZa-0006Dp-1K
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Apr 2008 21:18:10 -0700
Received: by qb-out-0506.google.com with SMTP id c8so3164295qbc.4
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 16 Apr 2008 21:18:09 -0700 (PDT)
Date: Thu, 17 Apr 2008 12:13:56 +0800 (CST)
Message-Id: <20080417.121356.08390959.xiyou.wangcong@gmail.com>
From: WANG Cong <xiyou.wangcong@gmail.com>
In-Reply-To: <20080416152019.GA8693@c2.user-mode-linux.org>
References: <20080415133325.GA7882@c2.user-mode-linux.org>
	<20080416.133919.133424295.xiyou.wangcong@gmail.com>
	<20080416152019.GA8693@c2.user-mode-linux.org>
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
To: jdike@addtoit.com
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Jeff Dike <jdike@addtoit.com>
Date: Wed, 16 Apr 2008 11:20:19 -0400
> On Wed, Apr 16, 2008 at 01:39:19PM +0800, WANG Cong wrote:
> > From: Jeff Dike <jdike@addtoit.com>
> > Date: Tue, 15 Apr 2008 09:33:25 -0400
> > > On Mon, Apr 14, 2008 at 11:42:37PM -0700, Andrew Morton wrote:
> > > > omg, when checkpatch bit into this patch my CPU melted.
> 
> Here's a cleaned up version.
> 
>        	 	    Jeff

Looks OK for me. Thank you!

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
