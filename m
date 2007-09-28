Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IbHNm-0001Cg-Hl for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Sep 2007 08:03:59 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IbHNk-0004Ig-UL
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Sep 2007 08:03:58 -0700
Date: Fri, 28 Sep 2007 11:03:53 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070928150353.GC7010@c2.user-mode-linux.org>
References: <20070927220923.96887EDE@kernel>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070927220923.96887EDE@kernel>
Subject: Re: [uml-devel] [PATCH] make UML call dentry_open() with a valid
	vfsmount
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
To: Dave Hansen <haveblue@us.ibm.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, Sep 27, 2007 at 03:09:23PM -0700, Dave Hansen wrote:
> 
> I'm trying to enforce the convention that you may not call
> dentry_open() with a NULL vfsmount.  This is so that the
> r/o bind mount patches can consistenty acquire write access
> to the mounts there.
> 
> This patch fixes up UML's HPPFS to track both the vfsmount
> and the dentry for its files.  Compile, but not runtime
> tested.

Can I get a Signed-off-by:?

			Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
