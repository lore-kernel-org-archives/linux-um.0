Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNHFM-0001cU-Kv for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Oct 2004 13:51:48 -0700
Received: from pimout2-ext.prodigy.net ([207.115.63.101])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CNHFK-0004gG-Qz for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Oct 2004 13:51:48 -0700
From: Chris Wedgwood <cw@f00f.org>
Message-ID: <20041028205136.GA1888@taniwha.stupidest.org>
References: <200410272223.i9RMNj921852@mail.osdl.org>
	<200410282034.21922.blaisorblade_spam@yahoo.it>
	<20041028192824.GC851@taniwha.stupidest.org>
	<200410282132.i9SLWhA3004709@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410282132.i9SLWhA3004709@ccure.user-mode-linux.org>
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
Date: Thu, 28 Oct 2004 13:51:36 -0700
To: Jeff Dike <jdike@addtoit.com>
Cc: Blaisorblade <blaisorblade_spam@yahoo.it>, akpm@osdl.org, user-mode-linux-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>

On Thu, Oct 28, 2004 at 05:32:43PM -0400, Jeff Dike wrote:

> They're not completely pointless, they just cater to an individual's
> development environment, and that sort of stuff should be in the
> environment, and not the code.

unnecessary in the code then, the exception to this perhaps being the
compile-command stuff that was (still is?) in some of the network
drivers as that really is per-file state


-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
