Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DYJzE-0001tr-Pr	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 May 2005 01:33:04 -0700
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1DYJzD-0005OR-De
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 May 2005 01:33:04 -0700
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252] ident=93)
	by externalmx-1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1DYH7b-0000Jt-RK
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 May 2005 22:29:32 -0700
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Message-ID: <20050518052940.GE29811@parcelfarce.linux.theplanet.co.uk>
References: <200505180420.j4I4K5CS017303@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505180420.j4I4K5CS017303@ccure.user-mode-linux.org>
Subject: [uml-devel] Re: [PATCH 1/9] UML - small fixes left over from rc4
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
Date: Wed, 18 May 2005 06:29:40 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Wed, May 18, 2005 at 12:20:05AM -0400, Jeff Dike wrote:
> --- linux-2.6.12-rc.orig/arch/um/Kconfig_x86_64	2005-05-17 16:36:27.000000000 -0400
> +++ linux-2.6.12-rc/arch/um/Kconfig_x86_64	2005-05-17 16:37:06.000000000 -0400
> @@ -6,6 +6,10 @@ config 64BIT
>  	bool
>  	default y
>  
> +config TOP_ADDR
> + 	hex
> +	default 0x60000000
> +

Wrong.  If you want it to work, you need 0x80000000 here (or changed START
in x86_64 makefile.

ACK for the rest.


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
