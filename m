Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Geccy-0000Ji-Nm for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Oct 2006 11:16:56 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Gecct-0007Cj-Jc
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Oct 2006 11:16:56 -0800
Date: Mon, 30 Oct 2006 15:14:54 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20061030201454.GA6079@ccure.user-mode-linux.org>
References: <20061029191723.12292.50164.stgit@americanbeauty.home.lan>
	<20061029192029.12292.15703.stgit@americanbeauty.home.lan>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20061029192029.12292.15703.stgit@americanbeauty.home.lan>
Subject: Re: [uml-devel] [PATCH 03/11] uml ubd driver: var renames
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Sun, Oct 29, 2006 at 08:20:29PM +0100, Paolo 'Blaisorblade' Giarrusso wrote:
> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> 
> and then call any "struct ubd" ubd_dev instead of dev, which doesn't
> make clear what we're treating (and no, it's not hungarian notation -
> not any more than calling all vm_area_struct vma or all inodes
> inode).

I can't say that I like this part of it.  I don't see any alternate
interpretation of a variable called 'dev', and renaming it to
'ubd_dev' seems redundant, given that we are in the ubd driver.

Plus, this change sent a couple of lines over the 80-character
boundary.

				Jeff

Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
