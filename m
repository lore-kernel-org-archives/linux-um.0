Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ItSjx-0003jL-RR for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Nov 2007 10:50:01 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1ItSjx-0006T4-AM
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Nov 2007 10:50:01 -0800
Date: Sat, 17 Nov 2007 13:49:54 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071117184954.GB8206@c2.user-mode-linux.org>
References: <20071116214227.GA13877@c2.user-mode-linux.org>
	<473EC75F.5020208@tiscali.nl>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <473EC75F.5020208@tiscali.nl>
Subject: Re: [uml-devel] [PATCH 7/8] UML - add virt_to_pte
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Roel Kluin <12o3l@tiscali.nl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Sat, Nov 17, 2007 at 11:50:07AM +0100, Roel Kluin wrote:
> > +	if (!pte_present(*pte))
> > +		pte = NULL;
> 
> shouldn't you check again for (pte == NULL)?

No, because if the page isn't mapped, handle_page_fault would have
returned non-zero, and we would have already returned.

This is leaving aside issues of whether the page could have been
unmapped by another CPU (which isn't an issue right now, and for which
I have a patch to fix anyway).

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
