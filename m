Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FdT5Y-0004Kr-9x for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 May 2006 07:21:24 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FdT5V-00020X-Oz
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 May 2006 07:21:24 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [PROBLEM] UML is killed by SIGALRM
Message-ID: <20060509142126.GA3906@ccure.user-mode-linux.org>
References: <Pine.LNX.4.58.0605091125400.24592@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0605091125400.24592@sbz-30.cs.Helsinki.FI>
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
Date: Tue, 9 May 2006 10:21:26 -0400
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: davem@davemloft.net, akpm@osdl.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, blaisorblade@yahoo.it, user-mode-linux-devel@lists.sourceforge.net

On Tue, May 09, 2006 at 11:28:19AM +0300, Pekka J Enberg wrote:
> UML in Linus' head doesn't start on my machine whereas 2.6.17-rc3 works 
> fine:

This is fixed for me by http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=6760da0197a6ee327a09dafc070b26e2f02651fe;hp=f0ec5e39765cd254d436a6d86e211d81795952a4

And that's been in Linus' git since last week.

				Jeff


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
