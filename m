Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FZVft-0006Nw-A9 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Apr 2006 09:18:33 -0700
Received: from ebiederm.dsl.xmission.com ([166.70.28.69])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FZVfr-0007gx-VV
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Apr 2006 09:18:33 -0700
Subject: Re: [uml-devel] Re: [RFC] PATCH 0/4 - Time virtualization
References: <200604131719.k3DHJcZG004674@ccure.user-mode-linux.org>
	<200604281333.41358.blaisorblade@yahoo.it>
	<20060428114823.GA3641@ccure.user-mode-linux.org>
	<200604281554.32665.blaisorblade@yahoo.it>
From: ebiederm@xmission.com (Eric W. Biederman)
In-Reply-To: <200604281554.32665.blaisorblade@yahoo.it>
	(blaisorblade@yahoo.it's
	message of "Fri, 28 Apr 2006 15:54:31 +0200")
Message-ID: <m1wtd9d687.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Fri, 28 Apr 2006 10:18:00 -0600
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Blaisorblade <blaisorblade@yahoo.it> writes:

> So we get back to Eric's objection (which I haven't understood but that's my 
> problem).

My objection is that to handle the monotonic timer we need an additional
struct timespec argument when we create the time namespace.

There does not appear to be space in clone or unshare to pass that value.

Eric


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
