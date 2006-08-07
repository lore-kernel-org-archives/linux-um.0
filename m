Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GADPO-0004zx-FF for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Aug 2006 15:17:14 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GADPN-0003iQ-Vj
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Aug 2006 15:17:14 -0700
Date: Mon, 7 Aug 2006 18:17:03 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060807221703.GD5890@ccure.user-mode-linux.org>
References: <20060806154700.536.32978.stgit@memento.home.lan>
	<20060806154705.536.49855.stgit@memento.home.lan>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20060806154705.536.49855.stgit@memento.home.lan>
Subject: Re: [uml-devel] [PATCH 3/3] uml: clean our set_ether_mac
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Sun, Aug 06, 2006 at 05:47:05PM +0200, Paolo 'Blaisorblade' Giarrusso wrote:
> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> 
> Clean set_ether_mac usage. Maybe could also be removed, but surely it can't be a
> global function taking a void* argument.
> 
> You may want to defer this patch to next kernel release.
> 
> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

This one I can go along with :-)

Acked-by: Jeff Dike <jdike@addtoit.com>

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
