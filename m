Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C9phn-0003gS-6c for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Sep 2004 11:49:35 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1C9phm-0002rI-FF for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Sep 2004 11:49:35 -0700
From: Paolo Giarrusso <blaisorblade_personal@yahoo.it>
Subject: Re: [uml-devel] Managing 2.6 merge - url for the patches sent to merge
References: <200409181944.58072.blaisorblade_personal@yahoo.it>
	<200409202030.49422.blaisorblade_personal@yahoo.it>
	<200409210321.i8L3LgdR015667@ccure.user-mode-linux.org>
In-Reply-To: <200409210321.i8L3LgdR015667@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409212001.43965.blaisorblade_personal@yahoo.it>
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
Date: Tue, 21 Sep 2004 20:01:43 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Gerd Knorr <kraxel@bytesex.org>

On Tuesday 21 September 2004 05:21, Jeff Dike wrote:
> blaisorblade_personal@yahoo.it said:
> > Don't use uml-use-va_end.patch, it breaks UML on rebooting.
>
> How?  That patch looks completely safe to me.
I'm not understanding why either, but with the patch applied, I get 
"Segmentation fault" soon after reboot. You can read a complete output below.
Also notice the "deactivate_all_fds failed, errno = 9", which is frequent even 
without the patch.

However, note that you may need SKAS and SYSEMU to trigger that (maybe).

> Rebooting is broken (in tt mode anyway) because the file lock on the root
> ubd file descriptor isn't dropped. 
No, I'm not getting this problem.

> Mysteriously, setting that descriptor 
> CLOEXEC doesn't seem to help.
No, this problem seems to go away on 2.6 hosts (at least, that's my random 
experience). It seems, so, a 2.4 host bug.

See this patch from Henrik Normstrod for a workaround:

http://marasystems.com/download/uml/10-flock.patch

Checking for the skas3 patch in the host...found
Checking for /proc/mm...found
Linux version 2.6.9-rc2merging-pass1 (paolo@zion.localdomain) (gcc version 
3.3.2 (Mandrake Linux 10.0 3.3.2-6mdk)) #7 Sun Sep 19 20:33:32 CEST 2004
[...]
Memory: 29128k available
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Checking for host processor cmov support...Yes
Checking for host processor xmm support...No
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...found
Checking that host ptys support output SIGIO...Yes
Checking that host ptys support SIGIO on close...No, enabling workaround
Checking for /dev/anon on the host...Not available (open failed with errno 2)
NET: Registered protocol family 16
[...]
Initializing stdio console driver
VFS: Mounted root (ext2 filesystem) readonly.
INIT: version 2.84 booting
INIT: Entering runlevel: 5
INIT: Switching to runlevel: 6
INIT: Sending processes the TERM signal
reboot
Restarting system.

[This is always output at reboot, ALWAYS, if there is no segfault]
deactivate_all_fds failed, errno = 9

Checking for the skas3 patch in the host...found
Checking for /proc/mm...found
Linux version 2.6.9-rc2merging-pass1 (paolo@zion.localdomain) (gcc version 
3.3.2 (Mandrake Linux 10.0 3.3.2-6mdk)) #7 Sun Sep 19 20:33:32 CEST 2004
Built 1 zonelists
[bla bla bla]
VFS: Mounted root (ext2 filesystem) readonly.
INIT: version 2.84 booting
INIT: Entering runlevel: 5
INIT: Switching to runlevel: 6
INIT: Sending processes the TERM signal
reboot
Restarting system.

Segmentation fault

I've done a little debugging of that without success, but the problem is after 
coming back to main.

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
