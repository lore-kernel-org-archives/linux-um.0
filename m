Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNGmc-0003QG-J5 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Oct 2004 13:22:06 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CNGma-0008TV-JH
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Oct 2004 13:22:06 -0700
Message-Id: <200410282132.i9SLWhA3004709@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Thu, 28 Oct 2004 12:28:24 PDT."
	<20041028192824.GC851@taniwha.stupidest.org> 
References: <200410272223.i9RMNj921852@mail.osdl.org>
	<200410282034.21922.blaisorblade_spam@yahoo.it>
	<20041028192824.GC851@taniwha.stupidest.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: [patch 7/7] uml: resolve symbols in back-traces
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
Date: Thu, 28 Oct 2004 17:32:43 -0400
To: Chris Wedgwood <cw@f00f.org>
Cc: Blaisorblade <blaisorblade_spam@yahoo.it>, akpm@osdl.org, user-mode-linux-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>

cw@f00f.org said:
> the emacs comments are gratuitous and completely pointless, they serve
> no useful purpose.  fwiw in my .emacs i have: 

Yeah, that's why I acked that particular change.

They're not completely pointless, they just cater to an individual's development
environment, and that sort of stuff should be in the environment, and not the
code.

				Jeff



-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
