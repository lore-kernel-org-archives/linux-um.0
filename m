Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNI3m-0006kE-BX for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Oct 2004 14:43:54 -0700
Received: from pimout1-ext.prodigy.net ([207.115.63.77])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CNI3k-0002rI-Nt for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Oct 2004 14:43:54 -0700
From: Chris Wedgwood <cw@f00f.org>
Message-ID: <20041028214347.GC2269@taniwha.stupidest.org>
References: <200410272223.i9RMNj921852@mail.osdl.org>
	<200410282034.21922.blaisorblade_spam@yahoo.it>
	<20041028192824.GC851@taniwha.stupidest.org>
	<200410282302.48311.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410282302.48311.blaisorblade_spam@yahoo.it>
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
Date: Thu, 28 Oct 2004 14:43:47 -0700
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: akpm@osdl.org, user-mode-linux-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>, jdike@addtoit.com

On Thu, Oct 28, 2004 at 11:02:48PM +0200, Blaisorblade wrote:

> If Jeff says "OK", then someone can submit a separate patch removing
> all the final comments.

he did

> And never mix such unrelated changes in a patch.

idealistically i agree, but doing trivial / obvious cleanups inside
other patches is fine if you ask me

it's not like we are mixing semantically different changes



-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
