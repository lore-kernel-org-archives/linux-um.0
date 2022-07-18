Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 18 Jul 2022 09:13:44 +0800
From: kernel test robot <lkp@intel.com>
Subject: [rw-uml:linux-next 11/16] arch/um/os-Linux/mem.c:28:6: warning: no
 previous prototype for 'kasan_map_memory'
Message-ID: <202207180935.daaJausv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Patricia Alfonso <trishalfonso@google.com>
Cc: kbuild-all@lists.01.org, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>, Vincent Whitchurch <vincent.whitchurch@axis.com>, David Gow <davidgow@google.com>, Johannes Berg <johannes@sipsolutions.net>, Dmitry Vyukov <dvyukov@google.com>, Andrey Konovalov <andreyknvl@gmail.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git linux-next
head:   af3e16101cee95efaa72095fe06c15ec0b8eb195
commit: 5b301409e8bc5d7fad2ee138be44c5c529dd0874 [11/16] UML: add support for KASAN under x86_64
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220718/202207180935.daaJausv-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git/commit/?id=5b301409e8bc5d7fad2ee138be44c5c529dd0874
        git remote add rw-uml https://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git
        git fetch --no-tags rw-uml linux-next
        git checkout 5b301409e8bc5d7fad2ee138be44c5c529dd0874
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/um/os-Linux/mem.c:28:6: warning: no previous prototype for 'kasan_map_memory' [-Wmissing-prototypes]
      28 | void kasan_map_memory(void *start, size_t len)
         |      ^~~~~~~~~~~~~~~~
   arch/um/os-Linux/mem.c:212:13: warning: no previous prototype for 'check_tmpexec' [-Wmissing-prototypes]
     212 | void __init check_tmpexec(void)
         |             ^~~~~~~~~~~~~


vim +/kasan_map_memory +28 arch/um/os-Linux/mem.c

    19	
    20	/*
    21	 * kasan_map_memory - maps memory from @start with a size of @len.
    22	 * The allocated memory is filled with zeroes upon success.
    23	 * @start: the start address of the memory to be mapped
    24	 * @len: the length of the memory to be mapped
    25	 *
    26	 * This function is used to map shadow memory for KASAN in uml
    27	 */
  > 28	void kasan_map_memory(void *start, size_t len)
    29	{
    30		if (mmap(start,
    31			 len,
    32			 PROT_READ|PROT_WRITE,
    33			 MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE|MAP_NORESERVE,
    34			 -1,
    35			 0) == MAP_FAILED) {
    36			os_info("Couldn't allocate shadow memory: %s\n.",
    37				strerror(errno));
    38			exit(1);
    39		}
    40	}
    41	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

