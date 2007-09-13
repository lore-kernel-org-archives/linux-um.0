Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IVbBs-0003dL-Ih for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Sep 2007 16:00:12 -0700
Received: from scorpius.cttc.es ([84.88.62.197])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IVbBp-0003OS-PT
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Sep 2007 16:00:12 -0700
Message-ID: <46E88B64.7090705@cttc.es>
Date: Thu, 13 Sep 2007 02:59:16 +0200
From: =?ISO-8859-1?Q?Ferm=EDn_Gal=E1n_M=E1rquez?= <fermin.galan@cttc.es>
MIME-Version: 1.0
References: <46DDAD83.4030004@cttc.es>
	<20070904214521.GB5417@c2.user-mode-linux.org>
	<46DE8F70.4070404@cttc.es>
	<20070910160238.GC14112@c2.user-mode-linux.org>
	<46E71F58.6050301@cttc.es> <46E85FA0.9040405@cttc.es>
	<20070912203002.GA9725@c2.user-mode-linux.org>
In-Reply-To: <20070912203002.GA9725@c2.user-mode-linux.org>
Subject: Re: [uml-devel] [uml-user] Hanging using 'iptables -L' in UML vm
	booted with con0=pts
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: UML-user <user-mode-linux-devel@lists.sourceforge.net>

Dear Jeff,

Jeff Dike wrote:
> On Wed, Sep 12, 2007 at 11:52:32PM +0200, Ferm=EDn Gal=E1n M=E1rquez wrot=
e:
>> This is the trace (as you can see I're repeated the experiment twice, =

>> the result is basically the same), hoping it could be useful to diagnose =

>> the problem and fix eventual bugs in the UML kernel. See below regarding =

>> the test procedure.
>>
>> (gdb) bt
>> #0  0xb7f9d7f2 in ?? () from /lib/ld-linux.so.2
>> #1  0xb7f19ab0 in tcsetattr () from /lib/i686/cmov/libc.so.6
>> #2  0x080610d5 in generic_console_write (fd=3D7,
>>     buf=3D0x828fc13 "ip_tables: (C) 2000-2006 Netfilter Core Team\n", n=
=3D45)
>>     at arch/um/drivers/chan_user.c:37
>> #3  0x0806096e in console_write_chan (chans=3D0x82756f0,
>>     buf=3D0x828fc13 "ip_tables: (C) 2000-2006 Netfilter Core Team\n", le=
n=3D45)
>>     at arch/um/drivers/chan_kern.c:352
> =

> Are you capturing UML output with a script or something?  This is the
> signature of the script not reading from the pty, so everything just
> backs up, waiting for the pty to clear up.

AFAIK, no script is capturing (I understand you refers to the output of =

the UML linux executable) and, as a matter of fact, I'm getting some =

output when execute ./linux. To be precise, this is the exact command =

(and the output) I get:

cibeles:/tmp# ./linux ubd0=3D/tmp/root_fs_debug con=3Dnull con0=3Dpts =

uml_dir=3D/tmp umid=3Drun
Core dump limits :
         soft - 0
         hard - NONE
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...OK
Checking advanced syscall emulation patch for ptrace...OK
Checking for tmpfs mount on /dev/shm...OK
Checking PROT_EXEC mmap in /dev/shm/...OK
Checking for the skas3 patch in the host:
   - /proc/mm...not found: No such file or directory
   - PTRACE_FAULTINFO...not found
   - PTRACE_LDT...not found
UML running in SKAS0 mode
[no more output, no new prompt]

Then, in a second terminal in the host, I get the pts device and open a =

screen in the vm:

cibeles:/tmp# uml_mconsole run/mconsole config con0
Warning: couldn't stat file: /root/.uml/run/mconsole/mconsole - No such =

file or directory
Warning: couldn't stat file: /tmp/uml/run/mconsole/mconsole - No such =

file or directory
OK pts:/dev/pts/1
cibeles:/tmp# screen /dev/pts/1
[the terminal "goes into" the vm. I use it to cause the fail, as seen below]
Debian GNU/Linux lenny/sid vm tty0

vm login: root
Password:
Last login: Wed Sep 12 23:32:36 2007 on tty0
Linux vm 2.6.22.4-xt-2m #1 Wed Sep 12 20:24:20 CEST 2007 i686

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
vm:~# iptables -L
[no output, linux process reach 100% CPU usage in the host]

In a third host terminal I run gdb:

cibeles:/tmp# cat run/pid
6627
cibeles:/tmp# gdb ./linux 6627

GNU gdb 6.4.90-debian
Copyright (C) 2006 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain =

conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i486-linux-gnu"...Using host libthread_db =

library "/lib/i686/cmov/libthread_db.so.1".

Attaching to program: /tmp/linux, process 6627
Reading symbols from /lib/i686/cmov/libutil.so.1...done.
Loaded symbols for /lib/i686/cmov/libutil.so.1
Reading symbols from /lib/i686/cmov/libc.so.6...done.
Loaded symbols for /lib/i686/cmov/libc.so.6
Reading symbols from /lib/ld-linux.so.2...done.
Loaded symbols for /lib/ld-linux.so.2
0xb7f947f2 in ?? () from /lib/ld-linux.so.2
(gdb) bt
[showing the trace I've already sent in the other mail]

Maybe there are "other outputs" apart of the output that the ./linux =

produces which could be causing the problem?

Best regards,

--------------------
Ferm=EDn Gal=E1n M=E1rquez
CTTC - Centre Tecnol=F2gic de Telecomunicacions de Catalunya
Parc Mediterrani de la Tecnologia, Av. del Canal Ol=EDmpic s/n, 08860
Castelldefels, Spain
Room 1.02
Tel : +34 93 645 29 12
Fax : +34 93 645 29 01
Email address: fermin dot galan at cttc dot es

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
