Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BsGxi-00079e-Kh for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 Aug 2004 01:17:26 -0700
Received: from sccrmhc13.comcast.net ([204.127.202.64])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BsGxg-000896-1f for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 Aug 2004 01:17:24 -0700
Message-ID: <41109B81.3030202@hevanet.com>
From: Matt Clay <mattclay@hevanet.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090302090905060503070408"
Subject: [uml-devel] tcsetattr returning -1, errno = EINTR
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
Date: Wed, 04 Aug 2004 01:17:05 -0700
To: UML Devel <user-mode-linux-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------090302090905060503070408
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

While booting UML in skas mode, I've noticed occasional glitches in the 
console output during the boot process.  At first I thought this was related 
to bug #260111, but now that Allen Chan has found the cause, I'm still 
having this problem after using the move_console_write patch.

Sometimes the console output shows up like this:

<snip>
NET4: Linux TCP/IP 1.0 for NET4.0
                                  IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
<snip>

I've tracked this back to calls to tcsetattr failing in 
generic_console_write.  It returns -1, and sets errno to 4 (EINTR).  I don't 
know if failed calls should be restarted or not, but I'm pretty sure 
ignoring the errors isn't a good idea.

Since the problem is intermittent, I created a GDB command file to automate 
my testing.  I've attached the command file, should you want to try this 
yourself.

Here's output from one of my sessions (yes, running it without a root image 
is the intent, the problem is visible before you get that far):

GNU gdb 6.1.1
Copyright 2004 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i486-slackware-linux"...Using host libthread_db 
library "/lib/libthread_db.so.1".

(gdb) source watch-tcsetattr.txt
0xa01130f0 <tcsetattr>: 0x83e58955
Breakpoint 1 at 0xa0113134: file string.h, line 486.
Breakpoint 2 at 0xa000b707: file panic.c, line 60.
Checking for the skas3 patch in the host...found
Checking for /proc/mm...found
Checking for /dev/anon on the host...Not available (open failed with errno 2)
Linux version 2.4.26-2um (matt@aida) (gcc version 3.3.4) #8 Wed Aug 4 
00:09:08 PDT 2004
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: con=xterm root=/dev/ubd0
Calibrating delay loop... 3322.67 BogoMIPS
Memory: 30152k available
Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that ptrace can change system call numbers...OK
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
pty: 256 Unix98 ptys configured
SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256).
loop: loaded (max 8 devices)
PPP generic driver version 2.4.2
Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
Initializing software serial port version 1
mconsole (version 2) initialized on /home/matt/.uml/kdiP2e/mconsole
unable to open root_fs for validation
ubd : Synchronous mode
Initializing stdio console driver
  *** tcsetattr failed, returned = -1, errno = 4 ***
  *** tcsetattr failed, returned = -1, errno = 4 ***
  *** tcsetattr failed, returned = -1, errno = 4 ***
  *** tcsetattr failed, returned = -1, errno = 4 ***
  *** tcsetattr failed, returned = -1, errno = 4 ***
  *** tcsetattr failed, returned = -1, errno = 4 ***
  *** tcsetattr failed, returned = -1, errno = 4 ***

Breakpoint 2, panic (fmt=0xa0162440 "VFS: Unable to mount root fs on %s") at 
panic.c:60
60              bust_spinlocks(1);
(gdb) c
Continuing.
  *** tcsetattr failed, returned = -1, errno = 4 ***
  *** tcsetattr failed, returned = -1, errno = 4 ***

Breakpoint 2, panic (fmt=0xa015e8ea "Segfault with no mm") at panic.c:60
60              bust_spinlocks(1);
(gdb) c
Continuing.


Program exited with code 01.
(gdb) q

--------------090302090905060503070408
Content-Type: text/plain;
 name="watch-tcsetattr.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="watch-tcsetattr.txt"

# These GDB commands should make watching tcsetattr failures much easier.  
# You can use them with UML in skas mode just by doing "gdb linux".  No 
# arguments are needed to demonstrate the problem.
#
# Pass signals through that UML uses.
handle SIGSEGV pass nostop noprint
handle SIGUSR1 pass nostop noprint
# Find out where tcsetattr is and try to guess where the breakpoint should 
# go.  We want the breakpoint just before tcsetattr returns.  You can always
# set it manually if this doesn't work.
x tcsetattr
set $tcsetattr_start = $_
set $tcsetattr_ret = $tcsetattr_start+17
# Set our breakpoint to run after a failed call to tcsetattr.  This should
# trigger just before tcsetattr returns with a non-zero return value.
break *$tcsetattr_ret
condition 1 $eax != 0
commands 1
silent
printf " *** tcsetattr failed, returned = %d, errno = %d *** \n", $eax, errno
c
end
# Break on panic so we don't lose our xterm when the kernel panics, which it
# should do as long as you run it without any arguments.
break panic
# Ok, time to run our test.  You don't have to use an xterm, but it will
# keep the error messages from printing out on your console.
r con=xterm

--------------090302090905060503070408--


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
