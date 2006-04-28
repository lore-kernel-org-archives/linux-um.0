Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FZSNr-0007OG-FE for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Apr 2006 05:47:43 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FZSNq-0002th-L0 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Apr 2006 05:47:42 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FZSNp-0002fX-7D
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Apr 2006 05:47:42 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: [RFC] PATCH 0/4 - Time virtualization
Message-ID: <20060428114823.GA3641@ccure.user-mode-linux.org>
References: <200604131719.k3DHJcZG004674@ccure.user-mode-linux.org>
	<m1d5feotur.fsf@ebiederm.dsl.xmission.com>
	<20060426180110.GB8142@ccure.user-mode-linux.org>
	<200604281333.41358.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604281333.41358.blaisorblade@yahoo.it>
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
Date: Fri, 28 Apr 2006 07:48:23 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org

On Fri, Apr 28, 2006 at 01:33:40PM +0200, Blaisorblade wrote:
> > So, maybe it belongs in clone as a "backwards" flag similar to
> > CLONE_NEWNS.
> 
> I must note that currently every (?) flag allowed for unshare is also allowed
> for clone, so you need to do that anyway.

Currently.  We are running out of CLONE_ bits - in mainline, there are
three left, and two of them are likely to be used by CLONE_TIME and
CLONE_UTSNAME (or whatever that turns out to be called).

I'm eyeing the low eight bits (CSIGNAL) for future unshare flags, but
those would be unusable in clone().

And why should there be any overlap between clone flags and unshare
flags?  Isn't 
	clone(CLONE_TIME);
the same as 
	clone();
	unshare(CLONE_TIME);
?

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
