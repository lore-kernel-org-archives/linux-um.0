Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AX4va-0000tr-9B
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 12:39:22 -0800
Received: from tektonic.net
	([69.56.241.195] helo=unix.easyadmin ident=qmailr)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AX4vZ-0002c9-QS
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 12:39:21 -0800
Subject: Re: [uml-devel] [PATCH] - fix for 2.4.22-7um RTC on CPUs faster
	than 2.1 GHz
From: Matt Ayres <matta@tektonic.net>
In-Reply-To: <20031218183027.GA3388@ccure.user-mode-linux.org>
References: <Pine.LNX.4.58.0312181520100.15701@boston.corp.fedex.com>
	 <000901c3c53e$4a759550$0201a8c0@hawk>
	 <20031218183027.GA3388@ccure.user-mode-linux.org>
Content-Type: text/plain
Message-Id: <1071779952.5769.14.camel@wopr.tektonic.net>
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
Date: Thu, 18 Dec 2003 15:39:13 -0500
To: Jeff Dike <jdike@addtoit.com>
Cc: "Christopher S. Aker" <caker@theshore.net>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Does this mean this fix is included in the 2.4.22-7 patch on your
website, a new -7 will be released shortly with this fix, or -8 will be
released shortly with this (and other) fixes?

On Thu, 2003-12-18 at 13:30, Jeff Dike wrote:
> On Thu, Dec 18, 2003 at 02:09:39AM -0600, Christopher S. Aker wrote:
> > So -- Below is a patch that changes the type of
> > host_hz to unsigned long long.
> 
> Sigh, some people's machines are too fast...
> 
> Applied, thanks.
> 
> 				Jeff
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: IBM Linux Tutorials.
> Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
> Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
> Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
-- 
Matt Ayres <matta@tektonic.net>
TekTonic



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
