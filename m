Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BDVNU-0008Lm-4J for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Apr 2004 14:23:32 -0700
Received: from smtp4.poczta.onet.pl ([213.180.130.28])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BDVNT-0006JZ-Jx for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Apr 2004 14:23:31 -0700
Received: from m by mpmain with local (Exim 3.36 #1 (Debian))
	id 1BDVN5-0004Hy-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 13 Apr 2004 23:23:07 +0200
From: Marcin Pawlik <wapkil@op.pl>
Message-ID: <20040413212307.GA14758@mpmain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Subject: [uml-devel] Reboot failing with file locked,
	CLONE_FILES and host kernel BUG()
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
Date: Tue, 13 Apr 2004 23:23:07 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Hello,

My UML fails to reboot saying:

#v+
F_SETLK failed, file already locked by pid 32589
Failed to lock 'fs', err = 11
#v-

or when .cow file is used:

#v+
F_SETLK failed, file already locked by pid 7530
Failed to lock 'root_fs.cow', err = 11
unable to open root_fs.cow for validation
Initializing stdio console driver
#v-

It happens when I execute "shutdown -r now" command on guest system or
"cad" in uml_mconsole. I'm using tt mode and the problem is present in
every version I checked - user-mode-linux 2.4.24-1um-2 from Debian,
manually compiled 2.4.24 and 2.6.4. This behavior doesn't also depend on
host kernel version - I tried 2.4.18, 2.4.24 and 2.6.5. The problem was
reported in Debian as a bug #220679 (and forwarded here by Matt
Zimmerman) but I think it wasn't solved. 

On 2.6.5 host kernel it also triggers host kernel BUG in
locks_remove_flock from fs/locks.c. fl->flags is FL_POSIX and the kernel
expects FL_FLOCK or FL_LEASE. On 2.4.* kernels the bug doesn't show
since BUG() line was added in 2.5.

I think UML starts its threads with CLONE_FILES and the main process is
restarted witch execvp which also preserves the lock. In skas mode the
problem is not present because the process that survives the reboot is
also the one holding the lock. In tt mode the lock is not placed by the
tracing thread so UML cannot place it again. 

I tried to close all the files (from ubd_dev array) in kill_io_thread
function and it helps but I have no idea what happens to the host kernel
when UML is not modified. Usually it removes the lock when the main
process dies but sometimes the lock is left. Killing all the other
processes doesn't also help here. I don't know how to reproduce this
without UML. Probably a special combination of clone flags and maybe
ptrace settings used by UML is needed.

Regards,

-- 
Marcin Pawlik


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
