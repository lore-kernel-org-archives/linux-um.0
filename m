Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNKdK-000788-T2 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Oct 2004 17:28:46 -0700
Received: from pimout2-ext.prodigy.net ([207.115.63.101])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CNKdJ-00059y-CD for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Oct 2004 17:28:46 -0700
From: Chris Wedgwood <cw@f00f.org>
Subject: Re: [uml-devel] Re: Why UML often does not build (was: Re: [PATCH]
	UML: Build fix for TT w/o SKAS)
Message-ID: <20041029002831.GD12434@taniwha.stupidest.org>
References: <20041027053602.GB30735@taniwha.stupidest.org>
	<200410282254.21944.blaisorblade_spam@yahoo.it>
	<20041028214242.GB2269@taniwha.stupidest.org>
	<200410290149.31665.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410290149.31665.blaisorblade_spam@yahoo.it>
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
Date: Thu, 28 Oct 2004 17:28:31 -0700
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>

On Fri, Oct 29, 2004 at 01:49:31AM +0200, Blaisorblade wrote:

> Yes, it was using SIGKILL instead of PTRACE_KILL; this gets broken
> by 2.6.9.

the problem here is that ptrace semantics are not well defined to
anything subtle can and will break from time to time

if we can get UML in a more suitable state and perhaps get some minor
QA stuff merged (a new make target using initramfs maybe?) we could
'encourage' people to test UML more often

> Well, I've seen Christoph Hellwig not particularly happy about us,
> see for instance:
>
> http://linux.bkbits.net:8080/linux-2.5/cset@41752cc9xdFXib-03VDV5akqKJZ-yA?nav=index.html|ChangeSet@-7d

well, he is right in this case

it's hard to find a balance between keeping it working for existing
UML users (which is what i'm trying to make sure is the case) and
doing cleanups which people such as hch point out really are needed

> Sending a patch requires at least proof-reading it and writing a
> meaningful changelog.  Also, managing mails takes tons of time.

im happy to take any and all fixes w/o comments in any form for now if
you want to fire them off to me


-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
