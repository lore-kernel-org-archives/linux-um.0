Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EOk3j-0002wW-T4	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Oct 2005 15:54:23 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EOk3m-0006qT-JZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Oct 2005 15:54:27 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: [PATCH] UML TT-mode-only compile fix.
Message-ID: <20051009224716.GB8282@ccure.user-mode-linux.org>
References: <87psqf2s9p.dancerj%dancer@netfort.gr.jp>
	<200510092126.04881.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510092126.04881.blaisorblade@yahoo.it>
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
Date: Sun, 9 Oct 2005 18:47:16 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Junichi Uekawa <dancer@netfort.gr.jp>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Sun, Oct 09, 2005 at 09:26:04PM +0200, Blaisorblade wrote:
> Thanks for the report and the patch, however I want to fix things a bit 
> differently... the thing _should_ compile anyway.
> 
> The macro is declared anyway and the var should exist anyway.
> The problem is just that they aren't declared, I think. Will fix.

Junichi, ignore what I said earlier.  If Blaisorblade wants to fix it 
differently, then we'll use his patch instead.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
