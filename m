Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JllIe-0000qd-84 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Apr 2008 06:34:16 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JllIZ-0000gu-Vy
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Apr 2008 06:34:15 -0700
Date: Tue, 15 Apr 2008 09:33:25 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080415133325.GA7882@c2.user-mode-linux.org>
References: <20080413.005559.143852921.xiyou.wangcong@gmail.com>
	<20080414234237.48ac4609.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080414234237.48ac4609.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: WANG Cong <xiyou.wangcong@gmail.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Mon, Apr 14, 2008 at 11:42:37PM -0700, Andrew Morton wrote:
> omg, when checkpatch bit into this patch my CPU melted.

Yeah, I've been scared to do a checkpatch run over that file.  I think
it's the only core file left in UML which hasn't been tidied.  Sorry.

Drop this one, and I'll send a another one which at least is tidied up
around the changed areas.

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
