Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B2x0X-00014a-DL for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Mar 2004 10:40:13 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1B2x0V-0006MD-R5
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Mar 2004 10:40:12 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [PATCH] host context switch reduction
Message-ID: <20040315191310.GB23741@ccure.user-mode-linux.org>
References: <20040229043549.GA8583@ccure.user-mode-linux.org>
	<405596A9.4020601@darkman.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <405596A9.4020601@darkman.de>
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
Date: Mon, 15 Mar 2004 14:13:10 -0500
To: Sven 'Darkman' Michels <sven@darkman.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, Mar 15, 2004 at 12:42:33PM +0100, Sven 'Darkman' Michels wrote:
> Well, we just looked at the context switches. We started 3 UMLs which
> were doing a make world for xfree. Without patches the number of
> context switches per second was around 60k, with the patch it was around
> 40k - so it's noticeable, at least from the cs.

Sure it's going to have a noticable effect on cs, that's its whole point.

However, users don't see cs - they see how quickly things run.  I was a bit
dismissive of the 3.5% improvement of the kernel build, but if you look at
the 20-30% hit that UML takes, that 3.5% is a noticable chunk of it.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
