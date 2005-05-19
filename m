Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DYmXU-000324-RO	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 19 May 2005 08:02:20 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DYmXT-0005ep-0w	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 19 May 2005 08:02:20 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Question about the kernel thread in UML TT mode
Message-ID: <20050519145654.GA4018@ccure.user-mode-linux.org>
References: <000c01c55c59$37dd1e50$9eb3c68a@SHZ.ST.COM>
	<200505191531.31247.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505191531.31247.blaisorblade@yahoo.it>
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
Date: Thu, 19 May 2005 10:56:54 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Alex LIU <alex.liu@st.com>

On Thu, May 19, 2005 at 03:31:30PM +0200, Blaisorblade wrote:
> > Why? What does "&sig + 1" mean?
> I think that's because sig is on the stack, and &sig + 1 points to the datas 
> saved by the kernel when entering the signal handler, i.e. the registers of 
> the caller, saved to be restored on return.

Officially, it's the sigcontext structure.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
