Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FYn8y-0006wq-SN for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Apr 2006 09:45:36 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FYn8x-0005HV-9n
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Apr 2006 09:45:37 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [RFC] PATCH 3/4 - Time virtualization :
	PTRACE_SYSCALL_MASK
Message-ID: <20060426154607.GA8628@ccure.user-mode-linux.org>
References: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org>
	<200604212034.53486.blaisorblade@yahoo.it>
	<20060425162941.GB22807@ccure.user-mode-linux.org>
	<200604261747.54660.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604261747.54660.blaisorblade@yahoo.it>
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
Date: Wed, 26 Apr 2006 11:46:07 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

On Wed, Apr 26, 2006 at 05:47:54PM +0200, Blaisorblade wrote:
> If we can do without MASK_STRICT_VERIFY, that works fully, and
> anyway it's simpler - however, say, when running strace -e read,tee
> (sys_tee will soon be added, it seems) this call would fail, while it
> would be desirable to have it work as strace -e read. 
> 
> MASK_STRICT_VERIFY isn't necessarily the best solution, but if
> userspace must search the maximum allowed syscall by multiple
> attempts, we've still a bad API.
> 
> Probably, a better option (_instead_ of MASK_STRICT_VERIFY) would be
> to return somewhere an "extended error code" saying which is the
> last allowed syscall or (better) which is the first syscall which
> failed. I.e. if there is strace -e read,splice,tee and nor splice nor
> tee are supported, then this value would be __NR_splice and strace (or
> any app) could then decide what to do.

Why not just zero out the bits that the kernel knows about?  Then, if
we return -EINVAL, the process just looks at the remaining bits that
are set to see what system calls the kernel didn't know about.

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
