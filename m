Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B5c84-0006G3-Ui for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Mar 2004 18:59:00 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1B5c81-0005Vw-Mv for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Mar 2004 18:58:57 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Problems with Bind9 on UML 2.6.4
References: <000001c40f0b$9039a3d0$6401a8c0@vmwinxp>
In-Reply-To: <000001c40f0b$9039a3d0$6401a8c0@vmwinxp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403222013.52158.blaisorblade_spam@yahoo.it>
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
Date: Mon, 22 Mar 2004 20:13:52 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Alle 07:12, domenica 21 marzo 2004, Michael Ralston ha scritto:
> I'm running UML Version 2.6.4-1um with a 2.6.4 skas3 host.
>
> I'm using Debian Unstable and I've mved /lib/tls to /lib/notls to
> disable the NPTL problem...
>
> When running Bind, version 9.2.3 one of the Bind threads decides it want
> all the CPU time... When I strace the process it is performing the
> following system call indefinetly...

Have you checked if bind 9.2.3 is stable (no idea)? Could you give detail on 
its config (i.e. it is configured to use special things as shared memory or 
even futexes, which require NPTL)...

> kill(5960, SIGRTMIN)                    = 0
>
> Where '5960' is the PID of the process which is using all CPU time.

Do strace -f (IIRC) to follow the child processes it start and see what pid 
5960 is doing in the meanwhile. Also look Bind's logs and errors. But does it 
lock the Virtual Machine and prevent you from doing anything or it just runs 
continuately? I think it just keeps running.

> From what I've been able to figure out... SIGRTMIN is one of the
> real-time linux threading signals... Something implemented in libc6,
> version 2.3?

Yes, at all! SIGRTMIN is a way of saying something to the process - the 
meaning is decided by the programmer and not by the system (i.e. for the 
kernel SIGRTMIN has no special meaning, unlike SIGINT, SIGKILL and so on).

> Would I be better of compiling libc6 from source with NPTL/TLS disabled?
> Would it resolve this problem?
No idea, however check if bind is linked statically (and in this case it could 
be still trying to use NPTL, *maybe*).
> Or is it a matter of this syscall not
> being implemented in UML?

Well, kill() *is* implemented. By sure.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
