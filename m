Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FZRES-000832-AG for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Apr 2006 04:33:56 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FZRES-0002LN-Bn for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Apr 2006 04:33:56 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FZREN-0000Vd-E7
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Apr 2006 04:33:56 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [RFC] PATCH 0/4 - Time virtualization
References: <200604131719.k3DHJcZG004674@ccure.user-mode-linux.org>
	<m1d5feotur.fsf@ebiederm.dsl.xmission.com>
	<20060426180110.GB8142@ccure.user-mode-linux.org>
In-Reply-To: <20060426180110.GB8142@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604281333.41358.blaisorblade@yahoo.it>
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
Date: Fri, 28 Apr 2006 13:33:40 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org

On Wednesday 26 April 2006 20:01, Jeff Dike wrote:
> On Wed, Apr 19, 2006 at 02:25:00AM -0600, Eric W. Biederman wrote:

> > In the case of migration the ugly case to properly handle is the
> > monotonic timer.   That needs an offset yet it is absolutely forbidden
> > to provide that offset from the inside.  So this is the one namespace
> > that I think is inappropriate to use sys_unshare to create.
> > We need a system call so that we can specify the minimum or the
> > starting monotonic time base.

> For migration, it looks like the container will have to specify the
> time base at creation so that everything in it will have a consistent
> view of time if they get moved around.

> So, maybe it belongs in clone as a "backwards" flag similar to
> CLONE_NEWNS.

I must note that currently every (?) flag allowed for unshare is also allowed 
for clone, so you need to do that anyway.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
