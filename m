Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FZfWL-0007EO-M8 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Apr 2006 19:49:21 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FZfWL-0001i9-QG for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Apr 2006 19:49:21 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FZfWL-0006BA-Dc
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Apr 2006 19:49:21 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [RFC] PATCH 3/4 - Time virtualization :
	PTRACE_SYSCALL_MASK
Message-ID: <20060429014956.GB9734@ccure.user-mode-linux.org>
References: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org>
	<200604261747.54660.blaisorblade@yahoo.it>
	<20060426154607.GA8628@ccure.user-mode-linux.org>
	<200604282228.46681.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604282228.46681.blaisorblade@yahoo.it>
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
Date: Fri, 28 Apr 2006 21:49:56 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

On Fri, Apr 28, 2006 at 10:28:46PM +0200, Blaisorblade wrote:
> Ok, this gives us a definite proposal, which I finally like:
> 
> * to exclude sys_tee:
> 
> bitmask = 0;
> set_bit(__NR_tee, bitmask);
> ptrace(PTRACE_SET_NOTRACE, bitmask);
> 
> * to trace only sys_tee:
> 
> bitmask = 0;
> set_bit(__NR_tee, bitmask);
> ptrace(PTRACE_SET_TRACEONLY, bitmask);

Yup, I like this.

> the call fails if any of them is 1, and in the failure case E2BIG or 
> EOVERFLOW is returned

strerror(E2BIG) is "Arg list too long"

strerror(EOVERFLOW) is "Value too large for defined data type"

Neither of those seems right.  I'd just as soon stick with -EINVAL.

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
