Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C12nI-000894-VA for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 28 Aug 2004 05:58:56 -0700
Received: from [205.209.148.60] (helo=cpanel.bahsol.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1C12nI-0002BH-BT
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 28 Aug 2004 05:58:56 -0700
Received: from [82.194.49.3] (helo=[192.168.1.2])
	by cpanel.bahsol.com with asmtp (Exim 4.34) id 1C12nG-0005x2-BK
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 28 Aug 2004 15:58:56 +0300
Message-ID: <41308189.9060007@almahdi.cc>
From: Ali Almahdi <ali@almahdi.cc>
MIME-Version: 1.0
Subject: Re: [uml-devel] Unable to boot UML.
References: <412EDE49.4000308@almahdi.cc>
In-Reply-To: <412EDE49.4000308@almahdi.cc>
Content-Type: multipart/alternative;
	boundary="------------000302040303020801070602"
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
Date: Sat, 28 Aug 2004 15:58:49 +0300
To: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------000302040303020801070602
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The problem was is my /tmp mounted with noexec, this caused UML to 
sigfualt, I found a workaround for this, without remounting /tmp with 
exec, is that create /tmp2, and run linux kernel as below:

TMPDIR=/tmp2 ./linux *** Write your parameters here ***

Ali Almahdi wrote:

> I wasn't able to boot UML on my new server, I have tried most uml 
> patches and kernel versions with no success..
>
>
> # ./linux
> Checking for the skas3 patch in the host...found
> Checking for /proc/mm...found
> Linux version 2.6.8.1-1um (root@localhost) (gcc version 3.3.2 20031022 
> (Red Hat Linux 3.3.2-1)) #1 Fri Aug 27 10:02:17 AST 2004
> Built 1 zonelists
> Kernel command line: root=98:0
> PID hash table entries: 16 (order 4: 128 bytes)
> Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
> Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
> Memory: 27616k available
> Calibrating delay loop... 3971.48 BogoMIPS
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> Checking for host processor cmov support...Yes
> Checking for host processor xmm support...No
> Checking that ptrace can change system call numbers...OK
> Checking that host ptys support output SIGIO...Yes
> Checking that host ptys support SIGIO on close...No, enabling workaround
> Checking for /dev/anon on the host...Not available (open failed with 
> errno 2)
> NET: Registered protocol family 16
> SCSI subsystem initialized
> mconsole (version 2) initialized on /root/.uml/u0qnZB/mconsole
> UML Watchdog Timer
> VFS: Disk quotas dquot_6.5.1
> Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> Coda Kernel/Venus communications, v6.0.0, coda@cs.cmu.edu
> devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
> devfs: boot_options: 0x0
> Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> udf: registering filesystem
> Kernel panic: map_memory(0x42800000, 3, 0xce7000, 4096, 1, 1, 1) 
> failed, err = -1
>
> <6>SysRq : Show Regs
>
> EIP: 0073:[<4026c7a1>] CPU: 0 Not tainted ESP: 007b:4046cfa0 EFLAGS: 
> 00000216
>    Not tainted
> EAX: 00000000 EBX: 00007f09 ECX: 00000013 EDX: 00007f09
> ESI: 00000000 EDI: 00000000 EBP: 00000000 DS: 007b ES: 007b
> Call Trace: [<40165170>] [<4001a0aa>] [<4003cc66>] [<40030676>] 
> [<400306df>]
>   [<40014979>] [<4001eab4>] [<4001eafc>] [<40017823>] [<40019591>] 
> [<4026c827>]
>   [<40017883>] [<400198c4>] [<4026c7a1>] [<40019833>] [<4001ec10>] 
> [<4001ec29>]
>   [<400199b2>] [<4026c827>] [<4026c558>] [<40144800>] [<4026c827>] 
> [<4026c827>]
>   [<400179c8>] [<4026c827>] [<400179c8>] [<4026c827>] [<400179c8>] 
> [<400148cd>]
>   [<4005a97a>] [<4005aa31>] [<4005aa0f>] [<4005ab04>] [<4005aeee>] 
> [<4005af46>]
>   [<401447cd>] [<40049ffe>] [<40048ecc>] [<40007cc3>] [<40002604>] 
> [<4000f5a0>]
>   [<4000f5c7>] [<4000f5a0>] [<4001504d>] [<4000f5a0>] [<40015028>] 
> [<400178ca>]
>   [<4002d7d0>] [<4000f5a0>] [<4002d821>] [<4000f5a0>] [<4001e34a>] 
> [<4000f5a0>]
>   [<4026c558>] [<4026c7a1>]
> Segmentation fault (core dumped)
>
>
>
> My server is running on P4, 2GB RAM
>
> My UML config is attached.
>
> Thanks alot,
> Ali
>
>------------------------------------------------------------------------
>

--------------000302040303020801070602
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
The problem was is my /tmp mounted with noexec, this caused UML to
sigfualt, I found a workaround for this, without remounting /tmp with
exec, is that create /tmp2, and run linux kernel as below:<br>
<br>
TMPDIR=/tmp2 ./linux *** Write your parameters here ***<br>
<br>
Ali Almahdi wrote:
<blockquote cite="mid412EDE49.4000308@almahdi.cc" type="cite">I wasn't
able to boot UML on my new server, I have tried most uml patches and
kernel versions with no success..
  <br>
  <br>
  <br>
# ./linux
  <br>
Checking for the skas3 patch in the host...found
  <br>
Checking for /proc/mm...found
  <br>
Linux version 2.6.8.1-1um (root@localhost) (gcc version 3.3.2 20031022
(Red Hat Linux 3.3.2-1)) #1 Fri Aug 27 10:02:17 AST 2004
  <br>
Built 1 zonelists
  <br>
Kernel command line: root=98:0
  <br>
PID hash table entries: 16 (order 4: 128 bytes)
  <br>
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
  <br>
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
  <br>
Memory: 27616k available
  <br>
Calibrating delay loop... 3971.48 BogoMIPS
  <br>
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
  <br>
Checking for host processor cmov support...Yes
  <br>
Checking for host processor xmm support...No
  <br>
Checking that ptrace can change system call numbers...OK
  <br>
Checking that host ptys support output SIGIO...Yes
  <br>
Checking that host ptys support SIGIO on close...No, enabling
workaround
  <br>
Checking for /dev/anon on the host...Not available (open failed with
errno 2)
  <br>
NET: Registered protocol family 16
  <br>
SCSI subsystem initialized
  <br>
mconsole (version 2) initialized on /root/.uml/u0qnZB/mconsole
  <br>
UML Watchdog Timer
  <br>
VFS: Disk quotas dquot_6.5.1
  <br>
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
  <br>
Coda Kernel/Venus communications, v6.0.0, <a class="moz-txt-link-abbreviated" href="mailto:coda@cs.cmu.edu">coda@cs.cmu.edu</a>
  <br>
devfs: 2004-01-31 Richard Gooch (<a class="moz-txt-link-abbreviated" href="mailto:rgooch@atnf.csiro.au">rgooch@atnf.csiro.au</a>)
  <br>
devfs: boot_options: 0x0
  <br>
Installing knfsd (copyright (C) 1996 <a class="moz-txt-link-abbreviated" href="mailto:okir@monad.swb.de">okir@monad.swb.de</a>).
  <br>
udf: registering filesystem
  <br>
Kernel panic: map_memory(0x42800000, 3, 0xce7000, 4096, 1, 1, 1)
failed, err = -1
  <br>
  <br>
&lt;6&gt;SysRq : Show Regs
  <br>
  <br>
EIP: 0073:[&lt;4026c7a1&gt;] CPU: 0 Not tainted ESP: 007b:4046cfa0
EFLAGS: 00000216
  <br>
&nbsp;&nbsp; Not tainted
  <br>
EAX: 00000000 EBX: 00007f09 ECX: 00000013 EDX: 00007f09
  <br>
ESI: 00000000 EDI: 00000000 EBP: 00000000 DS: 007b ES: 007b
  <br>
Call Trace: [&lt;40165170&gt;] [&lt;4001a0aa&gt;] [&lt;4003cc66&gt;]
[&lt;40030676&gt;] [&lt;400306df&gt;]
  <br>
&nbsp; [&lt;40014979&gt;] [&lt;4001eab4&gt;] [&lt;4001eafc&gt;]
[&lt;40017823&gt;] [&lt;40019591&gt;] [&lt;4026c827&gt;]
  <br>
&nbsp; [&lt;40017883&gt;] [&lt;400198c4&gt;] [&lt;4026c7a1&gt;]
[&lt;40019833&gt;] [&lt;4001ec10&gt;] [&lt;4001ec29&gt;]
  <br>
&nbsp; [&lt;400199b2&gt;] [&lt;4026c827&gt;] [&lt;4026c558&gt;]
[&lt;40144800&gt;] [&lt;4026c827&gt;] [&lt;4026c827&gt;]
  <br>
&nbsp; [&lt;400179c8&gt;] [&lt;4026c827&gt;] [&lt;400179c8&gt;]
[&lt;4026c827&gt;] [&lt;400179c8&gt;] [&lt;400148cd&gt;]
  <br>
&nbsp; [&lt;4005a97a&gt;] [&lt;4005aa31&gt;] [&lt;4005aa0f&gt;]
[&lt;4005ab04&gt;] [&lt;4005aeee&gt;] [&lt;4005af46&gt;]
  <br>
&nbsp; [&lt;401447cd&gt;] [&lt;40049ffe&gt;] [&lt;40048ecc&gt;]
[&lt;40007cc3&gt;] [&lt;40002604&gt;] [&lt;4000f5a0&gt;]
  <br>
&nbsp; [&lt;4000f5c7&gt;] [&lt;4000f5a0&gt;] [&lt;4001504d&gt;]
[&lt;4000f5a0&gt;] [&lt;40015028&gt;] [&lt;400178ca&gt;]
  <br>
&nbsp; [&lt;4002d7d0&gt;] [&lt;4000f5a0&gt;] [&lt;4002d821&gt;]
[&lt;4000f5a0&gt;] [&lt;4001e34a&gt;] [&lt;4000f5a0&gt;]
  <br>
&nbsp; [&lt;4026c558&gt;] [&lt;4026c7a1&gt;]
  <br>
Segmentation fault (core dumped)
  <br>
  <br>
  <br>
  <br>
My server is running on P4, 2GB RAM
  <br>
  <br>
My UML config is attached.
  <br>
  <br>
Thanks alot,
  <br>
Ali
  <br>
  <pre wrap="">
<hr size="4" width="90%"></pre>
</blockquote>
</body>
</html>

--------------000302040303020801070602--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
