Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Arqat-0005sn-IK
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 13 Feb 2004 19:35:51 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1ArqVR-0005Lu-PR
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 13 Feb 2004 19:30:14 -0800
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20040214040052.GB5007@ccure.user-mode-linux.org>
References: <20040112064620.GU1436@alcor.net> <200402140043.i1E0h7sq004297@ccure.user-mode-linux.org> <008201c3f29d$30a1e750$0201a8c0@hawk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <008201c3f29d$30a1e750$0201a8c0@hawk>
Subject: [uml-devel] Re: uml-patch-2.6.3-rc2-1, RTC, CPU > 2.1 Ghz
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
Date: Fri, 13 Feb 2004 23:00:52 -0500
To: "Christopher S. Aker" <caker@theshore.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, Feb 13, 2004 at 07:52:20PM -0600, Christopher S. Aker wrote:
> Looking at uml-patch-2.6.3-rc2-1, I noticed it needs the RTC fix (mhz to unsigned
> long long) for CPUs > 2.1Ghz   This is just a friendly reminder to make sure that
> change makes it into your 2.6 tree (looks good on 2.4)..

Right.  Generic fixes (2.4 and 2.6) usually start off in my 2.4 tree, then
get migrated into my 2.6 tree when I get around to it.

				Jeff


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
