Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNFxp-0007CX-EI for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Oct 2004 12:29:37 -0700
Received: from pimout3-ext.prodigy.net ([207.115.63.102])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CNFxh-00050L-Ha for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Oct 2004 12:29:37 -0700
From: Chris Wedgwood <cw@f00f.org>
Message-ID: <20041028192924.GD851@taniwha.stupidest.org>
References: <200410272223.i9RMNg921807@mail.osdl.org>
	<200410282049.42376.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410282049.42376.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: [patch 2/7] uml: Build fix for TT w/o SKAS
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
Date: Thu, 28 Oct 2004 12:29:24 -0700
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: akpm@osdl.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>

On Thu, Oct 28, 2004 at 08:49:42PM +0200, Blaisorblade wrote:

> Drop that - the fix is in my tree currently, I'll forward it
> soon. And the fix, instead of #ifdef'ing it out, adds the support
> for using TT & SYSEMU.

SKAS / SYSEMU are entirely uninteresting right now until the host OS
support for these gets merged

i really don't think it's a good enough reason to hold other things up
and i'd prefer to see the fixes go in as-is and further updates ontop
of these


-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
