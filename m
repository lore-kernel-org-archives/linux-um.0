Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AgGcK-0000vZ-Tw for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 12 Jan 2004 20:57:28 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1AgGcK-0003Zu-CQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 12 Jan 2004 20:57:28 -0800
Message-Id: <200401130518.i0D5ITS4026863@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Tue, 13 Jan 2004 00:05:33 EST."
	<200401130505.i0D55XS4026774@ccure.user-mode-linux.org> 
References: <200401130505.i0D55XS4026774@ccure.user-mode-linux.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: uml-patch-2.6.0
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
Date: Tue, 13 Jan 2004 00:18:29 -0500
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

> This patch updates UML to 2.6.0 and pulls in all the changes that have
>  accumulated in my 2.4 tree. 

I forgot to mention that newer libcs won't boot on 2.6 UMLs until I get
[gs]et_thread_area implemented.  Older libcs are fine, as are new libcs on
2.4 UMLs.

				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
