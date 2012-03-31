Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <glud-user-mode-linux-devel@m.gmane.org>)
	id 1SEF5B-0005Mg-TF for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Apr 2012 07:20:13 +0000
Received: from plane.gmane.org ([80.91.229.3])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SEF5A-00021k-HI
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Apr 2012 07:20:13 +0000
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glud-user-mode-linux-devel@m.gmane.org>)
	id 1SEF51-0005ro-9e for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Apr 2012 09:20:03 +0200
Received: from 122.167.219.127 ([122.167.219.127])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 01 Apr 2012 09:20:03 +0200
Received: from rrs by 122.167.219.127 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 01 Apr 2012 09:20:03 +0200
From: Ritesh Raj Sarraf <rrs@debian.org>
Date: Sun, 01 Apr 2012 00:14:48 +0530
Message-ID: <0uvj49xgsm.ln2@news.researchut.com>
Mime-Version: 1.0
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
Subject: [uml-devel] uml build failure on arch i386
To: user-mode-linux-devel@lists.sourceforge.net

Hello,

I am trying to build uml on kernel 3.2. Following is the build failure I
get when building on my kvm x86 box.

The kvm box is arch:
root@debian-x86:~/user-mode-linux (build)# uname -a
Linux debian-x86 3.0.0-1-686-pae #1 SMP Sat Aug 27 16:41:03 UTC 2011
i686 GNU/Linux


My initial search led me to:
http://sourceforge.net/mailarchive/message.php?msg_id=27848489

Based on the comment there, I've tried SUBARCH=i386. But that didn't
help. Any suggestions?



  LD      vmlinux.o
  MODPOST vmlinux.o
  GEN     .version
  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/x86/um/built-in.o:(___ksymtab+atomic64_add_unless_386+0x0):
undefined reference to `atomic64_add_unless_386'
arch/x86/um/built-in.o:(___ksymtab+atomic64_inc_not_zero_386+0x0):
undefined reference to `atomic64_inc_not_zero_386'
arch/x86/um/built-in.o:(___ksymtab+atomic64_dec_if_positive_386+0x0):
undefined reference to `atomic64_dec_if_positive_386'
arch/x86/um/built-in.o:(___ksymtab+atomic64_dec_386+0x0): undefined
reference to `atomic64_dec_386'
arch/x86/um/built-in.o:(___ksymtab+atomic64_inc_386+0x0): undefined
reference to `atomic64_inc_386'
arch/x86/um/built-in.o:(___ksymtab+atomic64_sub_386+0x0): undefined
reference to `atomic64_sub_386'
arch/x86/um/built-in.o:(___ksymtab+atomic64_add_386+0x0): undefined
reference to `atomic64_add_386'
arch/x86/um/built-in.o:(___ksymtab+atomic64_dec_return_386+0x0):
undefined reference to `atomic64_dec_return_386'
arch/x86/um/built-in.o:(___ksymtab+atomic64_inc_return_386+0x0):
undefined reference to `atomic64_inc_return_386'
arch/x86/um/built-in.o:(___ksymtab+atomic64_sub_return_386+0x0):
undefined reference to `atomic64_sub_return_386'
arch/x86/um/built-in.o:(___ksymtab+atomic64_add_return_386+0x0):
undefined reference to `atomic64_add_return_386'
arch/x86/um/built-in.o:(___ksymtab+atomic64_xchg_386+0x0): undefined
reference to `atomic64_xchg_386'
arch/x86/um/built-in.o:(___ksymtab+atomic64_set_386+0x0): undefined
reference to `atomic64_set_386'
arch/x86/um/built-in.o:(___ksymtab+atomic64_read_386+0x0): undefined
reference to `atomic64_read_386'
fs/built-in.o: In function `xlog_find_tail':
xfs_log_recover.c:(.text+0x133341): undefined reference to
`atomic64_set_386'
xfs_log_recover.c:(.text+0x13335c): undefined reference to
`atomic64_set_386'
xfs_log_recover.c:(.text+0x133379): undefined reference to
`atomic64_set_386'
xfs_log_recover.c:(.text+0x133396): undefined reference to
`atomic64_set_386'
xfs_log_recover.c:(.text+0x133412): undefined reference to
`atomic64_read_386'
xfs_log_recover.c:(.text+0x13349e): undefined reference to
`atomic64_set_386'
xfs_log_recover.c:(.text+0x1334b2): undefined reference to
`atomic64_set_386'
fs/built-in.o: In function `xlog_space_left':
xfs_log.c:(.text+0x13a42f): undefined reference to `atomic64_read_386'
xfs_log.c:(.text+0x13a43b): undefined reference to `atomic64_read_386'
fs/built-in.o: In function `xlog_alloc_log':
xfs_log.c:(.text+0x13a591): undefined reference to `atomic64_set_386'
xfs_log.c:(.text+0x13a5a0): undefined reference to `atomic64_set_386'
xfs_log.c:(.text+0x13a5b9): undefined reference to `atomic64_set_386'
xfs_log.c:(.text+0x13a5cb): undefined reference to `atomic64_set_386'
fs/built-in.o: In function `xlog_grant_push_ail':  
xfs_log.c:(.text+0x13a8f9): undefined reference to `atomic64_read_386'
xfs_log.c:(.text+0x13a91f): undefined reference to `atomic64_read_386'
fs/built-in.o: In function `xlog_grant_sub_space.isra.26':
xfs_log.c:(.text+0x13ab87): undefined reference to `atomic64_read_386'
xfs_log.c:(.text+0x13abad): undefined reference to `cmpxchg8b_emu'
fs/built-in.o: In function `xlog_grant_add_space.isra.27':
xfs_log.c:(.text+0x13abd4): undefined reference to `atomic64_read_386'
xfs_log.c:(.text+0x13ac04): undefined reference to `cmpxchg8b_emu'
fs/built-in.o: In function `xlog_state_do_callback':
xfs_log.c:(.text+0x13b1e1): undefined reference to `atomic64_set_386'
fs/built-in.o: In function `xfs_log_move_tail':
(.text+0x13b5e0): undefined reference to `atomic64_read_386'
fs/built-in.o: In function `xfs_log_move_tail':
(.text+0x13b605): undefined reference to `atomic64_set_386'
fs/built-in.o: In function `xlog_assign_tail_lsn': 
(.text+0x13b83e): undefined reference to `atomic64_read_386'
fs/built-in.o: In function `xlog_assign_tail_lsn': 
(.text+0x13b856): undefined reference to `atomic64_set_386'
collect2: ld returned 1 exit status
  KSYM    .tmp_kallsyms1.S
nm: '.tmp_vmlinux1': No such file
No valid symbol.
make[1]: *** [.tmp_kallsyms1.S] Error 1
make[1]: Leaving directory
`/tmp/buildd/user-mode-linux-3.2-1um/linux-source-3.2'
make: *** [build-stamp] Error 2
dpkg-buildpackage: error: debian/rules build gave error exit status 2
E: Failed autobuilding of package
I: unmounting /var/cache/pbuilder/ccache filesystem
I: unmounting dev/pts filesystem
I: unmounting proc filesystem
 -> Cleaning COW directory
  forking: rm -rf /var/cache/pbuilder/build//cow.2932

-- 
Given the large number of mailing lists I follow, I request you to CC me
in replies for quicker response



------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

