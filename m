Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AYKDe-0001qU-LC
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 21 Dec 2003 23:11:10 -0800
Received: from andromeda.oftc.net ([80.190.233.18])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:RC4-SHA:128)
	(Exim 4.24)
	id 1AYKDe-0004Fd-7o
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 21 Dec 2003 23:11:10 -0800
Received: from [24.102.64.193] (helo=willow.eelf.ddts.net)
	by andromeda.oftc.net with asmtp (TLS-1.0:RSA_ARCFOUR_SHA:16)
	(Exim 4.24)
	id 1AYKDY-0005qo-0m
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 22 Dec 2003 07:11:05 +0000
From: David B Harris <dbharris@eelf.ddts.net>
Subject: Re: [uml-devel] skas patch 2.6.0 -A4 mistake
Message-Id: <20031222021055.28b90296.dbharris@eelf.ddts.net>
In-Reply-To: <20031220235615.GA1710@elte.hu>
References: <354202003164938-nicospam@sengena.com>
	<20031220235615.GA1710@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 22 Dec 2003 02:10:55 -0500
To: user-mode-linux-devel@lists.sourceforge.net

On Sun, 21 Dec 2003 00:56:15 +0100
Ingo Molnar <mingo@elte.hu> wrote:
> > you have changed the ret=0 to ret=count in the PTRACE_SWITCH_MM case
> > from file kernel/ptrace.c instead of MM_COPY_SEGMENTS case from
> > mm/proc_mm.c
> 
> doh - you are right, -A5 uploaded.
> 
> /me should quit fixing bugs by hand-editing patches ...

Hey there :) I'm going through 2.6.0, testing that the functionality I
use is available and working (in preparation for an eventual rollout to
my machines), and I'm getting some odd behaviour with stock 2.6.0 from
kernel.org and your -combo-A5 patch applied. Debian Sid host, Debian
Woody guest:

$ linux umid=umltest ubd0=disks/umltest root=/dev/ubd0 mem=128M con0=fd:0,fd:1 con=pts eth0=tuntap,tap0 eth1=daemon init=/bin/sh
Checking for the skas3 patch in the host...found
Checking for /proc/mm...found
<snip>
VFS: Mounted root (ext3 filesystem) readonly.
init-2.05a# /etc/rcS.d/S10checkroot.sh
Activating swap.
Checking root file system...
fsck 1.27 (8-Mar-2002)
fsck.ext3: error while loading shared libraries: /lib/libcom_err.so.2: cannot read file data: Error 38
<snip>
init-2.05a# ls -l /lib/libcom_err.so.2 /lib/libcom_err.so.2.0 
lrwxrwxrwx    1 root     root           17 Dec 22 01:56 /lib/libcom_err.so.2 -> libcom_err.so.2.0
-rw-r--r--    1 root     root         5016 Mar 21  2002 /lib/libcom_err.so.2.0

On another boot, I got things like:

[ root@(none): ~/ ]# fsck.ext3 /dev/ubd0
e2fsck 1.27 (8-Mar-2002)
/dev/ubd0 contains a file system with errors, check forced.
Pass 1: Checking inodes, blocks, and sizes
Ignore error<y>? yes

Ignore error<y>? yes

Error reading block 9299 (Function not implemented) while reading indirect blocks of inode 4073.  Ignore error<y>? yes

Any thoughts, or any more information I can provide?


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
