Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Au70x-0004FE-EX
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 20 Feb 2004 01:32:07 -0800
Received: from gate2.mailgate.de ([62.116.129.39] helo=web4.internetx.de)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1Au6vB-0005Lw-PM
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 20 Feb 2004 01:26:09 -0800
Received: from lain.internetx.de (pizza.internetx.de [62.116.129.3])
	(authenticated bits=0)
	by web4.internetx.de (8.12.9/8.12.9) with ESMTP id i1K9Q8Ax026159
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 20 Feb 2004 10:26:08 +0100
Received: from lain.internetx.de (localhost [127.0.0.1])
	by lain.internetx.de (8.12.3/8.12.3/Debian-6.6) with ESMTP id i1K9Q7V4008076
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=OK)
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 20 Feb 2004 10:26:07 +0100
Received: (from sebastianw@localhost)
	by lain.internetx.de (8.12.3/8.12.3/Debian-6.6) id i1K9Q7Ur008075
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 20 Feb 2004 10:26:07 +0100
From: Sebastian Wiesinger <sw@internetx.de>
Message-ID: <20040220092607.GA8007@lain.intern.internetx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] Problem: copy_thread : pipe failed, err = 24
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 20 Feb 2004 10:26:07 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Hello,

I'm using a host system with 9 UML boxes and keep getting the error

copy_thread : pipe failed, err = 24

This error appears first after a few hours of running and the boxes
with this error is no longer reachable. The following other errors
also appear:

flush_thread : new thread failed, errno = 1
copy_thread : clone failed - errno = 11
copy_thread : clone failed - errno = 1
copy_thread : clone failed - errno = 1


I used the 2.4.24 UML Patch with a new 2.4.25 Kernel wich applied
without errors.

Any suggestions?

Sebastian


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
