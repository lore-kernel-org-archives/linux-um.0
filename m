Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FaZuR-0006zj-TS for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 May 2006 08:01:59 -0700
Received: from nevyn.them.org ([66.93.172.17] ident=Debian-exim)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FaZuQ-0005sa-Nw
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 May 2006 08:02:00 -0700
From: Daniel Jacobowitz <dan@debian.org>
Subject: Re: [uml-devel] [RFC] PATCH 3/4 - Time virtualization :
	PTRACE_SYSCALL_MASK
Message-ID: <20060501150154.GA3405@nevyn.them.org>
References: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org>
	<200604261747.54660.blaisorblade@yahoo.it>
	<20060426154607.GA8628@ccure.user-mode-linux.org>
	<200604282228.46681.blaisorblade@yahoo.it>
	<20060429014956.GB9734@ccure.user-mode-linux.org>
	<20060501135127.GA1276@nevyn.them.org>
	<20060501134552.GA3686@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060501134552.GA3686@ccure.user-mode-linux.org>
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
Date: Mon, 1 May 2006 11:01:54 -0400
To: Jeff Dike <jdike@addtoit.com>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

On Mon, May 01, 2006 at 09:45:52AM -0400, Jeff Dike wrote:
> The example above is a sketch, not a fully formed, compilable user.  Every
> proposed interface has had the mask length passed in - in the case
> above in the data argument.

Oh.  Well, then, I must have missed a message when I read the thread
this morning - sorry.  I'll watch for the next posting.

-- 
Daniel Jacobowitz
CodeSourcery


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
