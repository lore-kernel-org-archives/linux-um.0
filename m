Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cvnmh-00036C-9k for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 31 Jan 2005 18:28:55 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Cvnmf-0008Ij-Ng for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 31 Jan 2005 18:28:55 -0800
Message-Id: <200502010441.j114fXUt006210@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Mon, 31 Jan 2005 18:21:09 EST."
	<Pine.LNX.4.61.0501311817060.5814@sparrow> 
References: <Pine.LNX.4.61.0501311817060.5814@sparrow> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: FC3/i386 root filesystem on ford (x64_64) with 2.6.4
	kernel: cannot setup LDT
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
Date: Mon, 31 Jan 2005 23:41:33 -0500
To: William Stearns <wstearns@pobox.com>
Cc: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Marion Bates <marion.bates@dartmouth.edu>

wstearns@pobox.com said:
> cannot set up thread-local storage: cannot set up LDT for thread-local
>  storage
>
> Kernel panic: Attempted to kill init! 

I don't know why you can't get a sash prompt, but this diagnosis looks easy.

The tls stuff isn't there, so the shell which tried to use it died.  Since you
did init=/bin/bash or something, the kernel paniced when it died.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
