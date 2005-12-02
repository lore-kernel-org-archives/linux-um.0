Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ei1Hf-0004Jm-0t for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Dec 2005 19:08:27 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Ei1Hd-0003pu-Km
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Dec 2005 19:08:27 -0800
From: Antoine Martin <antoine@nagafix.co.uk>
In-Reply-To: <1133489716.14775.27.camel@localhost.localdomain>
References: <20051202001358.GA12204@ccure.user-mode-linux.org>
	<1133489716.14775.27.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1133492877.14775.37.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: Stop the insanity
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
Date: Fri, 02 Dec 2005 03:07:57 +0000
To: Jeff Dike <jdike@addtoit.com>
Cc: William Stearns <wstearns@pobox.com>, Blaisorblade <blaisorblade@yahoo.it>, Kai Tan <mineown@hotmail.com>, Rob Landley <rob@landley.net>, David Lang <dlang@invendra.net>, Joel Palmius <joel.palmius@miun.se>, Mihai Rusu <dizzy@roedu.net>, Michael Richardson <mcr@sandelman.ottawa.on.ca>, Jason Lunz <lunz@falooley.org>, Benjamin LaHaise <bcrl@kvack.org>, user-mode-linux-devel@lists.sourceforge.net

> arch/um/kernel/skas/clone.c: In function `stub_clone_handler':
> arch/um/include/sysdep/stub.h:45: error: can't find a register in class
> `BREG' while reloading `asm'
> arch/um/include/sysdep/stub.h:66: error: can't find a register in class
> `BREG' while reloading `asm'
> arch/um/include/sysdep/stub.h:55: error: can't find a register in class
> `BREG' while reloading `asm'
> arch/um/include/sysdep/stub.h:90: error: can't find a register in class
> `BREG' while reloading `asm'
> make[2]: *** [arch/um/kernel/skas/clone.o] Error 1
> make[1]: *** [arch/um/kernel/skas] Error 2
> make: *** [arch/um/kernel] Error 2
After switching to gcc-vanilla it compiles fine... (both with 3.3.6 and
3.4.4)
Later I will try all the gcc profiles to try to identify which hardened
patches cause the problem.

Antoine



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
