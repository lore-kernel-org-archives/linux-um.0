Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FYpFX-0006Mq-O7 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Apr 2006 12:00:31 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FYpFX-0006db-Te for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Apr 2006 12:00:31 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FYpFW-0003HH-Bu
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Apr 2006 12:00:31 -0700
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060426180110.GB8142@ccure.user-mode-linux.org>
References: <200604131719.k3DHJcZG004674@ccure.user-mode-linux.org>
	<m1d5feotur.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1d5feotur.fsf@ebiederm.dsl.xmission.com>
Subject: [uml-devel] Re: [RFC] PATCH 0/4 - Time virtualization
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
Date: Wed, 26 Apr 2006 14:01:10 -0400
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Wed, Apr 19, 2006 at 02:25:00AM -0600, Eric W. Biederman wrote:
> That patch should probably be separated, from the rest.
> But it looks like a fairly sane idea. 

Yeah, I'll keep these together for now, but the ptrace one is
conceptually different from the rest.

> I think you missed a couple essential things to a time namespace.
> Timers.  The posix timers, in particular.  The worst
> of those is the monotonic timer.  

Oops, thanks for pointing that out.

> In the case of migration the ugly case to properly handle is the
> monotonic timer.   That needs an offset yet it is absolutely forbidden
> to provide that offset from the inside.  So this is the one namespace
> that I think is inappropriate to use sys_unshare to create.
> We need a system call so that we can specify the minimum or the
> starting monotonic time base.

For migration, it looks like the container will have to specify the
time base at creation so that everything in it will have a consistent
view of time if they get moved around.

So, maybe it belongs in clone as a "backwards" flag similar to
CLONE_NEWNS.

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
