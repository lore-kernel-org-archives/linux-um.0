Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1QvJ8U-0006xa-Un
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Aug 2011 01:17:06 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QvJ8S-0002Bh-KE
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Aug 2011 01:17:06 +0000
Date: Mon, 22 Aug 2011 02:16:45 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
Message-ID: <20110822011645.GM2203@ZenIV.linux.org.uk>
References: <20110820201406.GF2203@ZenIV.linux.org.uk>
	<4E501F51.9060905@nod.at>
	<CAObL_7FoPHu6AKneswjEmiU4UBjUuKpYahakOaTNXM3=ZCpYaA@mail.gmail.com>
	<CAObL_7H8E1fde-d_Kfjrg2mQ5PdAp9X=fVRTqXJKzzYmQ1vAQQ@mail.gmail.com>
	<20110821063443.GH2203@ZenIV.linux.org.uk>
	<20110821084230.GI2203@ZenIV.linux.org.uk>
	<CAObL_7GXyzAzNjBtgye9BwXLyHm337oBTdjRDjbSPqoKZGWyyA@mail.gmail.com>
	<20110821144352.GJ2203@ZenIV.linux.org.uk>
	<20110821164124.GL2203@ZenIV.linux.org.uk>
	<CAObL_7E1vU8+0UQST6Smf9j40TckTzB=QdY0AuAWo4AX6cs2xg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAObL_7E1vU8+0UQST6Smf9j40TckTzB=QdY0AuAWo4AX6cs2xg@mail.gmail.com>
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

On Sun, Aug 21, 2011 at 08:44:12PM -0400, Andrew Lutomirski wrote:

> This is, IMO, gross -- if the values in pt_regs matched what they were
> when sysenter / syscall was issued, then we'd be fine -- we could
> restart the syscall and everything would work.  Apparently ptrace
> users have a problem with that, so we're stuck with the "lie" (i.e.
> reporting values as of __kernel_vsyscall, not as of the actual kernel
> entry).

Um, _no_.  If nothing else, pt_regs is seen by sys_....  And they don't
bloody know or care how the syscall had been entered.

> Which suggests an easy-ish fix: if sysenter is used or if syscall is
> entered from the EIP is is supposed to be entered from, then just
> change ip in the argument save to point to the int 0x80 instruction.
> This might also require tweaking the userspace stack.  That way,
> restart would hit int 0x80 instead of syscall/sysenter and the
> registers are exactly as expected.

Huh?  Actions after SYSENTER differ from those after int 0x80.  If nothing
else, you would need to tweak saved userland stack pointer as well.  It is
possible, but I seriously doubt that it's a better way to deal with that
mess.  And in any case, SYSEXIT buggers CX/DX, so we'd need two separate
post-syscall sequences in vdso.  Yucky...  I really don't like it.

The really ugly part for the SYSCALL variant is that right now we *can*
do things like this:
read_it:
	pushl %ebp
	movl $__NR_read, %eax
	movl $0, %ebx
	movl $array, %ebp
	movl $100, %edx
	syscall
        movl $__USER32_DS, %ecx
        movl %ecx, %ss
	popl %ebp
	ret
anywhere in your userland and have it act as an equivalent of
int read_it(void)
{
	return read(0, array, 100);
}

Is that ability a part of userland ABI or are we declaring that hopelessly
wrong and require to go through the function in vdso32?  Linus?

As it is, I don't see any cheap ways to deal with restarts if that thing
has to be preserved.  For sysenter it's flatly prohibited and that allows
us to play such games with adjusted return address.  Here, OTOH...

------------------------------------------------------------------------------
uberSVN's rich system and user administration capabilities and model 
configuration take the hassle out of deploying and managing Subversion and 
the tools developers use with it. Learn more about uberSVN and get a free 
download at:  http://p.sf.net/sfu/wandisco-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

