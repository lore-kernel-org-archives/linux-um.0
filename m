Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNJwb-00084i-NQ for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Oct 2004 16:44:37 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CNJwb-0006Dx-0P for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Oct 2004 16:44:37 -0700
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: [patch 7/7] uml: resolve symbols in back-traces
References: <200410272223.i9RMNj921852@mail.osdl.org>
	<200410282132.i9SLWhA3004709@ccure.user-mode-linux.org>
	<20041028205136.GA1888@taniwha.stupidest.org>
In-Reply-To: <20041028205136.GA1888@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410290144.11700.blaisorblade_spam@yahoo.it>
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
Date: Fri, 29 Oct 2004 01:44:11 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Chris Wedgwood <cw@f00f.org>, Jeff Dike <jdike@addtoit.com>, akpm@osdl.org, LKML <linux-kernel@vger.kernel.org>

On Thursday 28 October 2004 22:51, Chris Wedgwood wrote:
> On Thu, Oct 28, 2004 at 05:32:43PM -0400, Jeff Dike wrote:
> > They're not completely pointless, they just cater to an individual's
> > development environment, and that sort of stuff should be in the
> > environment, and not the code.
>
> unnecessary in the code then, the exception to this perhaps being the
> compile-command stuff that was (still is?) in some of the network
> drivers as that really is per-file state
??? I don't understand you well. If there are compile-commands for emacs, 
they're broken too - using make namefile.o ARCH=um is the kernel universal 
solution.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
