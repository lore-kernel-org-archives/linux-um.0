Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1QveT9-0007Am-0m
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Aug 2011 00:03:51 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QveT7-0004EW-Sj
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Aug 2011 00:03:50 +0000
Date: Tue, 23 Aug 2011 01:03:14 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
Message-ID: <20110823000314.GW2203@ZenIV.linux.org.uk>
References: <4E51D597.3060800@zytor.com> <20110822095336.GB25949@kernel.org>
	<CAObL_7F6D8nQovf+aJGiEOF1mBpBU8RwtjNA-5myxvEBRRHgsg@mail.gmail.com>
	<20110822144051.GD2946@aftab>
	<20110822151305.GV2203@ZenIV.linux.org.uk>
	<CA+55aFwoRO9xxnTyt_gYFdTS9LsaFoCWRuyNeXY7gvrE8CdZ0A@mail.gmail.com>
	<4E52B7F8.3050002@zytor.com>
	<CAObL_7GmMXPUE0Oix1CKTYzqheyJV+ua=WEBUQk5m-LGsvqihw@mail.gmail.com>
	<4E52D280.3010107@zytor.com>
	<CA+55aFw4C+ShLHF2NYZMQ-Lhjow3mJ62_eqO_iAww2nh7V_-Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+55aFw4C+ShLHF2NYZMQ-Lhjow3mJ62_eqO_iAww2nh7V_-Uw@mail.gmail.com>
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
Cc: Andrew Lutomirski <luto@mit.edu>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, Richard Weinberger <richard@nod.at>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@amd64.org>, "mingo@redhat.com" <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>

On Mon, Aug 22, 2011 at 04:27:51PM -0700, Linus Torvalds wrote:

> So I think the "let's fix the vdso case for sysenter" + "let's remove
> the 32-bit syscall vdso" is the right solution. If somebody has
> hardcoded syscall instructions, or generates them dynamically with
> some JIT, that's their problem. We'll continue to support it as well
> as we ever have (read: "almost nobody will ever notice").

Umm...  Maybe, but I really wonder if it would be better to do this:
	* check if %ecx is the right one for vdso32 entry.  If it isn't,
act as we act now (and possibly warn).  If it is, increment it by 4.
	* slap 0x90, 0x90, 0xcd, 0x80 right after that syscall insn -
i.e. nop/nop/int 0x80.  Followed by what we currently do there.

	Those who do syscall insn in 32bit mode outside of vdso will get
what they currently get.  __kernel_vsyscall() will keep working and do
that without restart problems.  And the price is comparison + branch not
taken + addition for that path...

------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

