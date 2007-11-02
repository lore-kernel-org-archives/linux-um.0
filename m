Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1InmGI-0004IL-N6 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Nov 2007 19:27:54 -0700
Received: from swingline.cs.wisc.edu ([128.105.121.52])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1InmGH-0000nL-Bc
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Nov 2007 19:27:54 -0700
Received: from swingline.cs.wisc.edu (localhost [127.0.0.1])
	by swingline.cs.wisc.edu (8.13.6/8.13.6) with ESMTP id lA22RnDh008669
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 1 Nov 2007 21:27:49 -0500
Received: (from epaulson@localhost)
	by swingline.cs.wisc.edu (8.13.6/8.13.6/Submit) id lA22RnlS008668
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 1 Nov 2007 21:27:49 -0500
Date: Thu, 1 Nov 2007 21:27:49 -0500
From: Erik Paulson <epaulson@cs.wisc.edu>
Message-ID: <20071102022749.GB8583@swingline.cs.wisc.edu>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] building 2.6.24-rc1 with VDE in a non-standard location?
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

I'm trying to build UML with VDE support turned on. However, I don't
have root on my host machine, so when I installed VDE I put it in a 
non-standard location. 

How do you pass extra -L and -I flags to the kernel build process? I
tried adding

make linux ARCH=um CFLAGS=-I/path/to/my/vde/include 
with no go, and I tried adding the include path to
HOSTCFLAGS in the top level Makefile rules, but that also didn't
work.

I got it to build by just sticking the right -I and -L flags in 
arch/um/drivers/Makefile

Is there another, more standard Linux kernel way that's equivalent to
./configure --with-package=/path/

Thanks,

-Erik


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
