Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FbHsj-0007BT-GA for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 May 2006 06:59:09 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FbHsj-0001N6-I3 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 May 2006 06:59:09 -0700
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FbHsg-0005Ia-IW
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 May 2006 06:59:09 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
References: <20060501155706.28604.qmail@web31206.mail.mud.yahoo.com>
In-Reply-To: <20060501155706.28604.qmail@web31206.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605031555.36529.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: gdb and uml
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
Date: Wed, 3 May 2006 15:55:35 +0200
To: Abhay Raghu <abhay_raghu@yahoo.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Monday 01 May 2006 17:57, Abhay Raghu wrote:
> i) Can you please explain the difference between PTRACE_SYSCALL and
> PTRACE_SYSEMU?

Download latest man-pages (at least 2.27) and read man 2 ptrace; if something 
is not clear, I'll answer to your further doubts.

>   ii) This question is related to uml: How do all applications run within a
> single userspace thread?

Doing context switching is fairly easy: with ptrace you change all registers 
and so on. I guess you know that, if I'm wrong feel free to ask.

There is a further problem however: different apps have different address 
spaces, with different mappings (or different memory images, they're running 
different executables with different libraries... there are various way to 
say this).

To solve this problem, we introduce on the host the SKAS3 patch whihch allows 
one process to have multiple address spaces - only one is in use, but via 
ptrace(PTRACE_SWITCH_MM) we can replace that one with another one - this is 
done by making a pointer in the process descriptor (i.e. current in Linux 
kernel code) point to another "mapping set" (called struct mm_struct), so 
it's very fast; you must also invalidate the TLB (i.e. the processor caches 
of page table entries) like on any "memory context switching", obviously.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
