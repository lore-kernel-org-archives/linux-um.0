Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1Qvuna-0005Pz-EH
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Aug 2011 17:30:02 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QvunZ-00073S-7r
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Aug 2011 17:30:02 +0000
Message-ID: <4E53E38F.2060300@nod.at>
Date: Tue, 23 Aug 2011 19:29:51 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <20110823010146.GY2203@ZenIV.linux.org.uk>
	<20110823011312.GZ2203@ZenIV.linux.org.uk>
	<20110823021717.GA2203@ZenIV.linux.org.uk>
	<20110823061531.GC2203@ZenIV.linux.org.uk>
	<CA+55aFzUAuPEwcvVvuXooWMT6XpDuOjEHi-Ab+SOhZVjfbVYpA@mail.gmail.com>
	<CAObL_7F-E2y_cd1MK4ayBx_CqszrewSrBt6V7=ndVuBQrrmTKQ@mail.gmail.com>
	<20110823162251.GC13138@aftab>
	<CA+55aFxJF88EJ=WhPq08j4+REBgpvVHVwbg5BR05DD+exRyp8A@mail.gmail.com>
	<20110823165320.GG2203@ZenIV.linux.org.uk>
	<4E53DC2A.3020004@nod.at>
	<20110823170740.GH2203@ZenIV.linux.org.uk>
In-Reply-To: <20110823170740.GH2203@ZenIV.linux.org.uk>
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
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Andrew Lutomirski <luto@mit.edu>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@amd64.org>, "mingo@redhat.com" <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>

Am 23.08.2011 19:07, schrieb Al Viro:
> On Tue, Aug 23, 2011 at 06:58:18PM +0200, Richard Weinberger wrote:
>
>> What about this hack/solution?
>> While booting UML can check whether the host's vDSO contains
>> a SYSCALL instruction.
>> If so, UML will not make the host's vDSO available to it's
>> processes...
>
> Note that this is *only* for 32bit side of things.  64bit one works fine...

I know. :)

> I wouldn't search for SYSCALL in vdso, BTW - not when we have a good way
> to trigger that crap and recognize it.
>
> At boot time, fork a child.  Have it traced with PTRACE_SYSCALL.  Let it
> put recognizable values in registers and call __kernel_vsyscall().  Then
> let the parent do one more PTRACE_SYSCALL, then PTRACE_POKEUSER and set ebp
> to 0x69696969.  PTRACE_CONT the sucker and let it report what it sees in ecx.
> If it's what we'd put there - fine, it looks safe.  If it's 0x69696969 -
> we have a problem, no vdso for us.

Okay, this is a much cleaner approach.
But first I've to find a machine where I can test the issue.
At home none on of my x86_64 machines is SYSCALL-based.
Tomorrow I'll search at the university for one...

Thanks,
//richard

------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

