Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DRGCk-0003QW-MP	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 14:05:50 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DRGCi-0005qD-Kj	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 14:05:50 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] gdb debugging problem on uml-2.6.10
Message-ID: <20050428205149.GE25451@ccure.user-mode-linux.org>
References: <4271073D.3030800@yahoo.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4271073D.3030800@yahoo.com.cn>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 28 Apr 2005 16:51:49 -0400
To: "Mei,Jia" <cfs_eric@yahoo.com.cn>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, Apr 28, 2005 at 11:54:37PM +0800, Mei,Jia wrote:
> When I try gdb-5.3.90 with uml in vanilla-2.6.10 kernel. I found a problem.
> 
> When I set a breakpoint somewhere, and after some step, uml will
> always get a SIGTRAP signal and trap into gdb.

You are running UML inside gdb, not gdb inside UML, correct?

And you get a SIGTRAP from nowhere, someplace that you didn't set a 
breakpoint?

Can you post a gdb log of this?

And can you try something more recent than 2.6.10?

				Jeff


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
