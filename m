Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1d6A5a-00088V-EA
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 May 2017 06:18:10 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1d6A5Y-0000hz-Ts
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 May 2017 06:18:10 +0000
References: <201705040922.MDbm1eEO%fengguang.wu@intel.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <84b4a009-6848-5b0a-c7e0-79eac94f2572@nod.at>
Date: Thu, 4 May 2017 08:17:58 +0200
MIME-Version: 1.0
In-Reply-To: <201705040922.MDbm1eEO%fengguang.wu@intel.com>
Subject: Re: [uml-devel] [uml:linux-next 2/5]
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: kbuild test robot <fengguang.wu@intel.com>, Nikola Kotur <kotnick@gmail.com>
Cc: kbuild-all@01.org, user-mode-linux-devel@lists.sourceforge.net

Am 04.05.2017 um 03:19 schrieb kbuild test robot:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git linux-next
> head:   5b4236e17cc1bd9fa14b2b0c7a4ae632d41f2e20
> commit: 8bba077066d6d0a135b7be1970691522075bf905 [2/5] um: Set number of CPUs
> config: um-x86_64_defconfig (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         git checkout 8bba077066d6d0a135b7be1970691522075bf905
>         # save the attached .config to linux build tree
>         make ARCH=um SUBARCH=x86_64
> 
> All errors (new ones prefixed by >>):
> 
>>> arch/um/os-Linux/skas/process.c:236:19: error: 'NR_CPUS' undeclared here (not in a function)
>     int userspace_pid[NR_CPUS];

Fix is already in UML next.

Thanks,
//richard

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

