Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DJFcO-0007R3-Fj for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Apr 2005 11:51:12 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DJFcM-0001fw-VM for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Apr 2005 11:51:12 -0700
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20050406203558.GA3307@ccure.user-mode-linux.org>
References: <4253E3D6.2000809@fujitsu-siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4253E3D6.2000809@fujitsu-siemens.com>
Subject: [uml-devel] Re: UML-patches to prepare UML/s390
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
Date: Wed, 6 Apr 2005 16:35:58 -0400
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: user-mode-linux devel <user-mode-linux-devel@lists.sourceforge.net>

On Wed, Apr 06, 2005 at 03:27:50PM +0200, Bodo Stroesser wrote:
> Here are the patches (tarball attached), that I've applied to
> UML 2.6.11 + incrementals, before adding s390-files.
> These patches are tested a bit on x86, but not on x86_64.

I merged these, except for the restartnointr one because I don't have
ERESTARTNOINTR in my /usr/include, inside a #ifdef KERNEL or not.

				Jeff


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
