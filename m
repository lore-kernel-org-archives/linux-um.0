Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Aa5AY-0005cX-MR
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 26 Dec 2003 19:31:14 -0800
Received: from mx13.sac.fedex.com ([199.81.197.53])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1Aa5AY-0007gg-1s
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 26 Dec 2003 19:31:14 -0800
Received: from inet03.prod.fedex.com (inet03.prod.fedex.com [199.81.10.43])
	by mx13.sac.fedex.com (8.12.6p2/8.12.3) with ESMTP id hBR3Ux4R099807
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 26 Dec 2003 21:31:03 -0600 (CST)
	(envelope-from jchua@fedex.com)
From: Jeff Chua <jchua@fedex.com>
Subject: Re: [uml-devel] ubd=mmap problem
In-Reply-To: <200312261936.46963.blaisorblade_spam@yahoo.it>
Message-ID: <Pine.LNX.4.58.0312271045240.13416@boston.corp.fedex.com>
References: <3FEAE023.6040908@darkman.de> <200312261936.46963.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 27 Dec 2003 10:46:08 +0800 (SGT)
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net


On Fri, 26 Dec 2003, BlaisorBlade wrote:

> This first problem is a known one. Did you mount the host root with hostfs
> inside Uml? If yes, check /var/log/messages and you should see an Oops from
> the host kernel. If that happens, apply on the host the patch in this thread
> on 10 Dec 2003:
>
> [uml-devel] [PATCH] fix for: Host panic when UML reads host /dev/shm

Can you please repost this patch?

Thanks,
Jeff



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
