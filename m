Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HETuu-0005jX-ET for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Feb 2007 09:15:40 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HETuG-0001fu-3w
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Feb 2007 09:15:36 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Tue, 6 Feb 2007 18:14:18 +0100
References: <000001c74755$4f135dd0$ed3a1970$@ca>
In-Reply-To: <000001c74755$4f135dd0$ed3a1970$@ca>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200702061814.19123.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] adding a system call in uml
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Mohammad Jawwad <mjawwad@shaw.ca>

On Saturday 03 February 2007 06:36, Mohammad Jawwad wrote:
> Hello,
>
>
>
> How does one add a system call to user mode linux?
>
> I followed the instructions here:=
>
> http://user-mode-linux.sourceforge.net/lksct/

It's from 2002, (I've seen this in the homepage), it's outdated. No 
information about kernel development lasts for so long.

Those instructions could be meaningful for 2.4, and _maybe_ early 2.6 UML 
kernels (I didn't look at the details).
Which UML version did you use?

These days, to add a syscall to a 32bit UML you must patch x86 sources, and 
for a 64bit UML, the x86-64 sources. There will be more info on doing that in 
various websites.So look for info on doing that.

Files to modify are, at least:
For x86:
include/asm-i386/unistd.h
arch/i386/kernel/syscall_table.S

For x86_64:
include/asm-x86_64/unistd.h

Those files are included/reused by UML - this was done to make it easier to 
keep syscall tables in sync.

Also, syscall 253 is already assigned these days.

> The program compiles but dosent print out the the output from the printk()
> statement.
>
> Has anybody successfully installed a system call in uml?

-- 
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
