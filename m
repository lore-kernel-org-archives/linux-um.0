Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IkqpA-0007ot-Af for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Oct 2007 17:43:48 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ikqp8-0006FV-E0
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Oct 2007 17:43:48 -0700
Date: Wed, 24 Oct 2007 20:43:29 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071025004329.GA12372@c2.user-mode-linux.org>
References: <200710111754.46854.rob@landley.net>
	<20071024152240.GA7733@c2.user-mode-linux.org>
	<200710241646.54942.rob@landley.net>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200710241646.54942.rob@landley.net>
Subject: Re: [uml-devel] User Mode Linux still doesn't build in 2.6.23-final.
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
To: Rob Landley <rob@landley.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Wed, Oct 24, 2007 at 04:46:54PM -0500, Rob Landley wrote:
> Prebuilt for Ubuntu 7.04:
> http://landley.net/code/firmware/downloads/cross-compiler/host-i686/cross-compiler-sparc.tar.bz2
> 
> Source code:
> Or http://landley.net/code/firmware/downloads/firmware-0.2.2.tar.bz2

Thanks - I already got Dan Kegel's crosstools, and they did the trick.

What I'd like to do is have linux/swap.h include linux/pagemap.h, but
there's this scary comment about that not working on sparc.

When I fix this bug "correctly", sparc expodes into a mess of
interconnected headers which seem to boil down to sparc including
swap.h in pgtable.h when no one else does.

The thing is, sparc looks like it's doing things more correctly than
anyone else.  asm/pgtable.h (i386 and UML, and probably everyone
else except sparc) refers to swp_entry_t, which is defined in
linux/swap.h, without including swap.h and that's somehow OK.

So, from a quick look, it seems like this is a case of our headers
being too interconnected and sparc had to opt out in order to do
things more correctly.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
