Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8i1Q-0006TB-V2 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Mar 2005 08:57:28 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1D8i1P-0000NJ-E5
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Mar 2005 08:57:28 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] [PATCH 2/16] UML - Update defconfig
References: <200503072037.j27KbGbc003947@ccure.user-mode-linux.org>
In-Reply-To: <200503072037.j27KbGbc003947@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200503081054.27975.rob@landley.net>
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
Date: Tue, 8 Mar 2005 10:54:27 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

On Monday 07 March 2005 03:37 pm, Jeff Dike wrote:
> Signed-off-by: Jeff Dike <jdike@addtoit.com>
>
> Index: linux-2.6.11/arch/um/defconfig

While you're at it:

Last I checked, when I extract a fresh kernel tarball and do a make ARCH=um 
menuconfig, it tries to set options based on the /boot/config file instead of 
defconfig, even though the architecture is different.

Has this been fixed recently, or is it considered a feature?


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
