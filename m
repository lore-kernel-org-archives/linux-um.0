Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FYpyA-0003JL-Sf for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Apr 2006 12:46:38 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FYpy9-00067G-K3
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Apr 2006 12:46:39 -0700
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060426184248.GB9269@ccure.user-mode-linux.org>
References: <200604170328.42599.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604170328.42599.jesper.juhl@gmail.com>
Subject: [uml-devel] Re: [PATCH 3/5] Remove redundant NULL checks before
	[kv]free - in arch/
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
Date: Wed, 26 Apr 2006 14:42:48 -0400
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Erich Focht <efocht@sonycom.com>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, eranian@hpl.hp.com, davidm@hpl.hp.com, Ben Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org, user-mode-linux-devel@lists.sourceforge.net, Jan Engelhardt <jengelh@linux01.gwdg.de>

On Mon, Apr 17, 2006 at 03:28:42AM +0200, Jesper Juhl wrote:
> Remove redundant NULL checks before [kv]free + small CodingStyle cleanup
> for arch/
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>

The UML bits are applied, thanks.

			Jeff


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
