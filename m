Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AX2fo-0001dq-Vc
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 10:14:56 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1AX2fn-0002Ft-2x
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 10:14:55 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [PATCH] - fix for 2.4.22-7um RTC on CPUs faster than 2.1 GHz
Message-ID: <20031218183027.GA3388@ccure.user-mode-linux.org>
References: <Pine.LNX.4.58.0312181520100.15701@boston.corp.fedex.com> <000901c3c53e$4a759550$0201a8c0@hawk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000901c3c53e$4a759550$0201a8c0@hawk>
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
Date: Thu, 18 Dec 2003 13:30:27 -0500
To: "Christopher S. Aker" <caker@theshore.net>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Thu, Dec 18, 2003 at 02:09:39AM -0600, Christopher S. Aker wrote:
> So -- Below is a patch that changes the type of
> host_hz to unsigned long long.

Sigh, some people's machines are too fast...

Applied, thanks.

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
