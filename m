Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FaZeI-0005Ja-Co for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 May 2006 07:45:18 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FaZeG-0001O0-Te
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 May 2006 07:45:18 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [RFC] PATCH 3/4 - Time virtualization :
	PTRACE_SYSCALL_MASK
Message-ID: <20060501134552.GA3686@ccure.user-mode-linux.org>
References: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org>
	<200604261747.54660.blaisorblade@yahoo.it>
	<20060426154607.GA8628@ccure.user-mode-linux.org>
	<200604282228.46681.blaisorblade@yahoo.it>
	<20060429014956.GB9734@ccure.user-mode-linux.org>
	<20060501135127.GA1276@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060501135127.GA1276@nevyn.them.org>
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
Date: Mon, 1 May 2006 09:45:52 -0400
To: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

On Mon, May 01, 2006 at 09:51:27AM -0400, Daniel Jacobowitz wrote:
> On Fri, Apr 28, 2006 at 09:49:56PM -0400, Jeff Dike wrote:
> > On Fri, Apr 28, 2006 at 10:28:46PM +0200, Blaisorblade wrote:
> > > bitmask = 0;
> > > set_bit(__NR_tee, bitmask);
> > > ptrace(PTRACE_SET_TRACEONLY, bitmask);
> > 
> > Yup, I like this.
> 
> I really recommend you not do this.  

> Suppose the kernel knows about 32 more syscalls than userspace.  It's
> going to read extra bits out of the bitmask that userspace didn't
> initialize!

The example above is a sketch, not a fully formed, compilable user.  Every
proposed interface has had the mask length passed in - in the case
above in the data argument.

> Also, if you store the mask with the child process, it risks surprising
> existing tracers: attach, set mask, detach, then the next time someone
> attaches an old version of strace some syscalls will be "hidden".

Not if the mask only survives for the duration of a PTRACE_ATTACH, and
the mask is released on PTRACE_DETACH.

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
