Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1QvuJ4-0007I3-2p
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Aug 2011 16:58:30 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QvuJ2-0005pA-RL
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Aug 2011 16:58:30 +0000
Message-ID: <4E53DC2A.3020004@nod.at>
Date: Tue, 23 Aug 2011 18:58:18 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <4E52EF2A.8060608@zytor.com>
	<CA+55aFx9zRTD72jaztLvyB68ejHcqM3Z3=b+6W64opfYu3ANjA@mail.gmail.com>
	<20110823010146.GY2203@ZenIV.linux.org.uk>
	<20110823011312.GZ2203@ZenIV.linux.org.uk>
	<20110823021717.GA2203@ZenIV.linux.org.uk>
	<20110823061531.GC2203@ZenIV.linux.org.uk>
	<CA+55aFzUAuPEwcvVvuXooWMT6XpDuOjEHi-Ab+SOhZVjfbVYpA@mail.gmail.com>
	<CAObL_7F-E2y_cd1MK4ayBx_CqszrewSrBt6V7=ndVuBQrrmTKQ@mail.gmail.com>
	<20110823162251.GC13138@aftab>
	<CA+55aFxJF88EJ=WhPq08j4+REBgpvVHVwbg5BR05DD+exRyp8A@mail.gmail.com>
	<20110823165320.GG2203@ZenIV.linux.org.uk>
In-Reply-To: <20110823165320.GG2203@ZenIV.linux.org.uk>
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

Am 23.08.2011 18:53, schrieb Al Viro:
> On Tue, Aug 23, 2011 at 09:29:29AM -0700, Linus Torvalds wrote:
>
>> Oh yes.
>>
>> System call performance is *important*. And x86 is *important*.
>>
>> UML? In comparison, not that important.
>>
>> So quite frankly, if this is purely an UML issue (and unless we're
>> missing something else, that's what it looks like, despite all the
>> confusion we've had so far), then if we have a choice between "remove
>> syscall instruction" and "remove UML", then ...
>
> Agreed.  Note, BTW, that UML has perfectly usable workaround for 99% of
> that - don't tell the binaries it has *any* vdso in such cases.  And
> "remove UML" turns into "remove support under UML for 32bit binaries
> that go out of their way to do SYSCALL directly, which wouldn't work
> on native 32bit", which is really a no-brainer.

What about this hack/solution?
While booting UML can check whether the host's vDSO contains
a SYSCALL instruction.
If so, UML will not make the host's vDSO available to it's
processes...

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

