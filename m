Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D96vq-0004u4-Te for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 11:33:22 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1D96vn-0006Zn-MJ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 11:33:22 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 2/16] UML - Update defconfig
References: <200503072037.j27KbGbc003947@ccure.user-mode-linux.org>
	<200503081054.27975.rob@landley.net>
In-Reply-To: <200503081054.27975.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503092032.57936.blaisorblade@yahoo.it>
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
Date: Wed, 9 Mar 2005 20:32:57 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>, Jeff Dike <jdike@addtoit.com>

On Tuesday 08 March 2005 16:54, Rob Landley wrote:
> On Monday 07 March 2005 03:37 pm, Jeff Dike wrote:
> > Signed-off-by: Jeff Dike <jdike@addtoit.com>
> >
> > Index: linux-2.6.11/arch/um/defconfig
>
> While you're at it:
>
> Last I checked, when I extract a fresh kernel tarball and do a make ARCH=um
> menuconfig, it tries to set options based on the /boot/config file instead
> of defconfig, even though the architecture is different.

> Has this been fixed recently, or is it considered a feature?
I've tried to fix this but the fix was refused.

Actually, for the same arch it's a feature, but I wasn't able to convince the 
author to change this. I'll maybe retry again.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
