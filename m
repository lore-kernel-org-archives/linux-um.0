Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 22 Aug 2011 11:53:37 +0200
From: Ingo Molnar <mingo@kernel.org>
Message-ID: <20110822095336.GB25949@kernel.org>
References: <20110821144352.GJ2203@ZenIV.linux.org.uk>
 <20110821164124.GL2203@ZenIV.linux.org.uk>
 <CAObL_7E1vU8+0UQST6Smf9j40TckTzB=QdY0AuAWo4AX6cs2xg@mail.gmail.com>
 <20110822011645.GM2203@ZenIV.linux.org.uk>
 <CA+55aFz1jCZGcQ-c6uGN=k8nKDuGoz5g8e+pxpYAg4X_p7=5Mw@mail.gmail.com>
 <4E51B56F.3080301@zytor.com>
 <CAObL_7HLDD=FVSN58W7a0g0R--8x7OVrQVCBxWD1DirVZxRn2w@mail.gmail.com>
 <20110822020737.GP2203@ZenIV.linux.org.uk>
 <CAObL_7HY7qFUoqtNju42=BHTR8WuuW-cL_cQh_uUfx_7gFfHRg@mail.gmail.com>
 <4E51D597.3060800@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E51D597.3060800@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [uml-devel] SYSCALL, ptrace and syscall restart breakages (Re:
 [RFC] weird crap with vdso on uml/i386)
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Lutomirski <luto@mit.edu>, Borislav Petkov <bp@amd64.org>, user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, mingo@redhat.com, Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>


* H. Peter Anvin <hpa@zytor.com> wrote:

> Borislav,
> 
> We're tracking down an issue with the way system call arguments are 
> handled on 32 bits.  We have a solution for SYSENTER but not 
> SYSCALL; fixing SYSCALL "properly" appears to be very difficult at 
> best.
> 
> So the question is: how much overhead would it be to simply fall 
> back to int $0x80 or some other legacy-style domain crossing 
> instruction for 32-bit system calls on AMD64 processors?  We don't 
> ever use SYSCALL in legacy mode, so native i386 kernels are 
> unaffected.

Last i measured INT80 and SYSCALL costs they were pretty close to 
each other on AMD CPUs - closer than on Intel.

Also, most installations are either pure 32-bit or dominantly 64-bit, 
the significantly mixed-mode case is dwindling.

Unifying some more in this area would definitely simplify things ...

Thanks,

	Ingo
