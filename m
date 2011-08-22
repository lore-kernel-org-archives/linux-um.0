Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hpa@zytor.com>) id 1QvLrt-0006g1-F9
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Aug 2011 04:12:09 +0000
Received: from terminus.zytor.com ([198.137.202.10] helo=mail.zytor.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QvLrs-0000rT-Fp
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Aug 2011 04:12:09 +0000
Message-ID: <4E51D70A.1060001@zytor.com>
Date: Sun, 21 Aug 2011 21:11:54 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
References: <CAObL_7FoPHu6AKneswjEmiU4UBjUuKpYahakOaTNXM3=ZCpYaA@mail.gmail.com>
	<CAObL_7H8E1fde-d_Kfjrg2mQ5PdAp9X=fVRTqXJKzzYmQ1vAQQ@mail.gmail.com>
	<20110821063443.GH2203@ZenIV.linux.org.uk>
	<20110821084230.GI2203@ZenIV.linux.org.uk>
	<CAObL_7GXyzAzNjBtgye9BwXLyHm337oBTdjRDjbSPqoKZGWyyA@mail.gmail.com>
	<20110821144352.GJ2203@ZenIV.linux.org.uk>
	<20110821164124.GL2203@ZenIV.linux.org.uk>
	<CAObL_7E1vU8+0UQST6Smf9j40TckTzB=QdY0AuAWo4AX6cs2xg@mail.gmail.com>
	<20110822011645.GM2203@ZenIV.linux.org.uk>
	<CA+55aFz1jCZGcQ-c6uGN=k8nKDuGoz5g8e+pxpYAg4X_p7=5Mw@mail.gmail.com>
	<20110822040759.GQ2203@ZenIV.linux.org.uk>
In-Reply-To: <20110822040759.GQ2203@ZenIV.linux.org.uk>
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
Cc: Andrew Lutomirski <luto@mit.edu>, user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, mingo@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>

On 08/21/2011 09:07 PM, Al Viro wrote:
> On Sun, Aug 21, 2011 at 06:41:16PM -0700, Linus Torvalds wrote:
>> On Sun, Aug 21, 2011 at 6:16 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>>>
>>> Is that ability a part of userland ABI or are we declaring that hopelessly
>>> wrong and require to go through the function in vdso32? ?Linus?
>>
>> If people are using syscall directly, we're pretty much stuck. No
>> amount of "that's hopelessly wrong" will ever matter. We don't break
>> existing binaries.
> 
> There's a funny part, though - such binary won't work on 32bit kernel.
> AFAICS, we never set MSR_*STAR on 32bit kernels (and native 32bit vdso
> doesn't provide a SYSCALL-based variant).
> 
> So if we really consider such SYSCALL outside of vdso32 kosher, shouldn't
> we do something with entry_32.S as well?  I don't think it's worth doing,
> TBH...
> 
> Again, I very much hope that binaries with such stray SYSCALL simply do
> not exist.  In theory it's possible to write one, but...
> 
> IIRC, the reason we never had SYSCALL support in 32bit kernel was the utter
> lack of point - the *only* CPU where it would matter would be K6-2, IIRC,
> and (again, IIRC) it had some differences in SYSCALL semantics compared to
> K7 (which supports SYSENTER as well).  Bugger if I remember what those
> differences might've been...  Some flag not cleared?

The most likely reason for a binary to execute a stray SYSCALL is
because they read it out of the vdso.  Totally daft, but we certainly
see a lot of stupid things as evidenced by the JIT thread earlier this
month.

In that sense, a "safe" thing would be to drop use of SYSCALL for 32-bit
processes... I just sent Borislav a query about the cost.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


------------------------------------------------------------------------------
uberSVN's rich system and user administration capabilities and model 
configuration take the hassle out of deploying and managing Subversion and 
the tools developers use with it. Learn more about uberSVN and get a free 
download at:  http://p.sf.net/sfu/wandisco-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

