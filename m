Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Richard Potter <sbuml-deletethispart@zar.att.ne.jp>
Message-Id: <20040923230808.5837.SBUML-DELETETHISPART@zar.att.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] SBUML update
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
Date: Fri, 24 Sep 2004 00:34:17 +0900
To: sbuml-devel@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net


It has been a while since I have posted any news about SBUML
(http://sbuml.sf.net) to the UML lists.  There have been steady
improvements over the past half year.  Following Jeff's suggestions, it
is now possible to try out SBUML with a relatively small download (3MB),
and it is running a relatively recent version of the kernel (2.4.23-2um).
The source code patch is available for download.

SBUML is implemented in two parts: the kernel patch and the command
scripts.  The patch to the UML kernel handles suspending and resuming
the host UML processes.  The command scripts handle creating, saving,
restoring, assigning IP addresses, compressing, downloading, and
migrating virtual machine states.  Recent work has been on the command
scripts.  They remain a work in progress, but hopefully they are now
complete enough to make it easy for people to experiment with UML's
hibernate/resume and machine migration potential.

Now I want to focus again on the kernel patch.  Currently I only know
of only a few problems:

  - It is still not complete.  Some devices (e.g. serial ports) have not
    been implemented.  Skas mode is not supported yet.

  - Booting on Knoppix sometimes segfaults.  I do not know if this is
    a Knoppix, UML, or SBUML problem yet.  Snapshot restore always
    seems to work, however.

  - Snapshots with the Basilisk Macintosh emulator running inside do
    not restore.

  - It still has the "tracing myself" bug that affects UML on 2.6
    hosts.  Applying Jeff's patch to change kill to tkill fixes this,
    however snapshots saved on 2.4 hosts do not restore on 2.6 hosts.

I am interested in fixing this last problem first so that the Web Page
Snapshot (http://www.usenix.org/events/vm04/wips/potter.pdf) feature
will be more useful.  If the same snapshot restores on both 2.4 and
2.6, then publishers of snapshots can create just one snapshot and
know that anybody with a recent Linux host can likely restore it.
Since SBUML now seems to be working pretty well as it is, I plan to
take a leisurely approach to fixing this and clean up related code
along the way.  Also, I plan to investigate how to make use of recent
UML code changes that could make the SBUML code patch cleaner, such
UML's new mechanism for closing and reopening file descriptors.

--Richard

For developers, information about compiling is at:
http://sbuml.sourceforge.net/compiling.html
and information about the interface between the kernel and scripts
is at:  http://sbuml.sourceforge.net/kernel-scripts-interface.html





-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
