Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNFMf-0005mC-RS for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Oct 2004 11:51:13 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CNFMe-0001Ye-Op for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Oct 2004 11:51:13 -0700
From: Blaisorblade <blaisorblade_spam@yahoo.it>
References: <200410272223.i9RMNg921807@mail.osdl.org>
In-Reply-To: <200410272223.i9RMNg921807@mail.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410282049.42376.blaisorblade_spam@yahoo.it>
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
Date: Thu, 28 Oct 2004 20:49:42 +0200
To: akpm@osdl.org, cw@f00f.org
Cc: jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>

On Thursday 28 October 2004 00:27, akpm@osdl.org wrote:
> From: Chris Wedgwood <cw@f00f.org>

> This is required to get UML to build with only TT mode.

Drop that - the fix is in my tree currently, I'll forward it soon. And the 
fix, instead of #ifdef'ing it out, adds the support for using TT & SYSEMU.
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
