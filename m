Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G1Slc-0002XM-QC for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 14 Jul 2006 11:52:01 -0700
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1G1Slb-0003ih-Vl
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 14 Jul 2006 11:52:00 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Fri, 14 Jul 2006 20:52:05 +0200
References: <44B79AB9.3020401@garzik.org> <44B7A007.2010204@garzik.org>
In-Reply-To: <44B7A007.2010204@garzik.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200607142052.05666.blaisorblade@yahoo.it>
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, jdike@karaya.com, Linux Kernel <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

On Friday 14 July 2006 15:45, Jeff Garzik wrote:
> Jeff Garzik wrote:
> > I tried to build 2.6.17 and 2.6.17.4 UML on x86-64 with the attached
> > .config on a Fedora Core 5 OS, and it broke:
>
> I just verified that ARCH=um on 32-bit x86 is also broken, with the same
> build errors, on 2.6.17, 2.6.17.4, and 2.6.18-rc1-gitX (latest).
>
> 	Jeff
Jeff (Garzik), the above error is specific to glibc 2.4. There is a workaround 
patch (which is wrong, but makes UML compile - and the affected code is not 
normally used except for debugging).

Jeff (Dike), please choose one of the "simple" patches I suggested (comment 
out offending code, for instance) since you (correctly) deferred the real fix 
(incorporating klibc's setjmp implementation) to later.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
