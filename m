Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BiJ9G-000620-HJ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Jul 2004 13:36:10 -0700
Received: from mail.scgiservices.com ([198.107.3.67])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1BiJ9G-0008Tl-6A
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Jul 2004 13:36:10 -0700
Received: from SCG2 (dyn170.CONET.OUS.EDU [140.211.15.170])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail.scgiservices.com (Postfix) with ESMTP id 08DA52A3A5
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed,  7 Jul 2004 13:36:07 -0700 (PDT)
From: "Anthony Brock" <Anthony_Brock@ous.edu>
Subject: RE: [uml-devel] uml_mconsole issue
Message-ID: <IFEIKNDOLFNCKMGAENCFOEIDCHAA.Anthony_Brock@ous.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <200407071914.06387.blaisorblade_spam@yahoo.it>
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
Date: Wed, 7 Jul 2004 13:36:03 -0700
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Obviously, I'm doing something wrong. I tried following Blaisor's
instructions for a backtrace as posted on 2004-06-14 at:

http://marc.theaimsgroup.com/?l=3Duser-mode-linux-user&m=3D108726561303235&=
w=3D2

However, I'm seeing the following:


$ TMP=3D/dev/shm gdb linux-2.6.7-32bit-debug
GNU gdb 6.1
Copyright 2004 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain
conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i586-suse-linux"...Using host libthread_db
library "/lib/tls/libthread_db.so.1".

(gdb) set args umid=3Dbind2 <... junk deleted ...>
(gdb) handle SIGUSR1 pass nostop noprint
Signal        Stop      Print   Pass to program Description
SIGUSR1       No        No      Yes             User defined signal 1
(gdb) handle SIGSEGV pass nostop noprint
Signal        Stop      Print   Pass to program Description
SIGSEGV       No        No      Yes             Segmentation fault
(gdb) break panic
Breakpoint 1 at 0xa0030d18: file kernel/panic.c, line 58.
(gdb) run
Starting program: linux-2.6.7-32bit-debug umid=3Dbind2 mem=3D64M <... junk
deleted ...>
Detaching after fork from child process 9635.
Checking for the skas3 patch in the host...found
Checking for /proc/mm...found
Detaching after fork from child process 9636.
Detaching after fork from child process 9637.
Detaching after fork from child process 9638.
Detaching after fork from child process 9639.
Linux version 2.6.7-1um-debug (root@vs1) (gcc version 3.3.3 (SuSE Linux)) #3
Wed Jul 7 13:09:26 PDT 2004
On node 0 totalpages: 16384

<... startup junk deleted ...>


dns2 login: Kernel panic: Segfault with no mm


Program exited with code 01.
(gdb) bt
No stack.
(gdb) continue
The program is not being run.
(gdb) quit
$


How do I acquire the backtrace? I must be missing something obvious. Thanks
in advance!

Tony


> -----Original Message-----
> From: BlaisorBlade [mailto:blaisorblade_spam@yahoo.it]
> Sent: Wednesday, July 07, 2004 10:14 AM
> To: Anthony Brock; user-mode-linux-devel@lists.sourceforge.net
> Subject: Re: [uml-devel] uml_mconsole issue
>
>
> Alle 07:14, mercoled=EC 7 luglio 2004, Anthony Brock ha scritto:
> > Let me know if you require more detail and what specific steps I should
> > take to help trouble-shoot this. Thanks in advance!
> Could you try taking a "backtrace" from the UML? I've no time for now to
> explain it, but it has been explained tons of times on this ML...
> search for
> "backtrace" on the marc.theaimsgroup.com archives! See also the
> "debugging
> kernel" page (the subsection about skas).
> --
> Paolo Giarrusso, aka Blaisorblade
> Linux registered user n. 292729
>
>



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 -=20
digital self defense, top technical experts, no vendor pitches,=20
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
