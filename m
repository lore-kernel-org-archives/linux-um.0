Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPbZu-00014b-Hy for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 16 May 2004 23:26:22 -0700
Received: from rwcrmhc11.comcast.net ([204.127.198.35])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPbZu-0002bv-4P for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 16 May 2004 23:26:22 -0700
Received: from SCG2 ([10.0.0.29])
	by www.gspcg.com (8.11.2/8.11.2) with SMTP id i4H6QGW23455
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 16 May 2004 23:26:16 -0700
From: "Anthony Brock" <Anthony_Brock@ous.edu>
Message-ID: <IFEIKNDOLFNCKMGAENCFGEPBCDAA.Anthony_Brock@ous.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
In-Reply-To: <IFEIKNDOLFNCKMGAENCFOEOICDAA.Anthony_Brock@ous.edu>
Subject: [uml-devel] RE: [uml-user] UML on 64-Bit AMD
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
Date: Sun, 16 May 2004 23:26:12 -0700
To: user-mode-linux-devel@lists.sourceforge.net

I apologize if I am posting to the wrong group. However, troubleshooting a
compile doesn't seem appropriate for the user list...

Given problems with compiling the "evaluation" of UML in 64-bit mode (on a
64-bit AMD host), I tried to compile a 32-bit version so we could start
playing. The results are not initially promising. First, it failed to
compile due to a missing Makefile-x86_64. So I modified the base Makefile to
assume a subarch of i386:

diff Makefile.orig Makefile
131c131,132
<                                 -e s/s390x/s390/ -e s/parisc64/parisc/ )
---
>                                 -e s/s390x/s390/ -e s/parisc64/parisc/ \
>                                 -e s/x86_64/i386/ )

Now, when attempting to compile, I see:

  HOSTCC  arch/um/sys-i386/util/mk_sc
arch/um/sys-i386/util/mk_sc.c: In function `main':
arch/um/sys-i386/util/mk_sc.c:21: error: structure has no member named `eip'
arch/um/sys-i386/util/mk_sc.c:22: error: structure has no member named `esp'
arch/um/sys-i386/util/mk_sc.c:23: warning: int format, different type arg
(arg 2)
arch/um/sys-i386/util/mk_sc.c:24: warning: int format, different type arg
(arg 2)
arch/um/sys-i386/util/mk_sc.c:25: error: structure has no member named `ds'
arch/um/sys-i386/util/mk_sc.c:26: error: structure has no member named `es'
arch/um/sys-i386/util/mk_sc.c:27: error: structure has no member named `ss'
arch/um/sys-i386/util/mk_sc.c:28: warning: int format, different type arg
(arg 2)
arch/um/sys-i386/util/mk_sc.c:29: warning: int format, different type arg
(arg 2)
arch/um/sys-i386/util/mk_sc.c:30: error: structure has no member named `eax'
arch/um/sys-i386/util/mk_sc.c:31: error: structure has no member named `ebx'
arch/um/sys-i386/util/mk_sc.c:32: error: structure has no member named `ecx'
arch/um/sys-i386/util/mk_sc.c:33: error: structure has no member named `edx'
arch/um/sys-i386/util/mk_sc.c:34: error: structure has no member named `edi'
arch/um/sys-i386/util/mk_sc.c:35: error: structure has no member named `esi'
arch/um/sys-i386/util/mk_sc.c:36: error: structure has no member named `ebp'
arch/um/sys-i386/util/mk_sc.c:37: warning: int format, different type arg
(arg 2)
arch/um/sys-i386/util/mk_sc.c:38: warning: int format, different type arg
(arg 2)
arch/um/sys-i386/util/mk_sc.c:39: warning: int format, different type arg
(arg 2)
arch/um/sys-i386/util/mk_sc.c:40: warning: int format, different type arg
(arg 2)
arch/um/sys-i386/util/mk_sc.c:41: warning: int format, different type arg
(arg 2)
arch/um/sys-i386/util/mk_sc.c:42: error: structure has no member named `cw'
arch/um/sys-i386/util/mk_sc.c:43: error: structure has no member named `sw'
arch/um/sys-i386/util/mk_sc.c:44: error: structure has no member named `tag'
arch/um/sys-i386/util/mk_sc.c:45: error: structure has no member named
`ipoff'
arch/um/sys-i386/util/mk_sc.c:46: error: structure has no member named
`cssel'
arch/um/sys-i386/util/mk_sc.c:47: error: structure has no member named
`dataoff'
arch/um/sys-i386/util/mk_sc.c:48: error: structure has no member named
`datasel'
arch/um/sys-i386/util/mk_sc.c:49: warning: int format, different type arg
(arg 2)
arch/um/sys-i386/util/mk_sc.c:50: error: structure has no member named
`_fxsr_env'
make[1]: *** [arch/um/sys-i386/util/mk_sc] Error 1
make: *** [arch/um/sys-i386/util/mk_sc] Error 2

Any ideas? I'm beginning to remember why it's been over a decade since I
dealt with the Linux kernel code. Even then I was a poor excuse for a
programmer...

Thanks again for your patience.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
