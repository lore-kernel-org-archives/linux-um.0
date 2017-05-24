Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 25 May 2017 00:21:48 +0800
From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] um: Avoid longjmp/setjmp symbol clashes with libpthread.a
Message-ID: <201705250050.DYFHgp0l%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <20170523210813.22816-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-devel@lists.sourceforge.net>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Florian,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.12-rc2 next-20170524]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Florian-Fainelli/um-Avoid-longjmp-setjmp-symbol-clashes-with-libpthread-a/20170524-154948
config: um-allnoconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=um 

All errors (new ones prefixed by >>):

   arch/um/kernel/built-in.o: In function `segv':
>> (.text+0x34bd): undefined reference to `kernel_longjmp'
   arch/um/kernel/built-in.o: In function `bus_handler':
   (.text+0x38c6): undefined reference to `kernel_longjmp'
   arch/um/os-Linux/built-in.o: In function `switch_threads':
   (.text+0x4e7d): undefined reference to `kernel_longjmp'
   arch/um/os-Linux/built-in.o: In function `start_idle_thread':
   (.text+0x4f20): undefined reference to `kernel_longjmp'
   arch/um/os-Linux/built-in.o: In function `start_idle_thread':
   (.text+0x4f58): undefined reference to `kernel_longjmp'
   arch/um/os-Linux/built-in.o:(.text+0x4fab): more undefined references to `kernel_longjmp' follow
   collect2: error: ld returned 1 exit status

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--k+w/mQv8wyuph6w0
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--k+w/mQv8wyuph6w0--

