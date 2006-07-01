Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FwTVM-0006km-D3 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Jun 2006 17:38:36 -0700
Received: from [218.104.33.231] (helo=centecnetworks.com)
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FwTVK-00057v-O6
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Jun 2006 17:38:36 -0700
Message-ID: <007401c69ca6$a6e00040$d4190a0a@centecnetworks.com>
From: "Miao Qingjun" <qmiao@centecnetworks.com>
References: <006401c69c19$eb9edbd0$d4190a0a@centecnetworks.com>
	<20060630134509.GA3510@ccure.user-mode-linux.org>
Date: Sat, 1 Jul 2006 08:38:20 +0800
MIME-Version: 1.0
Subject: Re: [uml-devel] [uml-user] UML 2.6.17 problems (section mismatch,
	get_skas_faultinfo : failed to wait for SIGUSR1/SIGTRAP)
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
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Hi, 
For first one problem, why .exit.text symbol's address seems overlapped with .text section
(I use GDB add-symbol-file to load lkm symbols, and section addresses are get from /sys/module/<lkm>/sections)

For the second problem,

082c90c8 <stub_segv_handler>:
 82c90c8:       55                      push   %ebp
 82c90c9:       89 e5                   mov    %esp,%ebp
 82c90cb:       83 ec 14                sub    $0x14,%esp
 82c90ce:       8d 45 0c                lea    0xc(%ebp),%eax
 82c90d1:       89 45 fc                mov    %eax,0xfffffffc(%ebp)
 82c90d4:       8b 45 fc                mov    0xfffffffc(%ebp),%eax
 82c90d7:       83 c0 54                add    $0x54,%eax
 82c90da:       8b 00                   mov    (%eax),%eax
 82c90dc:       a3 04 f0 ff bf          mov    %eax,0xbffff004
 82c90e1:       8b 45 fc                mov    0xfffffffc(%ebp),%eax
 82c90e4:       83 c0 34                add    $0x34,%eax
 82c90e7:       8b 00                   mov    (%eax),%eax
 82c90e9:       a3 00 f0 ff bf          mov    %eax,0xbffff000
 82c90ee:       8b 45 fc                mov    0xfffffffc(%ebp),%eax
 82c90f1:       83 c0 30                add    $0x30,%eax
 82c90f4:       8b 00                   mov    (%eax),%eax
 82c90f6:       a3 08 f0 ff bf          mov    %eax,0xbffff008
 82c90fb:       c7 04 24 14 00 00 00    movl   $0x14,(%esp)
 82c9102:       e8 93 ae db ff          call   8083f9a <stub_syscall0>
 82c9107:       89 45 f8                mov    %eax,0xfffffff8(%ebp)
 82c910a:       c7 44 24 08 0a 00 00    movl   $0xa,0x8(%esp)
 82c9111:       00 
 82c9112:       8b 45 f8                mov    0xfffffff8(%ebp),%eax
 82c9115:       89 44 24 04             mov    %eax,0x4(%esp)
 82c9119:       c7 04 24 25 00 00 00    movl   $0x25,(%esp)
 82c9120:       e8 57 ae db ff          call   8083f7c <stub_syscall2>
 82c9125:       8b 45 fc                mov    0xfffffffc(%ebp),%eax
 82c9128:       89 c4                   mov    %eax,%esp
 82c912a:       b8 77 00 00 00          mov    $0x77,%eax
 82c912f:       cd 80                   int    $0x80
 82c9131:       c9                      leave  
 82c9132:       c3                      ret    

Thanks!

----- Original Message ----- 
From: "Jeff Dike" <jdike@addtoit.com>
To: "Miao Qingjun" <qmiao@centecnetworks.com>
Cc: <user-mode-linux-user@lists.sourceforge.net>; <user-mode-linux-devel@lists.sourceforge.net>
Sent: Friday, June 30, 2006 9:45 PM
Subject: Re: [uml-user] UML 2.6.17 problems (section mismatch, get_skas_faultinfo : failed to wait for SIGUSR1/SIGTRAP)


> On Fri, Jun 30, 2006 at 03:50:56PM +0800, Miao Qingjun wrote:
>> WARNING: vmlinux - Section mismatch: reference to .init.text: from .plt after '' (at offset 0x8347e44)
> 
> These are harmless.
> 
>> Second one,
>> 
>> when run uml compiled with "-g" and without "-O2",
>> uml crashed
>> 
>> VFS: Mounted root (ext2 filesystem).
>> Stub registers -
>>         0 - 0
>>         1 - 0
>>         2 - 0
>>         3 - 0
>>         4 - 0
>>         5 - bffffd1c
>>         6 - e
>>         7 - 7b
>>         8 - 7b
>>         9 - 0
>>         10 - 0
>>         11 - ffffffff
>>         12 - bfdb8f9a
>>         13 - 73
>>         14 - 10282
>>         15 - bffffd04
>>         16 - 7b
>> Kernel panic - not syncing: get_skas_faultinfo : failed to wait for SIGUSR1/SIGTRAP, pid = 7760, n = 7760, errno = 0, status = 0xb7f
> 
> Can you send the disassembly of stub_segv_handler?
> 
> Jeff
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
