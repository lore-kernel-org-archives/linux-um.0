Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JrsOW-0006OZ-EP for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 May 2008 03:21:36 -0700
Received: from [81.2.110.250] (helo=lxorguk.ukuu.org.uk)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JrsOU-0007fR-N2
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 May 2008 03:21:36 -0700
Date: Fri, 2 May 2008 11:12:33 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-ID: <20080502111233.66ea9428@core>
In-Reply-To: <alpine.LFD.1.10.0805021450260.3349@localhost.localdomain>
References: <alpine.LFD.1.10.0805021450260.3349@localhost.localdomain>
Mime-Version: 1.0
Subject: Re: [uml-devel] [Patch] UML: Fix inconsistence due to tty_operation
	change
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
Cc: akpm@linux-foundation.org, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Fri, 2 May 2008 14:59:46 +0800 (CST)
WANG Cong <xiyou.wangcong@gmail.com> wrote:

> 
> 'put_char' of 'struct tty_operations' has changed from 'void' into 'int'.
> This can also shut up comipler warnings.
> 
> Cc: Jeff Dike <jdike@addtoit.com>
> Signed-off-by: WANG Cong <wangcong@zeuux.org>

Acked-by: Alan Cox <alan@redhat.com>


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
