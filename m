Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNHfk-0000Cz-8M for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Oct 2004 14:19:04 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CNHfi-0000hj-Kx for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Oct 2004 14:19:03 -0700
From: Blaisorblade <blaisorblade_spam@yahoo.it>
References: <200410272223.i9RMNg921807@mail.osdl.org>
	<200410282049.42376.blaisorblade_spam@yahoo.it>
	<20041028192924.GD851@taniwha.stupidest.org>
In-Reply-To: <20041028192924.GD851@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410282319.48140.blaisorblade_spam@yahoo.it>
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
Date: Thu, 28 Oct 2004 23:19:47 +0200
To: Chris Wedgwood <cw@f00f.org>
Cc: akpm@osdl.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>

On Thursday 28 October 2004 21:29, Chris Wedgwood wrote:
> On Thu, Oct 28, 2004 at 08:49:42PM +0200, Blaisorblade wrote:
> > Drop that - the fix is in my tree currently, I'll forward it
> > soon. And the fix, instead of #ifdef'ing it out, adds the support
> > for using TT & SYSEMU.

> SKAS / SYSEMU are entirely uninteresting right now until the host OS
> support for these gets merged

Well, this is completely questionable. Even if SKAS3 will never be merged in 
mainline on the host side, the SKAS3 support in UML has already been merged. 
And I think SYSEMU will be much more welcome than those patches (in fact, 
it's completely independent from the SKAS patch).

For an earlier discussion, see:

http://www.kerneltraffic.org/kernel-traffic/kt20030106_199.html#4

And even if SKAS3 will not be merged, SKAS4 will, and the current UML SKAS 
code should need just a very few changes. While having the code in mainline 
is important to get it fixed with API changes.

> i really don't think it's a good enough reason to hold other things up
> and i'd prefer to see the fixes go in as-is and further updates ontop
> of these

This would be generally right, but for now, please hold on until next -rc.
Sorry for the problem and thanks for the help!
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
