Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNQVt-00061g-Oz for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Oct 2004 23:45:29 -0700
Received: from almesberger.net ([63.105.73.238] helo=host.almesberger.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CNQVt-00037V-7p for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Oct 2004 23:45:29 -0700
From: Werner Almesberger <wa@almesberger.net>
Subject: Re: [uml-devel] Re: Why UML often does not build (was: Re: [PATCH]
	UML: Build fix for TT w/o SKAS)
Message-ID: <20041029034444.A24523@almesberger.net>
References: <20041027053602.GB30735@taniwha.stupidest.org>
	<200410282254.21944.blaisorblade_spam@yahoo.it>
	<20041028214242.GB2269@taniwha.stupidest.org>
	<200410290149.31665.blaisorblade_spam@yahoo.it>
	<20041029002831.GD12434@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029002831.GD12434@taniwha.stupidest.org>;
	from cw@f00f.org on Thu, Oct 28, 2004 at 05:28:31PM -0700
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
Date: Fri, 29 Oct 2004 03:44:44 -0300
To: Chris Wedgwood <cw@f00f.org>
Cc: Blaisorblade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>

Chris Wedgwood wrote:
> the problem here is that ptrace semantics are not well defined to
> anything subtle can and will break from time to time

I wonder what the "correct" solution for this would be: write a
specification for Linux ptrace, or try to get the POSIX folks
interested ?

Given that we get subtle ptrace breakages quite regularly, it
would be nice to see this eventually get resolved. "The
implementation is the specification" doesn't seem to work well
in this case.

BTW, things have improved around UML quite a bit recently, and I
think this is to no small amount due to Paolo's work.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/


-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
