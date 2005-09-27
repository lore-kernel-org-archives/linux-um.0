Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EKLtz-0005gg-0e	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Sep 2005 13:18:11 -0700
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EKLtq-0005PU-PU
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Sep 2005 13:18:10 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by externalmx-1.sourceforge.net with esmtp (Exim 4.41)
	id 1EKLtn-0002Rv-Jd	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Sep 2005 13:18:02 -0700
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20050927193055.GA30451@ccure.user-mode-linux.org>
References: <200509271846.51804.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509271846.51804.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: Uml showstopper bugs for 2.6.14
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
Date: Tue, 27 Sep 2005 15:30:55 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, user-mode-linux-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>

On Tue, Sep 27, 2005 at 06:46:50PM +0200, Blaisorblade wrote:
> Jeff, have you any further notes to add?

Agree.

I have one more to add - that UML/x86_64 doesn't run with CONFIG_FRAME_POINTER
disabled.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
