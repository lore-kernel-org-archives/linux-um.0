Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IbJ0M-0007cU-J4 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Sep 2007 09:47:55 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IbJ0M-0003b8-4o
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Sep 2007 09:47:54 -0700
Date: Fri, 28 Sep 2007 12:47:48 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070928164748.GB7986@c2.user-mode-linux.org>
References: <20070927220923.96887EDE@kernel>
	<20070928150353.GC7010@c2.user-mode-linux.org>
	<1190995215.7344.67.camel@localhost>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1190995215.7344.67.camel@localhost>
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

On Fri, Sep 28, 2007 at 09:00:14AM -0700, Dave Hansen wrote:
> One more thing... have you had any problems getting
> arch/um/os-Linux/time.c to compile because of a lack of tv_to_nsec()?

That should be fixed in current -mm.

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
