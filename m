Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CSl3T-0004iL-1s for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Nov 2004 15:42:11 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CSl3S-00029D-4E for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Nov 2004 15:42:10 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Patchset to implement PTRACE_SYSEMU_SINGLESTEP
References: <419517A4.7020700@fujitsu-siemens.com>
In-Reply-To: <419517A4.7020700@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411130043.25888.blaisorblade_spam@yahoo.it>
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
Date: Sat, 13 Nov 2004 00:43:25 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, Jeff Dike <jdike@addtoit.com>

On Friday 12 November 2004 21:05, Bodo Stroesser wrote:
> Attached are several patches. Four of them (patch-2.6.*-skas-v7-*)
> implement PTRACE_SYSEMU_SINGLESTEP in the host. They are based on
> linux-2.6.7-vanilla + host-skas3-2.6.7-v7.patch (resp. the 2.6.9 versions).
> The "-reorganize" patches are a rework of the current patch without
> changing the functionality. The "add-SYSEMU_SINGLESTEP" then implement the
> new features. Please note: the differences between 2.6.7 and 2.6.9 are
> dependent on the different handling of syscall singlestepping in the two
> versions.
>
> To have UML using the new feature, there are two further patches named
> patch-SYSEMU_SINGLESTEP-*. They are based on linux-2.6.9-vanilla +
> all bb2-patches + patch-sysemu-tt + patch-fix-uml-hang-on-2.6.9-host.
> To have all the patches complete, the latter two are attached also.
>
> I tested on host 2.6.7 and host 2.6.9 with SKAS and TT mode. Currently I
> don't know any problem with it.

> Bodo

> BTW: Today I tried the first time since weeks to do a reboot in SKAS. It
> simply exits UML, as it did weeks ago. Is there anybody involved with that
> problem?

It seems a bit randomical: on my system, it segfaults some times, after 
checking for /proc/mm and SKAS mode.

When applying my use-va_end patch, (it's also in Jeff incrementals), instead, 
it always gets this segfault.

If you look at the comment about exec(), it says that UML risks to get some 
signals after the exec(). It workarounds this for some signals, but this 
cannot be done anyway for SIGSEGV... actually SIGSEGV delivery happens to 
always be synchronous, since the process gets trapped before the signal is 
queued.

By comparison, all signals are normally asynchronous, i.e. they get queued and 
later delivered, so that deliverying a signal is slower than doing a context 
switch.

Quoting from signal(7) man page:

Multiple instances of real-time signals can be queued.  By contrast,  if  
multiple instances of  a standard  signal  are  delivered  while  that signal 
is currently blocked, then only one instance is queued.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
