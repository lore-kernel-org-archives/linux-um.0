Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JCEqE-0004V6-PK for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Jan 2008 05:50:07 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JCEqD-0002gF-4j
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Jan 2008 05:50:06 -0800
Date: Tue, 8 Jan 2008 08:49:55 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080108134955.GA4963@c2.user-mode-linux.org>
References: <a76cf2070801080305y1a90bf72u1e0f7c5d7fe21c42@mail.gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a76cf2070801080305y1a90bf72u1e0f7c5d7fe21c42@mail.gmail.com>
Subject: Re: [uml-devel] mount
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
To: Saritha Reddy <sarithareddyt@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, Jan 08, 2008 at 04:35:16PM +0530, Saritha Reddy wrote:
> when i am trying to mount in user mode linux i  got this error
> 
> [root@localhost ~]# mount none /host -t hostfs
> mount: mount point /host does not exist

What's the problem?  Seems like a perfectly clear error message to me.

Did it occur to you to try creating /host and see what happens?

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
