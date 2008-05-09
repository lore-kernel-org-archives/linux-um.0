Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Fri, 9 May 2008 11:13:41 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080509151341.GA10169@c2.user-mode-linux.org>
References: <20080508214106.8961.WEIYI.HUANG@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080508214106.8961.WEIYI.HUANG@gmail.com>
Subject: Re: [uml-devel] remove duplicated include
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
To: Huang Weiyi <weiyi.huang@gmail.com>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

On Thu, May 08, 2008 at 09:42:33PM +0800, Huang Weiyi wrote:
> Removed duplicated include file "kern_util.h" in 
> arch/um/drivers/ubd_kern.c.

Looks good, thanks.

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
