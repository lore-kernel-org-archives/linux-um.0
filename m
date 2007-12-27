Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J7ixJ-0007xA-9h for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Dec 2007 18:58:45 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1J7ixI-0004id-Nt
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Dec 2007 18:58:45 -0800
Date: Wed, 26 Dec 2007 21:58:39 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071227025839.GA9140@c2.user-mode-linux.org>
References: <4772D501.6050306@gmail.com>
	<20071227004239.GB8218@c2.user-mode-linux.org>
	<47730E4A.3000007@gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <47730E4A.3000007@gmail.com>
Subject: Re: [uml-devel] __attribute_used__ error on 2.6.23.9
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
To: Todd Jackson <quantum.skyline@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Dec 26, 2007 at 06:30:34PM -0800, Todd Jackson wrote:
> That patch didn't work...I'm still seeing the same error with the patch 
> applied.

I would double-check that the patch is applied - I swear I saw some
similar error which that fixed.

> Is there anything glibc-specific that UML depends on?

Not that I know of.

You're seeing a syntax error, so just make arch/um/os-Linux/aio.i,
eyeball the result, and see what the used stuff is expanding into.
That should give you an idea what needs to be done.

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
