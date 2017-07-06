Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fengguang.wu@intel.com>) id 1dSzfb-0007AK-CB
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Jul 2017 05:49:43 +0000
Received: from mga04.intel.com ([192.55.52.120])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dSzfY-0001qF-Cs
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Jul 2017 05:49:43 +0000
Date: Thu, 6 Jul 2017 13:48:37 +0800
From: kbuild test robot <fengguang.wu@intel.com>
Message-ID: <201707061329.yQKTxvEU%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
Subject: [uml-devel] [uml:linux-next 7/9]
 arch/um/os-Linux/skas/process.c:579:1: warning: control reaches end of
 non-void function
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Richard Weinberger <richard@nod.at>, kbuild-all@01.org, user-mode-linux-devel@lists.sourceforge.net


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git linux-next
head:   1bcbfbfdeb0091036db7a32e1cd31b49cce5983a
commit: f44f1e7da7c8e3f4575d5d61c4df978496903fcc [7/9] um: Avoid longjmp/setjmp symbol clashes with libpthread.a
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout f44f1e7da7c8e3f4575d5d61c4df978496903fcc
        # save the attached .config to linux build tree
        make ARCH=um SUBARCH=x86_64

All warnings (new ones prefixed by >>):

   arch/um/os-Linux/skas/process.c: In function 'start_idle_thread':
>> arch/um/os-Linux/skas/process.c:579:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^

vim +579 arch/um/os-Linux/skas/process.c

abaf6977 Gennady Sharapov 2006-01-18  563  	case INIT_JMP_CALLBACK:
abaf6977 Gennady Sharapov 2006-01-18  564  		(*cb_proc)(cb_arg);
77f6af77 Jeff Dike        2007-05-06  565  		longjmp(*cb_back, 1);
abaf6977 Gennady Sharapov 2006-01-18  566  		break;
abaf6977 Gennady Sharapov 2006-01-18  567  	case INIT_JMP_HALT:
abaf6977 Gennady Sharapov 2006-01-18  568  		kmalloc_ok = 0;
ba180fd4 Jeff Dike        2007-10-16  569  		return 0;
abaf6977 Gennady Sharapov 2006-01-18  570  	case INIT_JMP_REBOOT:
abaf6977 Gennady Sharapov 2006-01-18  571  		kmalloc_ok = 0;
ba180fd4 Jeff Dike        2007-10-16  572  		return 1;
abaf6977 Gennady Sharapov 2006-01-18  573  	default:
3e6f2ac4 Jeff Dike        2008-02-04  574  		printk(UM_KERN_ERR "Bad sigsetjmp return in "
3e6f2ac4 Jeff Dike        2008-02-04  575  		       "start_idle_thread - %d\n", n);
3e6f2ac4 Jeff Dike        2008-02-04  576  		fatal_sigsegv();
abaf6977 Gennady Sharapov 2006-01-18  577  	}
77f6af77 Jeff Dike        2007-05-06  578  	longjmp(*switch_buf, 1);
abaf6977 Gennady Sharapov 2006-01-18 @579  }
abaf6977 Gennady Sharapov 2006-01-18  580  
abaf6977 Gennady Sharapov 2006-01-18  581  void initial_thread_cb_skas(void (*proc)(void *), void *arg)
abaf6977 Gennady Sharapov 2006-01-18  582  {
ad28e029 Jeff Dike        2006-04-18  583  	jmp_buf here;
abaf6977 Gennady Sharapov 2006-01-18  584  
abaf6977 Gennady Sharapov 2006-01-18  585  	cb_proc = proc;
abaf6977 Gennady Sharapov 2006-01-18  586  	cb_arg = arg;
abaf6977 Gennady Sharapov 2006-01-18  587  	cb_back = &here;

:::::: The code at line 579 was first introduced by commit
:::::: abaf69773d8dda98b917d94c07757f6520da7bec [PATCH] uml: move libc-dependent skas process handling

:::::: TO: Gennady Sharapov <Gennady.V.Sharapov@intel.com>
:::::: CC: Linus Torvalds <torvalds@g5.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--2fHTh5uZTiUOsy+g
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--2fHTh5uZTiUOsy+g--


