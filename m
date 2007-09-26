Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IaeYH-0003T4-DF for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Sep 2007 14:36:13 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IaeYE-00082m-3s
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Sep 2007 14:36:11 -0700
Date: Wed, 26 Sep 2007 17:35:56 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070926213556.GA11392@c2.user-mode-linux.org>
References: <87ejglqh18.fsf@hades.wkstn.nix>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87ejglqh18.fsf@hades.wkstn.nix>
Subject: Re: [uml-devel] Is commit da3e30e78ed9652322dccb49fa149e7b4e985f74
	a candidate for -stable?
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
To: Nix <nix@esperi.org.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Sep 26, 2007 at 09:59:47PM +0100, Nix wrote:
> Without this commit, you can't compile UML on a system with 2.6.22
> kernel headers (the reserved2 and reserved3 fields have been
> renamed). With it, you can use 2.6.22 or older as you like.

I take nominations...

The ones I decide on myself are those where I have more than one
report of an already-fixed crash or compilation problem.

> (not forwarding to -stable because it seems importunate of me to do so:
> is this being too cautious?)

This is a good forum.

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
