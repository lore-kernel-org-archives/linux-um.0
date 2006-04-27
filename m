Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FZ5dl-0004Z3-Sr for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 Apr 2006 05:30:37 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FZ5dl-0006q3-UB for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 Apr 2006 05:30:37 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FZ5di-0007Ps-4v
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 Apr 2006 05:30:37 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
References: <20060426182144.71082.qmail@web31203.mail.mud.yahoo.com>
In-Reply-To: <20060426182144.71082.qmail@web31203.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604271430.18184.blaisorblade@yahoo.it>
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
Date: Thu, 27 Apr 2006 14:30:17 +0200
To: Abhay Raghu <abhay_raghu@yahoo.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wednesday 26 April 2006 20:21, Abhay Raghu wrote:
> Hello
>
>   I have been able to debug uml by directly launching it and debugging it
> with gdb. Could you explain how this works since both uml and gdb use
> ptrace?

In SKAS mode, UML "kernel" thread ptraces via PTRACE_SYSCALL (or the special 
PTRACE_SYSEMU, ask for the difference if interested) one "userspace" thread, 
where all application code is executed - the userspace thread runs normally 
until a syscall is executed - that syscall is intercepted and executed by 
UML. You see the "userspace" thread with status "T" in the "ps auxw" output.

In this picture, gdb ptraces the "kernel" thread - so it can possibly step 
over a ptrace call done on the other thread, but that is not a problem. All 
the kernel code is in the "kernel" thread so gdb'ing it simply works.

In TT mode (which however is currently becoming obsolete), instead, the 
picture is more complicate. There one thread, the tracing thread, ptraces 
various thread (one per guest process) which execute either the application 
code or the kernel code; when a syscall is done by a guest process, the 
tracing thread modifies the registers for the host thread representing that 
process so that it resumes executing UML code.

So, you could ptrace the tracing thread, but that's of little interest 
normally since it doesn't execute any kernel code. A special mechanism is 
needed, i.e. the ptrace proxy (which seems to be born for use outside UML and 
then incorporated): I don't know well the detail but IIRC gdb is ptraced and 
the results of his ptrace syscalls are modified, so that it sees what is 
happening in threads other than the tracing one.
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
