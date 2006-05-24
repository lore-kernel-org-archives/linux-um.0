Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fitjp-0006I0-Oj for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 May 2006 06:49:25 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FitjH-0000Ge-Oy
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 May 2006 06:48:53 -0700
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060524134920.GA3747@ccure.user-mode-linux.org>
References: <E1FipyN-0004Hz-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1FipyN-0004Hz-00@dorka.pomaz.szeredi.hu>
Subject: [uml-devel] Re: UML boot failure with kinit
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
Date: Wed, 24 May 2006 09:49:20 -0400
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, akpm@osdl.org

On Wed, May 24, 2006 at 11:48:11AM +0200, Miklos Szeredi wrote:
> UML now compiles on 2.6.17-rc4-mm3, but it fails to boot:
> 
> [...]
> kinit: do_mounts
> kinit: name_to_dev_t(98:0) = dev(0,0)
> kinit: root_dev = dev(0,0)
> kinit: trying to mount /dev/root on /root with type ext3
> kinit: Cannot open root device dev(0,0)
> [...]
> 
> Adding 'root=ubda' to the command line cures it.

hpa fixed this yesterday.  Something in klibc didn't support decimal
mm:nn device specifications.

				Jeff


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
