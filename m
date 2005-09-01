Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EAyVL-000079-Cr	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Sep 2005 16:29:59 -0700
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EAyVI-0005uV-0X
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Sep 2005 16:29:59 -0700
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EAyTx-0007zJ-Sg	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Sep 2005 01:28:33 +0200
Received: from desk.marajade.sandelman.ca ([205.150.200.247])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 02 Sep 2005 01:28:33 +0200
Received: from mcr by desk.marajade.sandelman.ca with local (Gmexim 0.1
	(Debian))        id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 02 Sep 2005 01:28:33 +0200
From: Michael Richardson <mcr@sandelman.ottawa.on.ca>
Message-ID: <v0zmqwjrnu.fsf@marajade.sandelman.ottawa.on.ca>
References: <v04q96ndy4.fsf@marajade.sandelman.ottawa.on.ca>
	<200509011639.11607.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [uml-devel] Re: guest process core dump panics kernel
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
Date: Thu, 01 Sep 2005 19:26:45 -0400
To: user-mode-linux-devel@lists.sourceforge.net


>>>>> "Blaisorblade" == Blaisorblade  <blaisorblade@yahoo.it> writes:
    Blaisorblade> On Wednesday 31 August 2005 20:44, Michael Richardson
    Blaisorblade> wrote:
    >> This is with a host: Linux marajade.sandelman.ottawa.on.ca 2.6.12.3 #7
    >> Thu Aug 25 10:44:07 EDT 2005 i686 GNU/Linux (no skas patch, I think)
    >> 
    >> guest is:
    >> 
    >> east:/testing/pluto/basic-pluto-01# uname -a Linux east 2.6.12.3 #2
    >> Tue Aug 30 23:12:26 EDT 2005 i686 unknown
    >> 
    >> My process (pluto) now links with SWIG generated TCL wrappers, and it
    >> crashes due to a bug that I haven't found yet. It takes the UML down
    >> too:

    Blaisorblade> Search the archives, there's some sort of known UML bug in
    Blaisorblade> coredumping, described by either Bodo or Jeff (maybe TT
    Blaisorblade> mode specific, and I see from the trace you're using TT
    Blaisorblade> mode).

  Hmm. Good point. I was just lazy and I didn't apply the skas patch when I
moved to 2.6.12. 

  I just moved to a 2.6.13 guest, and ran into hostfs vs /dev lack of
/dev/console. My hack:

  cd UMLPOOL/east/root
  mv sbin/init sbin/init.real
  cat >>sbin/init <<EOF
#!/bin/sh

mount -t proc none /proc
sh /etc/init.d/udev start
rm -f /dev/console; mknod /dev/console c 5 1
rm -f /dev/null; mknod /dev/null c 1 3
ls -l /dev/console
exec /sbin/init.real </dev/console >/dev/console $*
EOF

  CATCH: kernel crashes if /dev/console doesn't exist at all, but is okay if 
there is a /dev/console file (created with "touch") on the hostfs.

Warning: unable to open an initial console.
Kernel panic - not syncing: Attempted to kill init!
 
EIP: 0073:[<40102eb7>] CPU: 0 Not tainted ESP: 007b:bf8caa2c EFLAGS: 00000246
    Not tainted
EAX: ffffffda EBX: 00000001 ECX: 00002000 EDX: 40184440
ESI: 40185e0c EDI: 40185e0c EBP: bf8caa48 DS: 007b ES: 007b
a03afa70:  [<a00358f4>] show_regs+0x214/0x220
a03afaa0:  [<a001c9fc>] panic_exit+0x2c/0x50
a03afab0:  [<a004c67d>] notifier_call_chain+0x2d/0x50
a03afad0:  [<a0039ee2>] panic+0x72/0x110
a03afaf0:  [<a003ceef>] do_exit+0x1bf/0x3b0
a03afb40:  [<a003d17d>] do_group_exit+0x4d/0xf0
a03afb80:  [<a003d235>] sys_exit_group+0x15/0x20
a03afb90:  [<a0023618>] execute_syscall_skas+0xf8/0x100
a03afc20:  [<a0023642>] handle_syscall+0x22/0x40
a03afc40:  [<a002219d>] handle_trap+0x3d/0x140
a03afc70:  [<a00227fc>] userspace+0x1dc/0x240
a03afce0:  [<a0023085>] new_thread_handler+0xe5/0x120
a03afd20:  [<a01b6408>] __restore+0x0/0x8




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
