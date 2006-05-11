Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FeCS2-0004w4-Ay for User-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 May 2006 07:47:38 -0700
Received: from outgoing.securityfocus.com ([205.206.231.27])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FeCS2-0007eJ-2I
	for User-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 May 2006 07:47:38 -0700
Received: from mail.securityfocus.com (mail.securityfocus.com [205.206.231.9])
	by outgoing3.securityfocus.com (Postfix) with SMTP id 31478237D28
	for <User-mode-linux-devel@lists.sourceforge.net>;
	Thu, 11 May 2006 07:57:51 -0600 (MDT)
Message-ID: <20060511144508.25147.qmail@securityfocus.com>
Content-Type: text/plain
Content-Disposition: inline
MIME-Version: 1.0
From: "Ed White" <ed.white@libero.it>
Subject: [uml-devel] SecurityFocus Article
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
Date: 11 May 2006 14:45:08 -0000
Content-Transfer-Encoding: 8bit
To: ML <User-mode-linux-devel@lists.sourceforge.net>

A researcher of the french NSA discovered a scary vulnerability in modern x86 cpus and chipsets that expose the kernel to direct tampering.

The problem is that a feature called System Management Mode could be used to bypass the kernel and execute code at the highest level possible: ring zero.

The big problem is that the attack is possible thanks to the way X Windows is designed, and so the only way to eradicate it is to redesign it, moving video card driver into the kernel, but it seems that this cannot be done also for missing drivers and documentation!

I would like to know if UML barriers could by bypassed using this attack, or not. Maybe we will need a patch for the kernel, or for UML, or what?

Any hint is appreciated. 


------------------------------------------------------------------------

The quest for ring 0

by Federico Biancuzzi
2006-05-10

Federico Biancuzzi interviews French researcher Lo&iuml;c Duflot to learn about the System Management Mode attack, how to mitigate it, what hardware is vulnerable, and why we should be concerned with recent X Server bugs.
http://www.securityfocus.com/columnists/402



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
