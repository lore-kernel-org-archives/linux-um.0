Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qv9NP-0003jJ-Nv
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 Aug 2011 14:51:51 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qv9NO-00056X-FS
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 Aug 2011 14:51:51 +0000
Date: Sun, 21 Aug 2011 15:51:26 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
Message-ID: <20110821145126.GK2203@ZenIV.linux.org.uk>
References: <20110820011845.GC2203@ZenIV.linux.org.uk> <4E4FD12F.70508@nod.at>
	<20110820201406.GF2203@ZenIV.linux.org.uk>
	<4E501F51.9060905@nod.at>
	<CAObL_7FoPHu6AKneswjEmiU4UBjUuKpYahakOaTNXM3=ZCpYaA@mail.gmail.com>
	<CAObL_7H8E1fde-d_Kfjrg2mQ5PdAp9X=fVRTqXJKzzYmQ1vAQQ@mail.gmail.com>
	<20110821063443.GH2203@ZenIV.linux.org.uk>
	<20110821084230.GI2203@ZenIV.linux.org.uk>
	<CAObL_7GXyzAzNjBtgye9BwXLyHm337oBTdjRDjbSPqoKZGWyyA@mail.gmail.com>
	<CAObL_7HGJqP-hdXpdRLYkksfeVtQ1z1ngP58gdTnWwD57duaXA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAObL_7HGJqP-hdXpdRLYkksfeVtQ1z1ngP58gdTnWwD57duaXA@mail.gmail.com>
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
To: Andrew Lutomirski <luto@mit.edu>
Cc: user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, mingo@redhat.com, "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Sun, Aug 21, 2011 at 09:37:18AM -0400, Andrew Lutomirski wrote:

> Gack.  Is this a holdover from the 32-bit code that shares the
> argument save area with the parameters passed on the C stack?  If so,
> we could just set up the argument save area honestly and pass the real
> parameters in registers like 64-bit C code expects.
> 
> If the tracing and restart cases use iret to return to userspace, this
> should all just work.  ptrace users shouldn't notice the overhead, and
> syscall restart is presumably slow enough anyway that it wouldn't
> matter.  The userspace entry code would be as simple as:
> 
> sysenter
> ret
> 
> or
> 
> sysexit
> ret

You are making no sense at all...

------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

