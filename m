Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CpAIe-0000xG-KM for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 11:06:28 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CpAIZ-0007rN-6y for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 11:06:28 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501132008.41725.blaisorblade@yahoo.it>
Subject: [uml-devel] Breakage of compilation in .11-rc1 - "code-tidying" is
	broken
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
Date: Thu, 13 Jan 2005 20:08:41 +0100
To: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

I've verified the compilation problem posted about -rc1:

arch/um/kernel/process.c: In function `check_ptrace':
arch/um/kernel/process.c:321: error: `PTRACE_SETOPTIONS' undeclared (first use 
in this function)
arch/um/kernel/process.c:321: error: (Each undeclared identifier is reported 
only once
arch/um/kernel/process.c:321: error: for each function it appears in.)
arch/um/kernel/process.c:321: error: `PTRACE_O_TRACESYSGOOD' undeclared (first 
use in this function)

This is related to the TRACESYSGOOD patch and to an unverified patch, i.e. :

http://linux.bkbits.net:8080/linux-2.5/cset@41e49628dGbOWX-bT9yZII4f19GT6A

I.e, the "Code Tidying" patch still on the incrementals.

In fact, including both linux/ptrace.h and sys/ptrace.h is not redundant - it 
must also be done in the proper order, so I'm writing a patch with the 
appropriate content.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
