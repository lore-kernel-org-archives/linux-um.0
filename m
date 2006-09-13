Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GNV2u-0003kN-Vz for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Sep 2006 06:44:57 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GNV2t-0004Dy-KS
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Sep 2006 06:44:56 -0700
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <200609121552.k8CFq4IE008007@ccure.user-mode-linux.org>
References: <200609121552.k8CFq4IE008007@ccure.user-mode-linux.org>
Date: Wed, 13 Sep 2006 13:57:50 +0100
Message-Id: <1158152271.9189.129.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Subject: Re: [uml-devel] [PATCH 1/2] Split i386 and x86_64 ptrace.h
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
To: Jeff Dike <jdike@addtoit.com>
Cc: akpm@osdl.org, zach@vmware.com, jeremy@xensource.com, user-mode-linux-devel@lists.sourceforge.net, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, ak@muc.de, 76306.1226@compuserve.com

On Tue, 2006-09-12 at 11:52 -0400, Jeff Dike wrote:
> The use of SEGMENT_RPL_MASK in the i386 ptrace.h introduced by
> x86-allow-a-kernel-to-not-be-in-ring-0.patch broke the UML build, as
> UML includes the underlying architecture's ptrace.h, but has no easy
> access to the x86 segment definitions.
> 
> Rather than kludging around this, as in the past, this patch splits
> the userspace-usable parts, which are the bits that UML needs, of
> ptrace.h into ptrace-abi.h, which is included back into ptrace.h.
> Thus, there is no net effect on i386.
> 
> As a side-effect, this creates a ptrace header which is close to being
> usable in /usr/include.

Yum. But you didn't add that new header to the Kbuild file so it doesn't
get exported. Please do so.

-- 
dwmw2


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
