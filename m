Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B1Xb1-0001Cf-Uw for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Mar 2004 13:20:03 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1B1XJC-0004WG-5F
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Mar 2004 13:01:38 -0800
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20040311213406.GB3484@ccure.user-mode-linux.org>
References: <200403082139.04082.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403082139.04082.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: Moving User EXPORT_SYMBOL to the right place
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
Date: Thu, 11 Mar 2004 16:34:06 -0500
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, Mar 08, 2004 at 09:39:04PM +0100, BlaisorBlade wrote:
> Here is the second version of the patch, which fulfills your requests.

I'm not really thrilled with parts of this either, but it gets rid of some
other nasties.  The main thing is you have it set up to be a kernelspace
file, which is sort of not the reason to be moving it under os.  Everything
there should be libc-based.  Plus those fake prototypes aren't very nice.

On the other hand, it gets rid of the nasty copied stuff from module.h,
and puts it in the right place.  So I guess it's a step forward overall with
some sideways and backwards steps along the way.

There's going to have to be be some interaction between user and kernel headers
in some places, and this looks like one of them.  I'm currently pondering
ways of doing cpp magic to make a userspace-includable header from a kernel
header, something like the generated constants that exist now.

This would let us make user_syms.c be a userspace file.

And, this is in 2.6.4.

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
