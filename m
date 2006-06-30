Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Fri, 30 Jun 2006 09:45:09 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060630134509.GA3510@ccure.user-mode-linux.org>
References: <006401c69c19$eb9edbd0$d4190a0a@centecnetworks.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <006401c69c19$eb9edbd0$d4190a0a@centecnetworks.com>
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
To: Miao Qingjun <qmiao@centecnetworks.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

On Fri, Jun 30, 2006 at 03:50:56PM +0800, Miao Qingjun wrote:
> WARNING: vmlinux - Section mismatch: reference to .init.text: from .plt after '' (at offset 0x8347e44)

These are harmless.

> Second one,
> 
> when run uml compiled with "-g" and without "-O2",
> uml crashed
> 
> VFS: Mounted root (ext2 filesystem).
> Stub registers -
>         0 - 0
>         1 - 0
>         2 - 0
>         3 - 0
>         4 - 0
>         5 - bffffd1c
>         6 - e
>         7 - 7b
>         8 - 7b
>         9 - 0
>         10 - 0
>         11 - ffffffff
>         12 - bfdb8f9a
>         13 - 73
>         14 - 10282
>         15 - bffffd04
>         16 - 7b
> Kernel panic - not syncing: get_skas_faultinfo : failed to wait for SIGUSR1/SIGTRAP, pid = 7760, n = 7760, errno = 0, status = 0xb7f

Can you send the disassembly of stub_segv_handler?

				Jeff

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
