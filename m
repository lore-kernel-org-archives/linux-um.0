Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D6u1p-0001rH-RL for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Mar 2005 09:22:25 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D6u1V-0004SS-9g for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Mar 2005 09:22:25 -0800
Message-Id: <200503031853.j23IrNDS003496@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] 2.6.11 + uml.sf.net patches panic 
In-Reply-To: Your message of "Thu, 03 Mar 2005 15:53:07 +1300."
	<42267C13.1060703@rimuhosting.com> 
References: <42267C13.1060703@rimuhosting.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Thu, 03 Mar 2005 13:53:23 -0500
To: Peter <p.repliesignored@rimuhosting.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

p.repliesignored@rimuhosting.com said:
> I'm happy to carry on using vanilla 2.6.11.  But hopefully the stack
> trace below triggers some insight into a problem with one of the
> latest  uml.sf.net patches. 

The write_ldt just above the segfault in both stacks looks suspicious.

Could you try backing out the ldt patches:
	skas-hold-own-ldt
	ldt-use-stub

and see if the panic goes away?

				Jeff



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
