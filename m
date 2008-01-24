Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JI8o5-0004Qu-QP for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 24 Jan 2008 12:36:21 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JI8o5-0007Jl-8n
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 24 Jan 2008 12:36:17 -0800
Received: from c2.user-mode-linux.org (littleton.addtoit.com [198.99.130.129])
	by saraswathi.solana.com (8.13.1/8.13.1) with ESMTP id m0OKaFuX011916
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 24 Jan 2008 15:36:15 -0500
Received: from c2.user-mode-linux.org (localhost.localdomain [127.0.0.1])
	by c2.user-mode-linux.org (8.14.1/8.13.8) with ESMTP id m0OKaF7S008554
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 24 Jan 2008 15:36:15 -0500
Date: Thu, 24 Jan 2008 15:36:15 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080124203615.GB8525@c2.user-mode-linux.org>
References: <20080123171225.GA7654@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080123171225.GA7654@c2.user-mode-linux.org>
Subject: Re: [uml-devel] [RFC PATCH 0/10] SKAS4
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: UML-user <user-mode-linux-devel@lists.sourceforge.net>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

... and here is arch/um/include/siginfo_segv.h...

				Jeff

-- 
Work email - jdike at linux dot intel dot com


/*
 * Copyright (C) 2002- 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
 * Licensed under the GPL
 */

#ifndef __SIGINFO_SIGSEGV_H_
#define __SIGINFO_SIGSEGV_H_

/*
 * Provide signal.h, except for replacing siginfo_t with one that has
 * the CPU trap number and error code in the SIGSEGV case.
 */

#include <time.h>

/* Rename the signal.h siginfo and siginfo_t out of the way */
#define siginfo old_siginfo
#define siginfo_t old_siginfo_t

#include <signal.h>

#undef siginfo
#undef siginfo_t

#define __ARCH_SI_TRAPNO
#define __ARCH_SI_ERROR

/* The new siginfo_t, plus associated definitions */

/*
 * This is the size (including padding) of the part of the
 * struct siginfo that is before the union.
 */
#ifndef __ARCH_SI_PREAMBLE_SIZE
#define __ARCH_SI_PREAMBLE_SIZE	(3 * sizeof(int))
#endif

#define SI_MAX_SIZE	128
#ifndef SI_PAD_SIZE
#define SI_PAD_SIZE	((SI_MAX_SIZE - __ARCH_SI_PREAMBLE_SIZE) / sizeof(int))
#endif

#ifndef __ARCH_SI_UID_T
#define __ARCH_SI_UID_T	uid_t
#endif

/*
 * The default "si_band" type is "long", as specified by POSIX.
 * However, some architectures want to override this to "int"
 * for historical compatibility reasons, so we allow that.
 */
#ifndef __ARCH_SI_BAND_T
#define __ARCH_SI_BAND_T long
#endif

#define __user

typedef struct siginfo {
	int si_signo;
	int si_errno;
	int si_code;

	union {
		int _pad[SI_PAD_SIZE];

		/* kill() */
		struct {
			pid_t _pid;		/* sender's pid */
			__ARCH_SI_UID_T _uid;	/* sender's uid */
		} _kill;

		/* POSIX.1b timers */
		struct {
			timer_t _tid;		/* timer id */
			int _overrun;		/* overrun count */
			char _pad[sizeof( __ARCH_SI_UID_T) - sizeof(int)];
			sigval_t _sigval;	/* same as below */
			int _sys_private;       /* not to be passed to user */
		} _timer;

		/* POSIX.1b signals */
		struct {
			pid_t _pid;		/* sender's pid */
			__ARCH_SI_UID_T _uid;	/* sender's uid */
			sigval_t _sigval;
		} _rt;

		/* SIGCHLD */
		struct {
			pid_t _pid;		/* which child */
			__ARCH_SI_UID_T _uid;	/* sender's uid */
			int _status;		/* exit code */
			clock_t _utime;
			clock_t _stime;
		} _sigchld;

		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
		struct {
			void __user *_addr; /* faulting insn/memory ref. */
#ifdef __ARCH_SI_TRAPNO
			int _trapno;	/* TRAP # which caused the signal */
#endif
#ifdef __ARCH_SI_ERROR
			int _error;	/* CPU error code */
#endif
		} _sigfault;

		/* SIGPOLL */
		struct {
			__ARCH_SI_BAND_T _band;	/* POLL_IN, POLL_OUT, POLL_MSG */
			int _fd;
		} _sigpoll;
	} _sifields;
} siginfo_t;

#ifdef __ARCH_SI_TRAPNO
#define si_trapno	_sifields._sigfault._trapno
#endif
#ifdef __ARCH_SI_ERROR
#define si_error	_sifields._sigfault._error
#endif

#undef si_addr
#define si_addr	_sifields._sigfault._addr

#define GET_FAULTINFO_FROM_SI(fi, si) \
	{ \
		(fi).cr2 = (unsigned long) (si).si_addr; \
		(fi).error_code = (si).si_error; \
		(fi).trap_no = (si).si_trapno; \
	}

#endif

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
