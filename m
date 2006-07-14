Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G1NzR-0004nM-7n for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 14 Jul 2006 06:45:58 -0700
Received: from srv5.dvmed.net ([207.36.208.214] helo=mail.dvmed.net)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1G1NzM-0002Ct-Sm
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 14 Jul 2006 06:45:54 -0700
Message-ID: <44B7A007.2010204@garzik.org>
Date: Fri, 14 Jul 2006 09:45:43 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
References: <44B79AB9.3020401@garzik.org>
In-Reply-To: <44B79AB9.3020401@garzik.org>
Subject: Re: [uml-devel] UML build broken everywhere?
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: jdike@karaya.com
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

Jeff Garzik wrote:
> I tried to build 2.6.17 and 2.6.17.4 UML on x86-64 with the attached 
> .config on a Fedora Core 5 OS, and it broke:

I just verified that ARCH=um on 32-bit x86 is also broken, with the same 
build errors, on 2.6.17, 2.6.17.4, and 2.6.18-rc1-gitX (latest).

	Jeff





-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
