Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AWKmr-0000yq-UF
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 16 Dec 2003 11:23:17 -0800
Received: from tektonic.net
	([69.56.241.195] helo=unix.easyadmin ident=qmailr)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AWKmr-00023p-Jc
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 16 Dec 2003 11:23:17 -0800
Subject: Re: [uml-devel] uml-patch-2.4.22-7
From: Matt Ayres <matta@tektonic.net>
In-Reply-To: <200312161653.hBGGrDkS002312@ccure.user-mode-linux.org>
References: <200312161653.hBGGrDkS002312@ccure.user-mode-linux.org>
Content-Type: text/plain
Message-Id: <1071602585.3374.27.camel@wopr.tektonic.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Date: Tue, 16 Dec 2003 14:23:06 -0500
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Couple questions regarding these features (i'm fairly new to using UML
so I haven't  been tracking the list for long)

On Tue, 2003-12-16 at 11:53, Jeff Dike wrote:
> This is another sizable set of changes.  The major items in it are
> 	Sapan's real-time clock patch - this allows UML to sleep accurately,
> assuming enough idle cycles on the host

Is there a thread that I can be pointed to or a brief explanation of how
this is a benefit?

> 	it will now use /dev/anon if it's present on the host, which it won't
> be until I release that patch, which will be fairly soon.  In conjunction with
> ubd-mmap, I'm seeing ~25% host memory use reduction.
> 

ubd-mmap is new behavior that doesn't need to be enabled? (meaning, just
upgrade to -7 and we'll seen some better performance using the block
device) ?  Do you know how much performance is gained from ubd-mmap and
/dev/anon individually?





-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
