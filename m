Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FRLNv-0003g8-P2 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Apr 2006 20:42:15 -0700
Received: from smtp-out.google.com ([216.239.45.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FRLNu-0003gM-LZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Apr 2006 20:42:15 -0700
Message-ID: <44348E08.1050502@google.com>
From: Daniel Phillips <phillips@google.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Re: [PATCH 12/16] UML - Memory hotplug
References: <200603241814.k2OIExNn005555@ccure.user-mode-linux.org>
	<20060324144535.37b3daf7.akpm@osdl.org>
	<20060325010524.GA8117@ccure.user-mode-linux.org>
	<44343E86.30301@google.com>
	<20060406015636.GE6924@ccure.user-mode-linux.org>
In-Reply-To: <20060406015636.GE6924@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
Date: Wed, 05 Apr 2006 20:42:00 -0700
To: Jeff Dike <jdike@addtoit.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Jeff Dike wrote:
> Yeah, it's a bit non-obvious what 0 means in the twisty little maze of
> GFP_ flags.
> 
> However, I do want to push the system into reclaim later.  It looks
> like the only difference between 0 and GFP_ATOMIC is the use of
> emergency pools, which I don't really want to exercise anyway.
> 
> ...This look OK to you?...
> 
> +			/* 0 means don't wait (like GFP_ATOMIC) and
> +			 * don't dip into emergency pools (unlike
> +			 * GFP_ATOMIC).
> +			 */
> +			new = kmalloc(sizeof(*new), 0);

If you have a believable use for gfp_mask=0 then why not add GFP_NOWAIT or some
such to gfp.h?

Regards,

Daniel


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
