Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ArLZL-0004a3-4f
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 12 Feb 2004 10:28:11 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1ArLY4-0005Cz-Bt
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 12 Feb 2004 10:26:52 -0800
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20040212185344.GD2834@ccure.user-mode-linux.org>
References: <200402041926.39098.jeffpc@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402041926.39098.jeffpc@optonline.net>
Subject: [uml-devel] Re: [patch] 2.6 uml & CONFIG_SMP fix
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
Date: Thu, 12 Feb 2004 13:53:44 -0500
To: Josef 'Jeff' Sipek <jeffpc@optonline.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Feb 04, 2004 at 07:26:29PM -0500, Josef 'Jeff' Sipek wrote:
> 	yesterday, I finally got around to fixing the code. Right now, it
> compiles, but there are some warnings that I didn't take a look at.
> This patch makes it compile with CONFIG_SMP, nothing more.
> I tested the resulting binary, and it works well in tt (I did NOT test
> skas.) 
> 

Applied, thanks.  The spinlock.h part wasn't exactly right - the thing to
do was create one that just includes the arch spinlock.h.  Although, I'm
not sure that symlinks are a bad idea in the case of those trivial headers.

				Jeff


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
