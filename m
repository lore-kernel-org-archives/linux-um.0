Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hpa@zytor.com>) id 1Qvb9c-0004t8-9Z
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Aug 2011 20:31:28 +0000
Received: from terminus.zytor.com ([198.137.202.10] helo=mail.zytor.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qvb9b-0004aY-HL
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Aug 2011 20:31:28 +0000
Message-ID: <4E52B7F8.3050002@zytor.com>
Date: Mon, 22 Aug 2011 13:11:36 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
References: <20110822011645.GM2203@ZenIV.linux.org.uk>
	<CA+55aFz1jCZGcQ-c6uGN=k8nKDuGoz5g8e+pxpYAg4X_p7=5Mw@mail.gmail.com>
	<4E51B56F.3080301@zytor.com>
	<CAObL_7HLDD=FVSN58W7a0g0R--8x7OVrQVCBxWD1DirVZxRn2w@mail.gmail.com>
	<20110822020737.GP2203@ZenIV.linux.org.uk>
	<CAObL_7HY7qFUoqtNju42=BHTR8WuuW-cL_cQh_uUfx_7gFfHRg@mail.gmail.com>
	<4E51D597.3060800@zytor.com> <20110822095336.GB25949@kernel.org>
	<CAObL_7F6D8nQovf+aJGiEOF1mBpBU8RwtjNA-5myxvEBRRHgsg@mail.gmail.com>
	<20110822144051.GD2946@aftab>
	<20110822151305.GV2203@ZenIV.linux.org.uk>
	<CA+55aFwoRO9xxnTyt_gYFdTS9LsaFoCWRuyNeXY7gvrE8CdZ0A@mail.gmail.com>
In-Reply-To: <CA+55aFwoRO9xxnTyt_gYFdTS9LsaFoCWRuyNeXY7gvrE8CdZ0A@mail.gmail.com>
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] SYSCALL,
 ptrace and syscall restart breakages (Re: [RFC] weird crap with
 vdso on uml/i386)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Lutomirski <luto@mit.edu>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, Richard Weinberger <richard@nod.at>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@amd64.org>, "mingo@redhat.com" <mingo@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, Ingo Molnar <mingo@kernel.org>

On 08/22/2011 01:05 PM, Linus Torvalds wrote:
> On Mon, Aug 22, 2011 at 8:13 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>>
>> In __kernel_vsyscall() the problem is possible to deal with; there we control
>> the code around that sucker.  It's SYSCALL in 32bit binary outside of
>> vdso32 that causes real PITA...
> 
> I just checked. 'syscall' (at least on x86-64) is definitely called
> outside of __kernel_vsyscall in all the normal cases. It's part of the
> fundamental ABI, after all. We don't use "int 0x80" there.
> 
> But on x86-32, I think we might be better off. There, we only have
> 'sysenter', and can perhaps use my suggested "just use int 0x80
> instead of the jump back to the sysenter instruction" trick. Plus
> people *will* be using __kernel_vsyscall, since on x86-32 you aren't
> guaranteed to have a CPU that supports sysenter to begin with.
> 
> Or am I missing something else?
> 

SYSCALL in 64-bit mode is not a problem.

SYSCALL in compatibility mode (32-on-64) *is* a problem, because ECX is
clobbered.  Unfortunately AMD processors only support SYSENTER in legacy
mode (32-on-32) -- unlike Intel and VIA.

Your trick solves SYSENTER, which takes care of legacy mode and Intel
and VIA processors in compatibility mode.

Borislav is checking into if we can just use INT 80h on AMD processors
in compatibility mode.  So far the indication seems to be that it is
probably okay.

	-hpa


------------------------------------------------------------------------------
uberSVN's rich system and user administration capabilities and model 
configuration take the hassle out of deploying and managing Subversion and 
the tools developers use with it. Learn more about uberSVN and get a free 
download at:  http://p.sf.net/sfu/wandisco-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

