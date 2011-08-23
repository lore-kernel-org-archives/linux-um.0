Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qvwqm-0001bj-4g
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Aug 2011 19:41:28 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qvwqk-0002aN-T3
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Aug 2011 19:41:28 +0000
Date: Tue, 23 Aug 2011 20:41:03 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
Message-ID: <20110823194103.GK2203@ZenIV.linux.org.uk>
References: <4E52EF2A.8060608@zytor.com>
	<CA+55aFx9zRTD72jaztLvyB68ejHcqM3Z3=b+6W64opfYu3ANjA@mail.gmail.com>
	<20110823010146.GY2203@ZenIV.linux.org.uk>
	<20110823011312.GZ2203@ZenIV.linux.org.uk>
	<20110823021717.GA2203@ZenIV.linux.org.uk>
	<20110823061531.GC2203@ZenIV.linux.org.uk>
	<CA+55aFzUAuPEwcvVvuXooWMT6XpDuOjEHi-Ab+SOhZVjfbVYpA@mail.gmail.com>
	<20110823164849.GF2203@ZenIV.linux.org.uk>
	<4E53FCF7.7060703@zytor.com>
	<CA+55aFyQTgXD6WeKJLvfOdsgqon=vhnhZ-h9oVpGF1uwQZkdDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+55aFyQTgXD6WeKJLvfOdsgqon=vhnhZ-h9oVpGF1uwQZkdDQ@mail.gmail.com>
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

On Tue, Aug 23, 2011 at 12:24:22PM -0700, Linus Torvalds wrote:
> On Tue, Aug 23, 2011 at 12:18 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> >
> > We could drop that information in a metaregister. ?It's not backward
> > compatible, but at least it will be obvious when that information is
> > available and not.
> 
> Well, seriously, UML already looks at the word at "ip-2" for other
> reasons. So it isn't like there is any point in adding more support to
> just give you that information in another form.

That is done only for task singlestepped in the guest:
        /*
         * This closes a way to execute a system call on the host.  If
         * you set a breakpoint on a system call instruction and singlestep
         * from it, the tracing thread used to PTRACE_SINGLESTEP the process
         * rather than PTRACE_SYSCALL it, allowing the system call to execute
         * on the host.  The tracing thread will check this flag and
         * PTRACE_SYSCALL if necessary.
         */
        if (current->ptrace & PT_DTRACE)
                current->thread.singlestep_syscall =
                        is_syscall(PT_REGS_IP(&current->thread.regs));
with PT_DTRACE set by uml user_enable_single_step()

And it's not cheap - doing that on each syscall will be unpleasant...
Frankly, I'd rather stopped telling the uml userland about vdso in such
setups.  And anything that plays with SYSCALL outside of vdso... <shrug>
we already have a "don't run it native on 32bit", adding "don't run
it on 32bit uml on amd64 host" is not too serious.  At least for now...

------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

