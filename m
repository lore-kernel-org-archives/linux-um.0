Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1dT4PT-0004TW-DD
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Jul 2017 10:53:23 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dT4PR-000479-Tr
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Jul 2017 10:53:23 +0000
References: <201707061329.yQKTxvEU%fengguang.wu@intel.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <f0977111-5741-6072-34ee-005fe6e19cc7@nod.at>
Date: Thu, 6 Jul 2017 12:53:11 +0200
MIME-Version: 1.0
In-Reply-To: <201707061329.yQKTxvEU%fengguang.wu@intel.com>
Content-Language: en-US
Subject: Re: [uml-devel] [uml:linux-next 7/9]
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: kbuild test robot <fengguang.wu@intel.com>, Florian Fainelli <f.fainelli@gmail.com>
Cc: kbuild-all@01.org, user-mode-linux-devel@lists.sourceforge.net

Am 06.07.2017 um 07:48 schrieb kbuild test robot:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git linux-next
> head:   1bcbfbfdeb0091036db7a32e1cd31b49cce5983a
> commit: f44f1e7da7c8e3f4575d5d61c4df978496903fcc [7/9] um: Avoid longjmp/setjmp symbol clashes with libpthread.a
> config: um-x86_64_defconfig (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         git checkout f44f1e7da7c8e3f4575d5d61c4df978496903fcc
>         # save the attached .config to linux build tree
>         make ARCH=um SUBARCH=x86_64
> 
> All warnings (new ones prefixed by >>):
> 
>    arch/um/os-Linux/skas/process.c: In function 'start_idle_thread':
>>> arch/um/os-Linux/skas/process.c:579:1: warning: control reaches end of non-void function [-Wreturn-type]
>     }
>     ^
> 
> vim +579 arch/um/os-Linux/skas/process.c
> 
> abaf6977 Gennady Sharapov 2006-01-18  563  	case INIT_JMP_CALLBACK:
> abaf6977 Gennady Sharapov 2006-01-18  564  		(*cb_proc)(cb_arg);
> 77f6af77 Jeff Dike        2007-05-06  565  		longjmp(*cb_back, 1);
> abaf6977 Gennady Sharapov 2006-01-18  566  		break;
> abaf6977 Gennady Sharapov 2006-01-18  567  	case INIT_JMP_HALT:
> abaf6977 Gennady Sharapov 2006-01-18  568  		kmalloc_ok = 0;
> ba180fd4 Jeff Dike        2007-10-16  569  		return 0;
> abaf6977 Gennady Sharapov 2006-01-18  570  	case INIT_JMP_REBOOT:
> abaf6977 Gennady Sharapov 2006-01-18  571  		kmalloc_ok = 0;
> ba180fd4 Jeff Dike        2007-10-16  572  		return 1;
> abaf6977 Gennady Sharapov 2006-01-18  573  	default:
> 3e6f2ac4 Jeff Dike        2008-02-04  574  		printk(UM_KERN_ERR "Bad sigsetjmp return in "
> 3e6f2ac4 Jeff Dike        2008-02-04  575  		       "start_idle_thread - %d\n", n);
> 3e6f2ac4 Jeff Dike        2008-02-04  576  		fatal_sigsegv();
> abaf6977 Gennady Sharapov 2006-01-18  577  	}
> 77f6af77 Jeff Dike        2007-05-06  578  	longjmp(*switch_buf, 1);
> abaf6977 Gennady Sharapov 2006-01-18 @579  }
> abaf6977 Gennady Sharapov 2006-01-18  580  
> abaf6977 Gennady Sharapov 2006-01-18  581  void initial_thread_cb_skas(void (*proc)(void *), void *arg)
> abaf6977 Gennady Sharapov 2006-01-18  582  {
> ad28e029 Jeff Dike        2006-04-18  583  	jmp_buf here;
> abaf6977 Gennady Sharapov 2006-01-18  584  
> abaf6977 Gennady Sharapov 2006-01-18  585  	cb_proc = proc;
> abaf6977 Gennady Sharapov 2006-01-18  586  	cb_arg = arg;
> abaf6977 Gennady Sharapov 2006-01-18  587  	cb_back = &here;

I suggest this as fix:
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 03b3c4cc7735..6869df60a722 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -576,6 +576,9 @@ int start_idle_thread(void *stack, jmp_buf *switch_buf)
                fatal_sigsegv();
        }
        longjmp(*switch_buf, 1);
+
+       /* Unreachable */
+       return 0;
 }

Unless I miss something the idle thread never exits here.

Thanks,
//richard

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

