Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNXPP-0006VP-6j for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Oct 2004 07:07:15 -0700
Received: from main.gmane.org ([80.91.229.2])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CNXPK-0007iR-0c for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Oct 2004 07:07:15 -0700
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1CNXPF-0002yZ-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 29 Oct 2004 16:07:05 +0200
Received: from roam245-197.fas.harvard.edu ([140.247.245.197])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 29 Oct 2004 16:07:05 +0200
Received: from lars by roam245-197.fas.harvard.edu with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 29 Oct 2004 16:07:05 +0200
From: Lars Kellogg-Stedman <lars@oddbit.com>
Message-ID: <lars-CA00F4.10070129102004@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Unexported symbol in 2.6.9?
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
Date: Fri, 29 Oct 2004 10:07:01 -0400
To: user-mode-linux-devel@lists.sourceforge.net

I just built a 2.6.9 UML kernel, and ended up with an error in the NTFS 
filesystem module.  The symbol "end_iomem" was undefined.  This appears 
to be defined in arch/um/um_arch.c, and adding EXPORT_SYMBOL(end_iomem) 
makes the error go away.

Is this the correct solution?

-- Lars



-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
