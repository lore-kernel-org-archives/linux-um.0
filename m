Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AmgJb-0006uO-Ar for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Jan 2004 13:36:39 -0800
Received: from knight.innercite.com ([158.222.3.8])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1AmgFm-0007yk-NW
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Jan 2004 13:32:42 -0800
Subject: Re: [uml-devel] Kernel idles in loop after loading IPv4
From: Phil Nadeau <phil@innercite.com>
In-Reply-To: <200401280439.i0S4dUZw005532@ccure.user-mode-linux.org>
References: <1075236841.15950.10.camel@rocket.innercite.com>
	<Pine.LNX.4.58.0401272326020.25787@ucontrol.mobiledns.com>
	<200401280439.i0S4dUZw005532@ccure.user-mode-linux.org>
Content-Type: multipart/mixed; boundary="=-H3dn5h5N9LIzJPuYrN2+"
Message-Id: <1075497812.22009.41.camel@rocket.innercite.com>
Mime-Version: 1.0
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
Date: Fri, 30 Jan 2004 13:23:36 -0800
To: UML Dev List <user-mode-linux-devel@lists.sourceforge.net>
Cc: Jeff Dike <jdike@addtoit.com>



--=-H3dn5h5N9LIzJPuYrN2+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2004-01-27 at 20:39, Jeff Dike wrote:
> If you could get a stack trace from the last call to schedule, that would be
> handy.  You could automate it with
> 	comm <n>
> 	bt
> 	c
> 	end
> 
> with breakpoint <n> attached to schedule().
> 
> 				Jeff

Here's the last part of a debug session that I ran which produced the
error. The full transcript is attached. Thanks in advance.

NET: Registered protocol family 2
  
Breakpoint 1, schedule () at kernel/sched.c:1489
1489            if (likely(!(current->state & (TASK_DEAD | TASK_ZOMBIE)))) {
#0  schedule () at kernel/sched.c:1489
#1  0xa002db4e in wait_for_completion (x=0xa1fefb64) at kernel/sched.c:1758
#2  0xa0041104 in synchronize_kernel () at kernel/rcupdate.c:262
#3  0xa000b5dc in inet_init () at net/ipv4/af_inet.c:1144
#4  0xa00024e8 in do_initcalls () at init/main.c:499
#5  0xa000c679 in init (unused=0x0) at init/main.c:581
#6  0xa00141d3 in run_kernel_thread (fn=0xa000c658 <init>, arg=0x0,
jmp_ptr=0xa08bfab4) at arch/um/kernel/process.c:241
#7  0xa001fe23 in new_thread_handler (sig=10) at
arch/um/kernel/skas/process_kern.c:71
#8  <signal handler called>
#9  0xa0155fed in syscall () at seq_file.h:49
Previous frame inner to this frame (corrupt stack?)
(gdb) c
Continuing.

-- 
Phil Nadeau
Software Services Manager
phil.nadeau@innercite.com
(916)932-3200, (800)921-5513

--=-H3dn5h5N9LIzJPuYrN2+
Content-Disposition: attachment; filename=debug_session.gz
Content-Type: application/x-gzip; name=debug_session.gz
Content-Transfer-Encoding: base64

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

--=-H3dn5h5N9LIzJPuYrN2+--



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
