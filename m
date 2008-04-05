Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jhyvb-00011V-45 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Apr 2008 20:18:51 -0700
Received: from qb-out-0506.google.com ([72.14.204.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jhyva-0003HN-Py
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Apr 2008 20:18:51 -0700
Received: by qb-out-0506.google.com with SMTP id c8so118154qbc.4
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 04 Apr 2008 20:18:49 -0700 (PDT)
Date: Sat, 05 Apr 2008 11:15:46 +0800 (CST)
Message-Id: <20080405.111546.71557462.xiyou.wangcong@gmail.com>
From: WANG Cong <xiyou.wangcong@gmail.com>
In-Reply-To: <20080404154901.GB11545@c2.user-mode-linux.org>
References: <20080401.230641.146239754.xiyou.wangcong@gmail.com>
	<20080404154901.GB11545@c2.user-mode-linux.org>
Mime-Version: 1.0
Subject: Re: [uml-devel] [Patch] arch/um/os-Linux/main.c: Fix memory leaks.
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
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Jeff Dike <jdike@addtoit.com>
Date: Fri, 4 Apr 2008 11:49:01 -0400

> On Tue, Apr 01, 2008 at 11:06:41PM +0800, WANG Cong wrote:
> > 
> > This patch fixes possible memory leaks in the main() function of
> > arch/um/os-Linux/main.c.
> 
> I'm somewhat dubious about this - the memory is freed immediately
> before exiting, making this patch have no practical effect.
> 

I think all memory leaks indicate our logic is not right, although
this one maybe harmless.

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Register now and save $200. Hurry, offer ends at 11:59 p.m., 
Monday, April 7! Use priority code J8TLD2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
