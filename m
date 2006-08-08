Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GAb5c-000629-Hw for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Aug 2006 16:34:24 -0700
Received: from mx2.suse.de ([195.135.220.15])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GAb5b-0005sF-4n
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Aug 2006 16:34:24 -0700
References: <200608082058.k78KwGa4006531@ccure.user-mode-linux.org>
From: Andi Kleen <ak@suse.de>
Date: 09 Aug 2006 01:33:43 +0200
In-Reply-To: <200608082058.k78KwGa4006531@ccure.user-mode-linux.org>
Message-ID: <p73u04mol9k.fsf@verdi.suse.de>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH 1/2] Split i386 and x86_64 ptrace.h
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
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Rob Landley <rob@landley.net>, Kyle Moffett <mrmacman_g4@mac.com>

Jeff Dike <jdike@addtoit.com> writes:
> 
> x86_64 is also treated in this way for consistency.
> 
> This patch was run by linux-arch yesterday with no comment.

Well you should have sent it to me. 

I think I would prefer a well placed ifdef __KERNEL__ or two for this - i don't
like it when it becomes harder to grep include files like this
(like the errno->errno-base split was quite bad in this regard)

-Andi


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
