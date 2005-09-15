Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EG0HM-00080l-2e	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Sep 2005 13:24:20 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EG0HK-0006w8-LQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Sep 2005 13:24:20 -0700
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20050915192111.GD8106@ccure.user-mode-linux.org>
References: <200509142155.j8ELtm5c012124@ccure.user-mode-linux.org>
	<20050914223035.455f76b9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050914223035.455f76b9.akpm@osdl.org>
Subject: [uml-devel] Re: [PATCH 1/10] UML - _switch_to code consolidation
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
Date: Thu, 15 Sep 2005 15:21:11 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, allan.graves@gmail.com

On Wed, Sep 14, 2005 at 10:30:35PM -0700, Andrew Morton wrote:
> Which if any of these are -rc material?   uml-return-a-real-error-code.patch?

I consider them all to be 2.6.14 material, which is why I sent them.

With the exception of uml-breakpoint-an-arbitrary-thread.patch, which
adds a bit of functionality, they are all bug fixes and code
movement/cleanup.  In order of my preference of reaching mainline:

uml-remove-include-of-asm-elfh.patch
	serious bug - this fixes the x86_64 build

uml-preserve-errno-in-error-paths.patch
	serious bug - if you hit some of these, UML will hang

uml-return-a-real-error-code.patch
	a small bug, almost a cleanup

uml-remove-a-useless-include.patch
uml-remove-an-unused-file.patch
uml-remove-some-build-warnings.patch
	code cleanup

uml-move-libc-code-out-of-mem_userc-and-tempfilec.patch
uml-merge-mem_userc-and-memc.patch
	code movement

uml-_switch_to-code-consolidation.patch
	code cleanup - can be omitted from mainline if
	uml-breakpoint-an-arbitrary-thread.patch is

uml-breakpoint-an-arbitrary-thread.patch
	functionality


				Jeff


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
