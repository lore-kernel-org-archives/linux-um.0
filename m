Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fengguang.wu@intel.com>) id 1d65Qp-0002GL-Oj
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 May 2017 01:19:47 +0000
Received: from mga03.intel.com ([134.134.136.65])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1d65Qn-0000xi-Li
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 May 2017 01:19:47 +0000
Date: Thu, 4 May 2017 09:19:28 +0800
From: kbuild test robot <fengguang.wu@intel.com>
Message-ID: <201705040922.MDbm1eEO%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
Subject: [uml-devel] [uml:linux-next 2/5]
 arch/um/os-Linux/skas/process.c:236:19: error: 'NR_CPUS' undeclared here
 (not in a function)
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Nikola Kotur <kotnick@gmail.com>
Cc: Richard Weinberger <richard@nod.at>, kbuild-all@01.org, user-mode-linux-devel@lists.sourceforge.net


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git linux-next
head:   5b4236e17cc1bd9fa14b2b0c7a4ae632d41f2e20
commit: 8bba077066d6d0a135b7be1970691522075bf905 [2/5] um: Set number of CPUs
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout 8bba077066d6d0a135b7be1970691522075bf905
        # save the attached .config to linux build tree
        make ARCH=um SUBARCH=x86_64

All errors (new ones prefixed by >>):

>> arch/um/os-Linux/skas/process.c:236:19: error: 'NR_CPUS' undeclared here (not in a function)
    int userspace_pid[NR_CPUS];
                      ^~~~~~~

vim +/NR_CPUS +236 arch/um/os-Linux/skas/process.c

abaf6977 Gennady Sharapov 2006-01-18  230  	}
abaf6977 Gennady Sharapov 2006-01-18  231  
512b6fb1 Jeff Dike        2007-10-16  232  	kill(os_getpid(), SIGSTOP);
ba180fd4 Jeff Dike        2007-10-16  233  	return 0;
abaf6977 Gennady Sharapov 2006-01-18  234  }
abaf6977 Gennady Sharapov 2006-01-18  235  
abaf6977 Gennady Sharapov 2006-01-18 @236  int userspace_pid[NR_CPUS];
abaf6977 Gennady Sharapov 2006-01-18  237  
abaf6977 Gennady Sharapov 2006-01-18  238  int start_userspace(unsigned long stub_stack)
abaf6977 Gennady Sharapov 2006-01-18  239  {

:::::: The code at line 236 was first introduced by commit
:::::: abaf69773d8dda98b917d94c07757f6520da7bec [PATCH] uml: move libc-dependent skas process handling

:::::: TO: Gennady Sharapov <Gennady.V.Sharapov@intel.com>
:::::: CC: Linus Torvalds <torvalds@g5.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--+QahgC5+KEYLbs62
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--+QahgC5+KEYLbs62
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
--+QahgC5+KEYLbs62
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--+QahgC5+KEYLbs62--


