Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FO0J0-0002Ut-ES for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 27 Mar 2006 14:35:22 -0800
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FO0Iy-0006us-Rv
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 27 Mar 2006 14:35:22 -0800
Content-Disposition: inline
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200603280035.21377.blaisorblade@yahoo.it>
Subject: [uml-devel] Fwd: SMP skas requirements
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
Date: Tue, 28 Mar 2006 00:35:21 +0200
To: user-mode-linux-devel@lists.sourceforge.net



----------  Forwarded Message  ----------

Subject: SMP skas requirements
Date: Monday 20 March 2006 22:06
From: Jeff Dike <jdike@addtoit.com>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@projects.sourceforge.net

There is some interest from a group inside Intel in helping with skas
SMP.  I wrote up the following, and I'd appreciate some review to see
if I missed anything.

				Jeff


Summary, details below:

Locking between threads of skas0 data page
Locking between threads of tlb flushing
Create one host thread per UML process when SMP is enabled,
	propagating CLONE_VM to host
Use userspace_pids array properly
Make an SMP cleaning pass over UML arch
Add locking to filehandle

Details:

The SMP work needed for UML is mostly to enable SMP in skas mode.  tt
mode has has SMP support for a while (and tt mode will be going away
once skas SMP works, since that's now the only thing tt mode has that
skas mode doesn't).

In skas mode, there are several host capabilities which are checked
for, and used if present.  If they are not present, then UML runs in
skas0 mode (the "0" being the number of host patches needed), if they
are present (the skas3 patch includes all of them), then UML runs in
skas3 mode ("3" being the current version of the skas patch).

skas0 brings some SMP concerns that skas3 doesn't.  In order to do
some things that are needed by skas without host patches, it maps two
kernel pages, called stub pages, into every process.  One, the data
stub page, is used as the signal stack for SIGSEGV - the signal
handler extracts the page fault information from the sigcontext
structure and passes that to the UML page fault handler.  The other
page, the code stub page, is UML kernel text, and is used to change
page mappings within the process.

With SMP, access to a process data stub has to be serialized, as we
can't have two threads handling a SIGSEGV at the same time.  This
would require a lock in get_skas_faultinfo() which allows only one
thread at a time into wait_stub_done for a given process.

Also, mapping changes are written into the data stub page by the UML
tlb flush code.  These changes are in the form of register sets, which
are loaded into registers by the code stub before it executes a system
call instruction.  This allows the UML kernel to have the process
execute any system call, even though only mmap, munmap, and mprotect
(and maybe modify_ldt) are actually used.  This page is writeable by
the process (as it must be possible to put signal frames on it).  This
would allow one thread of a process to try to change the host system
calls being executed by another thread by changing the register sets
as they are being processed.  If it can successfuly convert one into
an execve("/bin/bash"), then that is a breakout exploit.  To prevent
this, we should move the data to the code page instead of the data
page.  This also needs serialization between threads, allowing one
thread at a time into fix_range_common().

In skas0 mode (actually, if /proc/mm isn't present on the host), there
is one host process per UML address space, the pid of which is stored
in UML's mm_context.  This process runs whenever a thread within the
address space is scheduled.  When multiple threads can be running
simultaneously, this doesn't work.  We need one host process per UML
process, with CLONE_VM set on the host if it was set within UML.  The
pid inside the mm_context can stay, as that is used to manipulate the
address space.  The per-UML-process pids need to be stored in the
thread struct, and are used when running threads.

To control a running thread, there is a global userspace_pid array,
which is indexed by CPU number to get the host pid to use in ptrace.
BTW, since this array is indexed by CPU number, it doesn't need
locking, even though it's a global.  This is present as an array, but
it is presently defined as containing one element.  This needs fixing,
and the code that controls the processes (userspace()), needs to
figure out its CPU number and index the array appropriately.

We should make a pass over the UML arch in order to check all global
data for correct locking since that hasn't been done recently.

Of particular concern is the filehandle abstraction, which is used for
file descriptor management.  With hostfs and humfs, it is easy to hit
the file descriptor limit.  filehandles transparently deal with this
by detecting -EMFILE from the host, closing descriptors in order to
free up slots, and reopening closed files when they become active
again.  The problem is that there is currently nothing preventing a
descriptor from being reclaimed while it is being used.  A descriptor
is first checked to see if it's open (and reopened if not), and then
used.  The descriptor reclaiming code running on a different processor
could close the descriptor after it's checked for validity and before
it's used.  We need something to prevent this, like a
get_fh()/put_fh() around all such operations.

-------------------------------------------------------

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger with Voice: chiama da PC a telefono a tariffe esclusive 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
