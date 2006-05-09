Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FdP1X-00087y-QD for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 May 2006 03:00:59 -0700
Received: from courier.cs.helsinki.fi ([128.214.9.1] helo=mail.cs.helsinki.fi)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FdP1W-0007Wa-Kb
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 May 2006 03:01:00 -0700
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
In-Reply-To: <20060509092154.GC9417@osiris.boeblingen.de.ibm.com>
Message-ID: <Pine.LNX.4.58.0605091259430.27821@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.58.0605091125400.24592@sbz-30.cs.Helsinki.FI>
	<20060509092154.GC9417@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [PROBLEM] UML is killed by SIGALRM
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
Date: Tue, 9 May 2006 13:00:44 +0300 (EEST)
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: davem@davemloft.net, akpm@osdl.org, linux-kernel@vger.kernel.org, blaisorblade@yahoo.it, jdike@karaya.com, user-mode-linux-devel@lists.sourceforge.net

On Tue, 9 May 2006, Heiko Carstens wrote:
> No idea what might cause this. Guess there are no messages on the console?

Nope.

On Tue, 9 May 2006, Heiko Carstens wrote:
> > I did a git bisect which found the offending commit:
> > 
> >     [IPV4]: inet_init() -> fs_initcall
> > 
> >     Convert inet_init to an fs_initcall to make sure its called before any
> >     device driver's initcall.
> 
> Could you try the patch below? It will move inet_init a bit down the chain of
> the initcall list. Even though I doubt it will help...

Tried it, still the same problem.

				Pekka


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
