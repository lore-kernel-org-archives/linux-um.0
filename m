Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FZreT-0000BK-B9 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 29 Apr 2006 08:46:33 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FZreT-0005FU-FD for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 29 Apr 2006 08:46:33 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1FZreS-0006IG-66
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 29 Apr 2006 08:46:33 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: [uml-devel] Re: [PATCH 0/6] UML - Small patches for 2.6.17
Message-Id: <20060429084430.27ea0d91.akpm@osdl.org>
In-Reply-To: <200604291641.19864.blaisorblade@yahoo.it>
References: <200604281601.k3SG11MJ007510@ccure.user-mode-linux.org>
	<20060428165534.6067f5aa.akpm@osdl.org>
	<200604291641.19864.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Date: Sat, 29 Apr 2006 08:44:30 -0700
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, jdike@addtoit.com, linux-kernel@vger.kernel.org

Blaisorblade <blaisorblade@yahoo.it> wrote:
>
> > Unless one considers 
>  > UML coding style to be a bug, which is an attractive idea ;)
> 
>  Well, we're slowly working on that... very slowly... I've thought multiple 
>  times to at least run Lindent on arch/um but I've not spoken up because of 
>  all the conflicts we (me and Jeff) would get with patches in our queues.

Lindent doesn't do a terribly good job, and one ends up having to perform a
lot of manual fixups.  Perhaps as many as are presently needed.



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
