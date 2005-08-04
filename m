Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E0kkA-0003KA-Ht	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Aug 2005 11:47:02 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1E0kk9-00023I-3e
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Aug 2005 11:47:02 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] 2.6.12-bs7 vs 2.6.12-bb8
References: <20050721220839.F01B389B90@sc8-sf-spam1.sourceforge.net>
	<1123090843.5177.38.camel@dhcp-192-168-22-217.internal>
	<1123181801.4400.3.camel@dhcp-192-168-22-217.internal>
In-Reply-To: <1123181801.4400.3.camel@dhcp-192-168-22-217.internal>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508042048.14548.blaisorblade@yahoo.it>
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
Date: Thu, 4 Aug 2005 20:48:14 +0200
To: antoine <antoine@nagafix.co.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

On Thursday 04 August 2005 20:56, antoine wrote:
> On Wed, 2005-08-03 at 18:40 +0100, antoine wrote:
> > > > I've just stared testing your latest patches on a amd64 box running
> > > > 2.6.13-rc3-git4, bb8 seems to run (so far)
> > >
> > > Using TT or SKAS0 mode? And is this specific to that host release wrt
> > > 2.6.12?
> > >
> > > > but bs7 comes up with:
> >
> > (...)
> > bs works fine on 2.6.13-rc4 now, must have been a host bug?
> > But all guest 64-bit kernels are still loosing memory fast, gentoo's
> > "emerge --sync" is enough to eat 300+ MB of ram! (in about 5 minutes)
>
> I can get a similar behavior from 2.6.12.3-bs9 guest (compiled with
> SUBARCH=i386) on a 2.6.13-rc5 host!
Ehr - can you bug Jeff for these? After trying on a 2.6.12.3 host - I wouldn't 
call -rc5 "stable", by just looking at the changelog *after* the release.

I'm going to be *offline* so unable to handle this stuff.
> The strange thing is that the same config file, same guest source but
> compiled without SUBARCH (ie: regular 64-bit guest) works ok (well still
> loosing memory fast - but at least it runs)
>
> strace ./vmlinux-2.6.12.3-bs9-x86 gives:
> (...)
Which test is it performing when it locks up? It is printing "ok" below, so...

> open("/home/antoine/.uml/pX0UwE/pid", O_RDWR|O_CREAT|O_EXCL|O_LARGEFILE,
> 0644) = 6
> getpid()                                = 18680
> write(6, "18680\n", 6)                  = 6
> close(6)                                = 0
> mprotect(0xa0256000, 8192, PROT_READ|PROT_WRITE|PROT_EXEC) = 0

//Here
> write(1, "OK\n", 3)                     = 3

> rt_sigaction(SIGPIPE, {0x1000000000000001, [], 0}, {SIG_DFL}, 8) = 0
> socketcall(0x8, 0xffffcb70)             = 0
> fcntl64(6, F_SETFD, FD_CLOEXEC)         = 0
> fcntl64(7, F_SETFD, FD_CLOEXEC)         = 0
> rt_sigaction(SIGWINCH, {0x10000000a0019a60, [], 0}, {SIG_DFL}, 8) = 0
> getpid()                                = 18680
> clone(child_stack=0xa0257fd4, flags=CLONE_FILES|SIGCHLD) = 18681
> waitpid(18681, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGSTOP}], WSTOPPED) =
> 18681
> --- SIGCHLD (Child exited) @ 0 (0) ---
> ptrace(0x15 /* PTRACE_??? */, 18681, 0, 0x1) = 0
> ptrace(PTRACE_CONT, 18681, 0, SIG_0)    = 0
> rt_sigaction(SIGSEGV, {0x10000000a0019be0, [], 0}, {SIG_DFL}, 8) = 0
> rt_sigaction(SIGUSR1, {0x10000000a00184f0, [], 0}, {SIG_DFL}, 8) = 0
Ok, the below is actually a 32-bit "-1" value (not verified), so it shouldn't 
be bogus.
> waitpid(4294967295, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGSEGV}],
> WSTOPPED) = 18681
> --- SIGCHLD (Child exited) @ 0 (0) ---
> ptrace(PTRACE_CONT, 18681, 0, SIGSEGV)  = 0
Same here
> waitpid(4294967295, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGUSR1}],
> WSTOPPED) = 18681
> --- SIGCHLD (Child exited) @ 0 (0) ---
The below *is* IMHO bogus (munmap from 0 is useless).
> munmap(0, 2692743168)                   = 0

> --- SIGSEGV (Segmentation fault) @ 0 (0) ---
> --- SIGSEGV (Segmentation fault) @ 0 (0) ---
> +++ killed by SIGSEGV +++

> Antoine

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
