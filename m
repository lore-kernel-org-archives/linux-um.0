Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AsOyx-0001oz-Ga
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 15 Feb 2004 08:18:59 -0800
Received: from postman4.arcor-online.net ([151.189.0.154] helo=postman.arcor.de)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AsOvy-0003x9-He
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 15 Feb 2004 08:15:54 -0800
Received: from server.schwinge.homeip.net (c-180-202-50.n.dial.de.ignite.net [62.180.202.50])
	(authenticated bits=0)
	by postman.arcor.de (8.13.0.PreAlpha4/8.13.0.PreAlpha4) with ESMTP id i1FGFhUZ018195
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 15 Feb 2004 17:15:48 +0100 (MET)
From: Thomas Schwinge <schwinge-lists-sourceforge.net-user-mode-linux-devel@nic-nac-project.de>
Subject: Re: [uml-devel] uml-patch-2.6.3-rc2-1
Message-ID: <20040215162156.GA5298@server.schwinge.homeip.net>
References: <200402131818.i1DIIRsq002831@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402131818.i1DIIRsq002831@ccure.user-mode-linux.org>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 15 Feb 2004 17:21:56 +0100
To: user-mode-linux-devel@lists.sourceforge.net

On Fri, Feb 13, 2004 at 01:18:05PM -0500, Jeff Dike wrote:
> This patch updates UML to 2.6.3-rc2.

I just wanted to report that your patch also applies and compiles
cleanly to 2.6.3-rc3:
#v+
thomas@uml:~ > uname -a
Linux uml 2.6.3-rc3-1um #1 Sun Feb 15 16:46:39 CET 2004 i686 User unknown GNU/Linux
#v-

Regards,
 Thomas


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
