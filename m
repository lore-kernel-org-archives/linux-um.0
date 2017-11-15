Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 15 Nov 2017 12:04:16 +0100
From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: Re: [PATCH] um: use POSIX ucontext_t instead of struct ucontext
Message-ID: <20171115110416.GA29538@shrek.podlesie.net>
References: <20171115101239.4882-1-krzysiek@podlesie.net>
 <1518438.KRCSCszYuI@blindfold>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518438.KRCSCszYuI@blindfold>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: Jeff Dike <jdike@addtoit.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Wed, Nov 15, 2017 at 11:19:41AM +0100, Richard Weinberger wrote:
> Am Mittwoch, 15. November 2017, 11:12:39 CET schrieb Krzysztof Mazur:
> > glibc 2.26 removed the 'struct ucontext' to "improve" POSIX compliance
> > and break programs, including User Mode Linux. Fix User Mode Linux
> > by using POSIX ucontext_t.
> > 
> > This fixes:
> > 
> > arch/um/os-Linux/signal.c: In function 'hard_handler':
> > arch/um/os-Linux/signal.c:163:22: error: dereferencing pointer to incomplete
> > type 'struct ucontext' mcontext_t *mc = &uc->uc_mcontext;
> > arch/x86/um/stub_segv.c: In function 'stub_segv_handler':
> > arch/x86/um/stub_segv.c:16:13: error: dereferencing pointer to incomplete
> > type 'struct ucontext' &uc->uc_mcontext);
> 
> Do all older glibcs have ucontext_t?
> Otherwise this patch will break other stuff.

Yes, ucontext_t typedef was always available. They changed:

typedef struct ucontext { ... } ucontex_t;

to

typedef struct ucontext_t { ... } ucontex_t;

https://sourceware.org/glibc/wiki/Release/2.26#Removal_of_.27struct_ucontext.27

Thanks,
Krzysiek

