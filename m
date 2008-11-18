Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <viro@ftp.linux.org.uk>) id 1L2XCJ-0007DS-TN
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 Nov 2008 20:29:19 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1L2XCA-0008Dg-P1
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 Nov 2008 20:29:19 +0000
Date: Tue, 18 Nov 2008 19:26:26 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
Message-ID: <20081118192626.GU28946@ZenIV.linux.org.uk>
References: <20081118174250.GE3185@hack.voiplan.pt>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20081118174250.GE3185@hack.voiplan.pt>
Subject: Re: [uml-devel] [Patch] uml: fix undeclared variables
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Am??rico Wang <xiyou.wangcong@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

On Tue, Nov 18, 2008 at 05:42:51PM +0000, Am??rico Wang wrote:
> 
> Fix three compile errors about undeclared variables in
> arch/um/kernel/mem.c.

And what, pray tell, would initialize it?

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
