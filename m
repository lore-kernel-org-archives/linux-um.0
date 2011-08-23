Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hpa@zytor.com>) id 1QvwUi-0000DG-8J
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Aug 2011 19:18:40 +0000
Received: from terminus.zytor.com ([198.137.202.10] helo=mail.zytor.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QvwUh-0001zH-Kv
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Aug 2011 19:18:40 +0000
Message-ID: <4E53FCF7.7060703@zytor.com>
Date: Tue, 23 Aug 2011 12:18:15 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
References: <4E52D280.3010107@zytor.com>
	<CA+55aFw4C+ShLHF2NYZMQ-Lhjow3mJ62_eqO_iAww2nh7V_-Uw@mail.gmail.com>
	<20110823000314.GW2203@ZenIV.linux.org.uk>
	<4E52EF2A.8060608@zytor.com>
	<CA+55aFx9zRTD72jaztLvyB68ejHcqM3Z3=b+6W64opfYu3ANjA@mail.gmail.com>
	<20110823010146.GY2203@ZenIV.linux.org.uk>
	<20110823011312.GZ2203@ZenIV.linux.org.uk>
	<20110823021717.GA2203@ZenIV.linux.org.uk>
	<20110823061531.GC2203@ZenIV.linux.org.uk>
	<CA+55aFzUAuPEwcvVvuXooWMT6XpDuOjEHi-Ab+SOhZVjfbVYpA@mail.gmail.com>
	<20110823164849.GF2203@ZenIV.linux.org.uk>
In-Reply-To: <20110823164849.GF2203@ZenIV.linux.org.uk>
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
Cc: Andrew Lutomirski <luto@mit.edu>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, Richard Weinberger <richard@nod.at>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@amd64.org>, "mingo@redhat.com" <mingo@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>

On 08/23/2011 09:48 AM, Al Viro wrote:
> 
> Um...  How would it know which syscall variant had that been, to start
> with?  For int 0x80 it would need to use registers as-is.  For SYSENTER
> it also could use them as-is - ebp will differ from what we put there
> when entering the sucker, but not critically so; on the way out of
> syscall we'll overwrite it anyway immediately (either by pop or mov).
> For SYSCALL... we don't really care about ecx contents prior to entering
> the kernel (and it'll be blown out anyway), and ebp one could be found in
> regs.ecx.  So yes, we can do it that way, but... how to tell what variant
> had been triggered?  Examining two bytes prior to user eip?  Sounds bloody
> brittle...

We could drop that information in a metaregister.  It's not backward
compatible, but at least it will be obvious when that information is
available and not.

	-hpa

------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

