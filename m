Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dt33t-0000tj-Dc	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Jul 2005 05:43:33 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.44)
	id 1Dt33r-0003rX-4y	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Jul 2005 05:43:33 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Am I doing something wrong with -skas0?
Message-ID: <20050714123720.GA25689@ccure.user-mode-linux.org>
References: <200507122346.40320.rob@landley.net>
	<200507131656.37695.rob@landley.net>
	<20050713232934.GB16051@ccure.user-mode-linux.org>
	<200507132102.46910.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507132102.46910.rob@landley.net>
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
Date: Thu, 14 Jul 2005 08:37:20 -0400
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Jul 13, 2005 at 09:02:46PM -0500, Rob Landley wrote:
> There's only one pid, the ./linux process gdb fired off.  

No, there's the pid that's being ptraced, and I need the maps for it.

> The breakpoint you 
> mentioned was accepted (it said breakpoint set and gave me an address), but 
> it was never reached.

Then put a while(1) ; just before the panic and kill -INT uml-pid when it
freezes.  That will get you a gdb prompt where you need it.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
