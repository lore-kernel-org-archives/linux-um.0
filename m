Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CvkrC-0006o4-As for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 31 Jan 2005 15:21:22 -0800
Received: from slartibartfast.pa.net ([66.59.111.182])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Cvkr8-0005VG-Nr for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 31 Jan 2005 15:21:22 -0800
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
Message-ID: <Pine.LNX.4.61.0501311817060.5814@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [uml-devel] FC3/i386 root filesystem on ford (x64_64) with 2.6.4
	kernel: cannot setup LDT
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
Date: Mon, 31 Jan 2005 18:21:09 -0500 (EST)
To: Jeff Dike <jdike@addtoit.com>, ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: Marion Bates <marion.bates@dartmouth.edu>, William Stearns <wstearns@pobox.com>

Good evening, Jeff, all,
 	When trying to set up a fc3 i386 root filesystem on an x86_64 uml 
host, we're getting the following error out of FC3 (which did not show up 
in slackware 10/i386):


kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
cannot set up thread-local storage: cannot set up LDT for thread-local 
storage

Kernel panic: Attempted to kill init!
  <6>SysRq : Show Regs
Kernel panic: show_regs
...

 	Is this related to the tls libraries (which I've not yet moved out 
of the way)?  I actually booted this with the "ro single init=/bin/sash" 
command line params to try to rename that directory, but couldn't even get 
to a sash prompt.
 	Cheers,
 	- Bill

---------------------------------------------------------------------------
         "The time for action is past!  Now is the time for senseless
bickering."
(Courtesy of Vivek Dasmohapatra <vivek@etla.org>)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
