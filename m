Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AX5p8-0004Kz-QF
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 13:36:46 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1AX5p6-0004Db-SC
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 13:36:45 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [PATCH] - fix for 2.4.22-7um RTC on CPUs faster than 2.1 GHz
Message-ID: <20031218215222.GB4090@ccure.user-mode-linux.org>
References: <Pine.LNX.4.58.0312181520100.15701@boston.corp.fedex.com> <000901c3c53e$4a759550$0201a8c0@hawk> <20031218183027.GA3388@ccure.user-mode-linux.org> <1071779952.5769.14.camel@wopr.tektonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1071779952.5769.14.camel@wopr.tektonic.net>
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
Date: Thu, 18 Dec 2003 16:52:22 -0500
To: Matt Ayres <matta@tektonic.net>
Cc: "Christopher S. Aker" <caker@theshore.net>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Thu, Dec 18, 2003 at 03:39:13PM -0500, Matt Ayres wrote:
> Does this mean this fix is included in the 2.4.22-7 patch on your
> website, a new -7 will be released shortly with this fix, or -8 will be
> released shortly with this (and other) fixes?

It'll be in -8.  I don't reuse patch numbers.

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
