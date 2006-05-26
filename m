Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fjd4C-0002Mx-2x for User-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 May 2006 07:13:28 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Fjd4A-0006v2-Fo
	for User-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 May 2006 07:13:28 -0700
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060526141345.GA4152@ccure.user-mode-linux.org>
References: <20060526032424.GA8283@ccure.user-mode-linux.org>
	<200605261236.26814.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605261236.26814.ak@suse.de>
Subject: [uml-devel] Re: [discuss] [RFC] [PATCH] Double syscall exit traces on
	x86_64
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
Date: Fri, 26 May 2006 10:13:45 -0400
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org, User-mode-linux-devel@lists.sourceforge.net, Steven James <pyro@linuxlabs.com>, Roland McGrath <roland@redhat.com>, Blaisorblade <blaisorblade@yahoo.it>

On Fri, May 26, 2006 at 12:36:26PM +0200, Andi Kleen wrote:
> I believe this patch is the correct fix. Can you confirm it works for you? 

Looks good, thanks.

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
