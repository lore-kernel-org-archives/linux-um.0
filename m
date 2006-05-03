Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FbKDC-0000gH-85 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 May 2006 09:28:26 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FbKD9-0002fO-OK
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 May 2006 09:28:26 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
References: <20060503144223.GA4407@ccure.user-mode-linux.org>
In-Reply-To: <20060503144223.GA4407@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605031828.05073.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: arch/i386/Kconfig.cpu considered harmful
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
Date: Wed, 3 May 2006 18:28:04 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wednesday 03 May 2006 16:42, Jeff Dike wrote:
> Do we really need to pull that into the UML Kconfig?  We need some of
> the things it defines, like X86_CMPXCHG, but people keep discovering
> that menu and trying to set it to match the host, causing compilation
> problems when that pulls in headers that UML doesn't have.

Yes, I didn't fix these problems. I've been fairly lazy, I must admit this.

> I think I would like to dump Kconfig.cpu and define for ourselves the
> symbols that we need.

How do you let the user choose the CPU he wants to optimize for? That was the 
first purpose of what I did - optimizing for 386 isn't exactly the best thing 
to do (and we've done this, till the menu was introduced).

We can restrict the choices in the menu, for now, with a dependency on ! UML 
for the ones which don't work (i.e. the ones using 3DNow in string 
operations, IIRC). M686, Athlon and likely Pentium 4 work at least.
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
