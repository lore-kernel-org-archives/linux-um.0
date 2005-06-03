Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1De2Iu-0005Uz-MF	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 02 Jun 2005 19:53:00 -0700
Received: from mail.scgiservices.com ([198.107.3.67])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1De2Iq-0005XZ-SN
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 02 Jun 2005 19:53:00 -0700
From: "Anthony Brock" <Anthony.Brock@oregonstate.edu>
Subject: RE: [uml-devel] Problems applying patches to 2.6.12-rc5-mm1
Message-ID: <CBELIFGMBIEPIEOFCJFAEEHBCAAA.Anthony.Brock@oregonstate.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <CBELIFGMBIEPIEOFCJFAIEHACAAA.Anthony.Brock@oregonstate.edu>
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
Date: Thu, 2 Jun 2005 19:52:10 -0700
To: blaisorblade@yahoo.it, user-mode-linux-devel@lists.sourceforge.net
Cc: jdike@addtoit.com

I shutdown the process and, just to confirm, restarted it. I received the
following on the console:


Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...OK
Checking advanced syscall emulation patch for ptrace...check_sysemu :
expected SIGTRAP or (SIGTRAP|0x80), got status = 7295


After checking the process table, I confirmed that the kernel had fully
crashed. So I attempted to launch it again. Once more, I have extraneous
processes in the table:


# ps -eo user,pid,ppid,%cpu,%mem,vsz,rss,tty,stat,start,time,cmd |grep -v
grep |egrep 'PID|bindsec' |cut -b 1-131
USER       PID  PPID %CPU %MEM   VSZ  RSS TT       STAT  STARTED     TIME
CMD
bindsec  23901     1  0.0  0.0  2676 1356 ?        Ss   19:27:45 00:00:00
SCREEN -d -m -t bind2 -S bind2 /var/run/ramfs/linux-2.6.1
bindsec  23902 23901 22.3  2.0 67516 41956 pts/1   Ss+  19:27:45 00:00:52
/var/run/ramfs/linux-2.6.12-rc5-mm1-00-32bit umid=bind2 h
bindsec  23910 23902  0.1  2.0 67516 41956 pts/1   S+   19:27:45 00:00:00
/var/run/ramfs/linux-2.6.12-rc5-mm1-00-32bit umid=bind2 h
bindsec  23911 23902  0.0  2.0 67516 41956 pts/1   S+   19:27:46 00:00:00
/var/run/ramfs/linux-2.6.12-rc5-mm1-00-32bit umid=bind2 h
bindsec  23912 23902  0.0  0.0   252  104 pts/1    T+   19:27:46 00:00:00
bindsec  26805 23902  0.0  0.0   612  572 pts/1    T+   19:28:31 00:00:00 ?
bindsec  26810 23902  0.0  0.0   592  500 pts/1    T+   19:28:32 00:00:00 ?
?   ?   ?   O(   ??@?   [     ?@ ???
bindsec  26844 23902  0.0  0.0  1720  860 pts/1    T+   19:28:32 00:00:00
bindsec  26873 23902  0.1  0.1  3524 3152 pts/1    T+   19:28:33 00:00:00 `
bindsec  27930 23902  0.0  0.0  1388  168 pts/1    T+   19:28:49 00:00:00 ?
bindsec  27945 23902  0.0  0.0  1368 1368 pts/1    T+   19:28:50 00:00:00
bindsec  27962 23902  0.0  0.0  1404 1404 pts/1    T+   19:28:50 00:00:00
bindsec  27982 23902  0.0  0.0   700   64 pts/1    T+   19:28:50 00:00:00
bindsec  28734 23902  0.0  0.0   488  488 pts/1    T+   19:29:04 00:00:00
#


So, I decided to down-grade to the older 2.6.11.11-bs5 kernel. This is what
I see when trying to launch:


$ TMP=/dev/shm /var/run/ramfs/linux-2.6.11.11-00-32bit-bs5 umid=bind2
hwprobe=-sys mem=64M con=pts con0=fd:0,fd:1
ubd0s=/opt/images/instances/bindsec_root.img
ubd1s=/opt/images/instances/bindsec_swap.img
eth0=tuntap,bind2-0,fe:fd:aa:aa:aa:3d root=98:0
Checking for /proc/mm...not found
Support for TT mode is disabled, and no SKAS support is present on the host.
$


I am now truly baffled. I'm assuming that this means I have problems on the
host. How do I generate information that will help with trouble-shooting?
Thanks!

Tony


-----Original Message-----
From: user-mode-linux-devel-admin@lists.sourceforge.net
[mailto:user-mode-linux-devel-admin@lists.sourceforge.net]On Behalf Of
Anthony Brock
Sent: Thursday, June 02, 2005 7:19 PM
To: user-mode-linux-devel@lists.sourceforge.net; blaisorblade@yahoo.it
Cc: jdike@addtoit.com
Subject: RE: [uml-devel] Problems applying patches to 2.6.12-rc5-mm1


The instance still hasn't crashed. However, I'm now seeing the following in
the process table:

# ps -eo user,pid,ppid,%cpu,%mem,vsz,rss,tty,stat,start,time,cmd |grep -v
grep |egrep 'PID|bindsec' |cut -b 1-131
USER       PID  PPID %CPU %MEM   VSZ  RSS TT       STAT  STARTED     TIME
CMD
bindsec  12531     1  0.0  0.0  2676 1376 ?        Ss   13:20:04 00:00:00
SCREEN -d -m -t bind2 -S bind2 /var/run/ramfs/linux-2.6.1
bindsec  12532 12531  0.4  2.3 67516 49572 pts/1   Ss+  13:20:04 00:01:38
/var/run/ramfs/linux-2.6.12-rc5-mm1-00-32bit umid=bind2 h
bindsec  12546 12532  0.0  2.3 67516 49572 pts/1   S+   13:20:04 00:00:01
/var/run/ramfs/linux-2.6.12-rc5-mm1-00-32bit umid=bind2 h
bindsec  12547 12532  0.0  2.3 67516 49572 pts/1   S+   13:20:04 00:00:00
/var/run/ramfs/linux-2.6.12-rc5-mm1-00-32bit umid=bind2 h
bindsec  12548 12532  0.0  0.0   256  104 pts/1    T+   13:20:04 00:00:00
bindsec  15460 12532  0.0  0.0   612  572 pts/1    T+   13:20:48 00:00:00  0
?   A    ??@ ?  ?   ?   ?   u3
bindsec  15465 12532  0.0  0.0   600  508 pts/1    T+   13:20:48 00:00:00
?@ ?  ?   ?   ?   .>    ?@?   A    ??@ ?  ?   ?   ?    )
bindsec  15497 12532  0.0  0.0  1716  200 pts/1    T+   13:20:49 00:00:00  0
?   ?   ?   ?)   P @?   A    ? @ ?  ?   ?   ?   8)
bindsec  15528 12532  0.0  0.1  3816 3448 pts/1    T+   13:20:49 00:00:04  ?
?   ?   ?   R(   ?(@?   [     (@
bindsec  16592 12532  0.0  0.0  1380  164 pts/1    T+   13:21:06 00:00:00  ?
?   ?   ?   I(   ???    A    A?@ ?  ?   ?   ?   .6
bindsec  16636 12532  0.0  0.0  1416 1416 pts/1    T+   13:21:06 00:00:00
bindsec  16638 12532  0.0  0.0   704   64 pts/1    T+   13:21:06 00:00:00  ?
?   ?   ?   ?<   D?@?   A    a?@    ?   ?   ?   ?<
bindsec  17390 12532  0.0  0.0   488  488 pts/1    T+   13:21:19 00:00:00
bindsec  21243 12532  0.0  0.0  1368 1368 pts/1    T+   18:20:07 00:00:00
#

Why do several of these processes have a process state of 'T+' (traced or
stopped)? The instance seems to be responding normally. However, I'm VERY
concerned about the new, extraneous processes. Any ideas?

I'll try down-grading back to 2.6.11.11-bs5 to see if these still exist.

Tony


-----Original Message-----
From: user-mode-linux-devel-admin@lists.sourceforge.net
[mailto:user-mode-linux-devel-admin@lists.sourceforge.net]On Behalf Of
Anthony Brock
Sent: Wednesday, June 01, 2005 10:06 AM
To: user-mode-linux-devel@lists.sourceforge.net; blaisorblade@yahoo.it
Cc: jdike@addtoit.com
Subject: Re: [uml-devel] Problems applying patches to 2.6.12-rc5-mm1


Blaisor,

Thanks! I've removed this patch while leaving everything else applied. The
kernel now compiles. I'm running it and will report back once I have a
backtrace. *sigh*

Tony


>>> Blaisorblade <blaisorblade@yahoo.it> 05/31/05 04:32PM >>>
On Wednesday 01 June 2005 01:01, Anthony Brock wrote:
> As an additional FYI, I just refreshed my copy of the tarball. I now stops
> during compile:
>
> # make ARCH=um && make modules ARCH=um
>   CHK     include/linux/version.h
>   UPD     include/linux/version.h
>   SYMLINK include/asm -> include/asm-um
>
> < output trimmed >
>
>   SYMLINK arch/um/sys-i386/semaphore.c
>   CC      arch/um/sys-i386/semaphore.o
>   CC      arch/um/sys-i386/signal.o
>   CC      arch/um/sys-i386/sigcontext.o
>   AS      arch/um/sys-i386/stub.o
>   CC      arch/um/sys-i386/stub_segv.o
> fixdep: arch/um/sys-i386/.stub_segv.o.d: No such file or directory
> make[1]: *** [arch/um/sys-i386/stub_segv.o] Error 2
> make: *** [arch/um/sys-i386] Error 2
remove av-skas0 and retry, that's the more likely culprit at a very quick
glance.

--
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade





___________________________________
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=fad-ysdn-ostg-q22005
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
