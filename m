Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DJi7C-0002x1-5u for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Apr 2005 18:16:54 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DJi77-0006Ok-GH for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Apr 2005 18:16:54 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] UML-patches to prepare UML/s390
References: <4253E3D6.2000809@fujitsu-siemens.com>
In-Reply-To: <4253E3D6.2000809@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504080322.50532.blaisorblade@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 8 Apr 2005 03:22:45 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, Jeff Dike <jdike@addtoit.com>

On Wednesday 06 April 2005 15:27, Bodo Stroesser wrote:
> Here are the patches (tarball attached), that I've applied to
> UML 2.6.11 + incrementals, before adding s390-files.
> These patches are tested a bit on x86, but not on x86_64.
>
> s390 implementation is *not* included in tarball, this will
> be posted later, when thing are more stable.
>
> Please see patches and commented series-file for further
> information.

add-stub-vmas has already your notes in it, and I agree with the notes.

delay-pure-arch: forgot EXPORT_SYMBOL on x86_64, also if every arch will 
provide them leave the EXPORT inside arch-independent ksyms.c. Also I don't 
like a function copied over subarchs. Move them to generic code with an ifdef 
ARCH_WANT_WHATEVER.

Copied code *always* gets out of sync (and that's not only in UML, I found by 
accident a case where ext2 was updated and ext3 wasn't and didn't use 
i_size_read, leading to possible race conditions). Btw, that's why Andi Kleen 
delayed a lot the merge of Xen, refusing that it be a separate arch/xen 
folder.

elf.h-symlink.patch: other includes also have a -generic.h file, like 
processor-generic.h, for common stuff.

insert-ARCH_SIGHDLR_PARAM.patch: this coding is very awkward (not mentioned in 
CodingStyle because they didn't think to it) - I don't know the handle's use. 
However, some commenting will be needed, as this is *not* a widespread 
construct. You'll also tell me how you'll handle the different params if the 
code stays the same...
I'd instead use a "do_alarm_handler" that takes everything as a param and an 
arch-specific caller passing the params, in general... but I don't really 
realize what will you do there. I fear a hidden param in 
ARCH_GET_SIGCONTEXT...

ptrace-subarch: forgot the "#if 0" for x86_64, possibly preventing it from 
compiling. Actually, from looking to /usr/include/sys/user.h, it will compile 
but be bogus. Keep the XXX comment but change the "addr >>= 2" to "addr >>= 
3" (because the various debug regs are each 8 and not 4 bytes long). I'll 
have to additionally check the manuals, however, this is why I ask to keep 
the comment.

rename-COMMAND_LINE_SIZE.patch: it's against an outdated part of Jeff's tree 
(i.e. code movements). I patched it in a different way in mainline - I thinl 
that code-movements patches should be merged the day they are written, or one 
day they are written. I.e. they must be rewritten when merging them, to avoid 
moving outdated code.

split-sys_call_table.patch: the current way of maintaining it has lead to too 
many problems, so I'm converting the code to a different way, i.e. including 
directly the original syscall table (with some defines, for instance

#define sys_iopl sys_ni_syscall

).
I didn't send them because I need that Jeff tests the x86_64 ones.

In i386 case, I split away the table from entry.S. In the s390 case, they 
already did this for theirselves and for us. You'll have to check if any 
function has been renamed in a strange way. I'll maybe do the check myself...

Also, the below is just bogus, 
-#ifdef CONFIG_NFSD
+#if defined(CONFIG_NFSD) || defined(CONFIG_NFSD_MODULE)
 #define NFSSERVCTL sys_nfsservctl
 #else
 #define NFSSERVCTL sys_ni_syscall
 #endif
because the correct code is this:
 #define NFSSERVCTL sys_nfsservctl

kernel/sys_ni.c will alias sys_nfsservctl (and *MANY* other syscalls) to 
sys_ni_syscall if needed, through weak symbols.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
