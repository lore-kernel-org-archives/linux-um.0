Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNI7t-0007lc-JM for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Oct 2004 14:48:09 -0700
Received: from mail.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CNI7r-0005Z4-Tj for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Oct 2004 14:48:09 -0700
Message-ID: <03fe01c4bd38$1db50f80$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <200410272223.i9RMNg921807@mail.osdl.org>
	<200410282049.42376.blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: [patch 2/7] uml: Build fix for TT w/o SKAS
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
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
Date: Thu, 28 Oct 2004 23:50:17 +0200
To: user-mode-linux-devel@lists.sourceforge.net

hi!

i remember i had problems building SKAS w/o TT - has this been fixed already ?

regards
roland


----- Original Message ----- 
From: "Blaisorblade" <blaisorblade_spam@yahoo.it>
To: <akpm@osdl.org>; <cw@f00f.org>
Cc: <jdike@addtoit.com>; <user-mode-linux-devel@lists.sourceforge.net>; "LKML" <linux-kernel@vger.kernel.org>
Sent: Thursday, October 28, 2004 8:49 PM
Subject: [uml-devel] Re: [patch 2/7] uml: Build fix for TT w/o SKAS


> On Thursday 28 October 2004 00:27, akpm@osdl.org wrote:
> > From: Chris Wedgwood <cw@f00f.org>
> 
> > This is required to get UML to build with only TT mode.
> 
> Drop that - the fix is in my tree currently, I'll forward it soon. And the 
> fix, instead of #ifdef'ing it out, adds the support for using TT & SYSEMU.
> -- 
> Paolo Giarrusso, aka Blaisorblade
> Linux registered user n. 292729
> 
> 
> -------------------------------------------------------
> This Newsletter Sponsored by: Macrovision 
> For reliable Linux application installations, use the industry's leading
> setup authoring tool, InstallShield X. Learn more and evaluate 
> today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
> 


-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
