Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EOhSj-0004PT-TC	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Oct 2005 13:08:01 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EOhSi-0002Wo-61
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Oct 2005 13:08:01 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [PATCH] UML TT-mode-only compile fix.
Message-ID: <20051009200049.GB6326@ccure.user-mode-linux.org>
References: <87psqf2s9p.dancerj%dancer@netfort.gr.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87psqf2s9p.dancerj%dancer@netfort.gr.jp>
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
Date: Sun, 9 Oct 2005 16:00:49 -0400
To: Junichi Uekawa <dancer@netfort.gr.jp>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, blaisorblade@yahoo.it

On Sun, Oct 09, 2005 at 02:06:42PM +0900, Junichi Uekawa wrote:
> Hi,
> 
> In today's linus's git tree, uml doesn't compile when it's configured for 
> only TT-mode.
> 
> This regression caused by:
> 	8923648c125421b0fcb240cde607e2748d099ab8
> 	[PATCH] uml: clear SKAS0/3 flags when running in TT mode
> 
> Signed-off-by: Junichi Uekawa <dancer@debian.org>

Can you send this to Linus, with an Acked-by: me?

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
