Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FYraC-0006BB-NT for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Apr 2006 14:30:00 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FYraC-0007wh-Nm for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Apr 2006 14:30:00 -0700
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FYraB-0004dk-4a
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Apr 2006 14:30:00 -0700
Subject: Re: [uml-devel] Re: [RFC] PATCH 3/4 - Time virtualization :
	PTRACE_SYSCALL_MASK
From: "Charles P. Wright" <cwright@cs.sunysb.edu>
In-Reply-To: <20060426194009.GA9845@ccure.user-mode-linux.org>
References: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org>
	<20060420090514.GA9452@osiris.boeblingen.de.ibm.com>
	<444797F8.6020509@fujitsu-siemens.com>
	<1146083202.10211.1.camel@localhost.localdomain>
	<20060426194009.GA9845@ccure.user-mode-linux.org>
Content-Type: text/plain
Message-Id: <1146086993.10851.3.camel@localhost.localdomain>
Mime-Version: 1.0
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
Date: Wed, 26 Apr 2006 17:29:53 -0400
To: Jeff Dike <jdike@addtoit.com>
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Wed, 2006-04-26 at 15:40 -0400, Jeff Dike wrote:
> On Wed, Apr 26, 2006 at 04:26:42PM -0400, Charles P. Wright wrote:
> > I have a similar local patch that I've been using.  I think it would be
> > worthwhile to have an extra bit in the bitmap that says what to do with
> > calls that fall outside the range [0, __NR_syscall].  That way the
> > ptrace monitor can decide whether it is useful to get informed of these
> > "bogus" calls.
> 
> The bit needs to be somewhere, but I think sticking it in the syscall
> bitmask is a bad idea.  Mixing apples and oranges, as it were.
> Sticking it in the op is better, even though that's a bit of apples
> and oranges as well.
> 
> Another alternative would be to make it an option and set it with
> PTRACE_SETOPTIONS.
That is probably a better solution than sticking it in the request (I
assume you meant request by op).   I think spawning more PTRACE_*
requests that perform some permutation of PTRACE_SYSCALL is likely to
make things confusing.

Charles



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
