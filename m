Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
In-Reply-To: <CAFLxGvwfVaevxHCTUkWcKRT6m9eh8S57i_P1QOLozwzgCoU0bA@mail.gmail.com>
References: <1446220968.3024896.424644809.559D7C91@webmail.messagingengine.com>
	<CAFLxGvwfVaevxHCTUkWcKRT6m9eh8S57i_P1QOLozwzgCoU0bA@mail.gmail.com>
Date: Fri, 30 Oct 2015 20:38:48 +0100
Message-ID: <CAFLxGvxftAWoB6JnxqqyV6vRErqj01OtTho4JfPuX+suLOToZw@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
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
Subject: Re: [uml-devel] [uml-user] Building from source problems and
	possibilities
To: Balaco Baco <balacobaco@imap.cc>
Cc: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>, "user-mode-linux-user@lists.sourceforge.net" <user-mode-linux-user@lists.sourceforge.net>

On Fri, Oct 30, 2015 at 8:30 PM, Richard Weinberger
<richard.weinberger@gmail.com> wrote:
> On Fri, Oct 30, 2015 at 5:02 PM, Balaco Baco <balacobaco@imap.cc> wrote:
>> I restarted, now I've got another kernel source (2.6.32.68), knowing
>> that it may be old, but it's the "newer old" for 2.6, and I hoped that
>> it would work.
>
> Are you an archeologist? ;-)
> Is there a particular reason why you can't use something recent?
>
>> Steps done:
>>
>> 1. downloaded https://cdn. kernel
>> .org/pub/linux/kernel/v2.6/longterm/v2.6.32/linux-2.6.32.68.tar.xz
>> 2. extract with tar cJf (whatever)
>> 3. A few commands:
>>     make defconfig ARCH=um
>>     # config is saved on a file, to be restarted from a known point
>>     whenever needed
>>     make menuconfig ARCH=um
>>     make mrproper                    # zero start guarantee when
>>     repeating these steps
>>     make mrproper ARCH=um   #  "
>>     make ARCH=uml
>>
>> 4. It stops a few seconds after, with a few errors that may be simple to
>> fix:
>>
>> ===============
>> arch/um/os-Linux/start_up.c: In function 'check_coredump_limit':
>> arch/um/os-Linux/start_up.c:340:16: error: storage size of 'lim' isn't
>> known
>>   struct rlimit lim;
>>                 ^
>> arch/um/os-Linux/start_up.c:341:2: error: implicit declaration of
>> function 'getrlimit' [-Werror=implicit-function-declaration]
>>   int err = getrlimit(RLIMIT_CORE, &lim);
>>   ^
>> arch/um/os-Linux/start_up.c:341:22: error: 'RLIMIT_CORE' undeclared
>> (first use in this function)
>>   int err = getrlimit(RLIMIT_CORE, &lim);
>>                       ^
>> arch/um/os-Linux/start_up.c:341:22: note: each undeclared identifier is
>> reported only once for each function it appears in
>> arch/um/os-Linux/start_up.c:349:22: error: 'RLIM_INFINITY' undeclared
>> (first use in this function)
>>   if (lim.rlim_cur == RLIM_INFINITY)
>>                       ^
>> arch/um/os-Linux/start_up.c:340:16: warning: unused variable 'lim'
>> [-Wunused-variable]
>>   struct rlimit lim;
>>                 ^
>> cc1: some warnings being treated as errors
>> make[1]: *** [arch/um/os-Linux/start_up.o] Error 1
>> make: *** [arch/um/os-Linux] Error 2
>>
>> ===============
>>
>> Do you know the reason for these two errors? And how I should fix them?
>
> It depends what libc you're using. AFAICT libc moved a header file to
> a new location.

Can you please verify whether this commit fixes the issue?
commit fdfa4c952844fce881df8c76de9c7180cbe913ab
Author: Sergei Trofimovich <slyfox@gentoo.org>
Date:   Sun Dec 30 01:37:30 2012 +0300

    um: add missing declaration of 'getrlimit()' and friends

If so, we only need to figure why it wasn't backported.

-- 
Thanks,
//richard

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

