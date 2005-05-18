Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DYPOB-0005uy-J6	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 May 2005 07:19:11 -0700
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252] ident=93)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1DYPOA-0005kG-07
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 May 2005 07:19:11 -0700
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Message-ID: <20050518141925.GF29811@parcelfarce.linux.theplanet.co.uk>
References: <200505180420.j4I4KQ6H017322@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505180420.j4I4KQ6H017322@ccure.user-mode-linux.org>
Subject: [uml-devel] Re: [PATCH 4/9] UML - Delay loop cleanups
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
Date: Wed, 18 May 2005 15:19:26 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Wed, May 18, 2005 at 12:20:26AM -0400, Jeff Dike wrote:
> This patch cleans up the delay implementations a bit, makes the loops
> unoptimizable, and exports __udelay and __const_udelay.

	If you do exports in i386 delay.c, remove them from
arch/um/sys-i386/ksyms.c...


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
