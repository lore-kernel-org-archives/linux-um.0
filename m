Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FRLFt-0002ig-JI for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Apr 2006 20:33:57 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1FRLFr-0001QN-N8
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Apr 2006 20:33:57 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: [uml-devel] Re: [PATCH 12/16] UML - Memory hotplug
Message-Id: <20060405203233.5fb222ae.akpm@osdl.org>
In-Reply-To: <20060406015636.GE6924@ccure.user-mode-linux.org>
References: <200603241814.k2OIExNn005555@ccure.user-mode-linux.org>
	<20060324144535.37b3daf7.akpm@osdl.org>
	<20060325010524.GA8117@ccure.user-mode-linux.org>
	<44343E86.30301@google.com>
	<20060406015636.GE6924@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Date: Wed, 5 Apr 2006 20:32:33 -0700
To: Jeff Dike <jdike@addtoit.com>
Cc: phillips@google.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Jeff Dike <jdike@addtoit.com> wrote:
>
> +			/* 0 means don't wait (like GFP_ATOMIC) and
>  +			 * don't dip into emergency pools (unlike
>  +			 * GFP_ATOMIC).
>  +			 */
>  +			new = kmalloc(sizeof(*new), 0);

What we've done in the past here is to use (GFP_ATOMIC & ~__GFP_HIGH).  It
amounts to the same thing, but it carries some semantic meaning: "whatever
GFP_ATOMIC measn, only don't dip into page reserves".

Plus it future-safes us against changes in GFP_ATOMIC.

I'll make that change.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
