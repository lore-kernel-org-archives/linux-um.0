Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DdXSL-0003uJ-TG	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 01 Jun 2005 10:56:41 -0700
Received: from orange.ous.edu ([140.211.15.17])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DdXSK-0001S1-KS	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 01 Jun 2005 10:56:41 -0700
Message-Id: <s29d94d2.053@ORANGE.OUS.EDU>
From: "Anthony Brock" <Anthony_Brock@ous.edu>
Subject: Re: [uml-devel] Problem with /dev/random and rngd daemon
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
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
Date: Wed, 01 Jun 2005 10:57:59 -0700
Content-Transfer-Encoding: 8bit
To: jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net

Okay, this is a little weird. It worked the first time I attempted to start it. However, I then killed it, killed rngd on the first host and restarted it on the first host. Now it fails again on the second host.

I'm wondering if the first host to launch is exhausting the entropy pool and the second host is attempting to read from an empty pool. If this is the case, then I have no idea how you could resolve this with multiple UML instances per host. In any case, here is the strace:

execve("/usr/sbin/rngd", ["/usr/sbin/rngd", "-r", "/dev/hwrng"], [/* 12 vars */]) = 0
uname({sys="Linux", node="butternut.ous.edu", ...}) = 0
brk(0)                                  = 0x804f000
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40017000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=8879, ...}) = 0
old_mmap(NULL, 8879, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40018000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/libpthread.so.0", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340A\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=81127, ...}) = 0
old_mmap(NULL, 331716, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4001b000
old_mmap(0x40028000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xc000) = 0x40028000
old_mmap(0x4002a000, 270276, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4002a000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360^\1"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1244688, ...}) = 0
old_mmap(NULL, 1254852, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4006c000
old_mmap(0x40194000, 32768, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x127000) = 0x40194000
old_mmap(0x4019c000, 9668, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4019c000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4019f000
munmap(0x40018000, 8879)                = 0
getrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=RLIM_INFINITY}) = 0
setrlimit(RLIMIT_STACK, {rlim_cur=2044*1024, rlim_max=RLIM_INFINITY}) = 0
getpid()                                = 1093
rt_sigaction(SIGRTMIN, {0x40023030, [], 0}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {0x40023080, [], 0}, NULL, 8) = 0
rt_sigaction(SIGRT_2, {0x40023150, [], 0}, NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [RTMIN], NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RT_1], NULL, 8) = 0
_sysctl({{CTL_KERN, KERN_VERSION}, 2, 0xbfb50054, 30, (nil), 0}) = 0
brk(0)                                  = 0x804f000
brk(0x8070000)                          = 0x8070000
brk(0)                                  = 0x8070000
close(3)                                = -1 EBADF (Bad file descriptor)
close(4)                                = -1 EBADF (Bad file descriptor)
close(5)                                = -1 EBADF (Bad file descriptor)
close(6)                                = -1 EBADF (Bad file descriptor)
close(7)                                = -1 EBADF (Bad file descriptor)
close(8)                                = -1 EBADF (Bad file descriptor)
close(9)                                = -1 EBADF (Bad file descriptor)
close(10)                               = -1 EBADF (Bad file descriptor)
close(11)                               = -1 EBADF (Bad file descriptor)
close(12)                               = -1 EBADF (Bad file descriptor)
close(13)                               = -1 EBADF (Bad file descriptor)
close(14)                               = -1 EBADF (Bad file descriptor)
close(15)                               = -1 EBADF (Bad file descriptor)
close(16)                               = -1 EBADF (Bad file descriptor)
close(17)                               = -1 EBADF (Bad file descriptor)
close(18)                               = -1 EBADF (Bad file descriptor)
close(19)                               = -1 EBADF (Bad file descriptor)
close(20)                               = -1 EBADF (Bad file descriptor)
close(21)                               = -1 EBADF (Bad file descriptor)
close(22)                               = -1 EBADF (Bad file descriptor)
close(23)                               = -1 EBADF (Bad file descriptor)
close(24)                               = -1 EBADF (Bad file descriptor)
close(25)                               = -1 EBADF (Bad file descriptor)
close(26)                               = -1 EBADF (Bad file descriptor)
close(27)                               = -1 EBADF (Bad file descriptor)
close(28)                               = -1 EBADF (Bad file descriptor)
close(29)                               = -1 EBADF (Bad file descriptor)
close(30)                               = -1 EBADF (Bad file descriptor)
close(31)                               = -1 EBADF (Bad file descriptor)
close(32)                               = -1 EBADF (Bad file descriptor)
close(33)                               = -1 EBADF (Bad file descriptor)
close(34)                               = -1 EBADF (Bad file descriptor)
close(35)                               = -1 EBADF (Bad file descriptor)
close(36)                               = -1 EBADF (Bad file descriptor)
close(37)                               = -1 EBADF (Bad file descriptor)
close(38)                               = -1 EBADF (Bad file descriptor)
close(39)                               = -1 EBADF (Bad file descriptor)
close(40)                               = -1 EBADF (Bad file descriptor)
close(41)                               = -1 EBADF (Bad file descriptor)
close(42)                               = -1 EBADF (Bad file descriptor)
close(43)                               = -1 EBADF (Bad file descriptor)
close(44)                               = -1 EBADF (Bad file descriptor)
close(45)                               = -1 EBADF (Bad file descriptor)
close(46)                               = -1 EBADF (Bad file descriptor)
close(47)                               = -1 EBADF (Bad file descriptor)
close(48)                               = -1 EBADF (Bad file descriptor)
close(49)                               = -1 EBADF (Bad file descriptor)
close(50)                               = -1 EBADF (Bad file descriptor)
close(51)                               = -1 EBADF (Bad file descriptor)
close(52)                               = -1 EBADF (Bad file descriptor)
close(53)                               = -1 EBADF (Bad file descriptor)
close(54)                               = -1 EBADF (Bad file descriptor)
close(55)                               = -1 EBADF (Bad file descriptor)
close(56)                               = -1 EBADF (Bad file descriptor)
close(57)                               = -1 EBADF (Bad file descriptor)
close(58)                               = -1 EBADF (Bad file descriptor)
close(59)                               = -1 EBADF (Bad file descriptor)
close(60)                               = -1 EBADF (Bad file descriptor)
close(61)                               = -1 EBADF (Bad file descriptor)
close(62)                               = -1 EBADF (Bad file descriptor)
close(63)                               = -1 EBADF (Bad file descriptor)
close(64)                               = -1 EBADF (Bad file descriptor)
close(65)                               = -1 EBADF (Bad file descriptor)
close(66)                               = -1 EBADF (Bad file descriptor)
close(67)                               = -1 EBADF (Bad file descriptor)
close(68)                               = -1 EBADF (Bad file descriptor)
close(69)                               = -1 EBADF (Bad file descriptor)
close(70)                               = -1 EBADF (Bad file descriptor)
close(71)                               = -1 EBADF (Bad file descriptor)
close(72)                               = -1 EBADF (Bad file descriptor)
close(73)                               = -1 EBADF (Bad file descriptor)
close(74)                               = -1 EBADF (Bad file descriptor)
close(75)                               = -1 EBADF (Bad file descriptor)
close(76)                               = -1 EBADF (Bad file descriptor)
close(77)                               = -1 EBADF (Bad file descriptor)
close(78)                               = -1 EBADF (Bad file descriptor)
close(79)                               = -1 EBADF (Bad file descriptor)
close(80)                               = -1 EBADF (Bad file descriptor)
close(81)                               = -1 EBADF (Bad file descriptor)
close(82)                               = -1 EBADF (Bad file descriptor)
close(83)                               = -1 EBADF (Bad file descriptor)
close(84)                               = -1 EBADF (Bad file descriptor)
close(85)                               = -1 EBADF (Bad file descriptor)
close(86)                               = -1 EBADF (Bad file descriptor)
close(87)                               = -1 EBADF (Bad file descriptor)
close(88)                               = -1 EBADF (Bad file descriptor)
close(89)                               = -1 EBADF (Bad file descriptor)
close(90)                               = -1 EBADF (Bad file descriptor)
close(91)                               = -1 EBADF (Bad file descriptor)
close(92)                               = -1 EBADF (Bad file descriptor)
close(93)                               = -1 EBADF (Bad file descriptor)
close(94)                               = -1 EBADF (Bad file descriptor)
close(95)                               = -1 EBADF (Bad file descriptor)
close(96)                               = -1 EBADF (Bad file descriptor)
close(97)                               = -1 EBADF (Bad file descriptor)
close(98)                               = -1 EBADF (Bad file descriptor)
close(99)                               = -1 EBADF (Bad file descriptor)
close(100)                              = -1 EBADF (Bad file descriptor)
close(101)                              = -1 EBADF (Bad file descriptor)
close(102)                              = -1 EBADF (Bad file descriptor)
close(103)                              = -1 EBADF (Bad file descriptor)
close(104)                              = -1 EBADF (Bad file descriptor)
close(105)                              = -1 EBADF (Bad file descriptor)
close(106)                              = -1 EBADF (Bad file descriptor)
close(107)                              = -1 EBADF (Bad file descriptor)
close(108)                              = -1 EBADF (Bad file descriptor)
close(109)                              = -1 EBADF (Bad file descriptor)
close(110)                              = -1 EBADF (Bad file descriptor)
close(111)                              = -1 EBADF (Bad file descriptor)
close(112)                              = -1 EBADF (Bad file descriptor)
close(113)                              = -1 EBADF (Bad file descriptor)
close(114)                              = -1 EBADF (Bad file descriptor)
close(115)                              = -1 EBADF (Bad file descriptor)
close(116)                              = -1 EBADF (Bad file descriptor)
close(117)                              = -1 EBADF (Bad file descriptor)
close(118)                              = -1 EBADF (Bad file descriptor)
close(119)                              = -1 EBADF (Bad file descriptor)
close(120)                              = -1 EBADF (Bad file descriptor)
close(121)                              = -1 EBADF (Bad file descriptor)
close(122)                              = -1 EBADF (Bad file descriptor)
close(123)                              = -1 EBADF (Bad file descriptor)
close(124)                              = -1 EBADF (Bad file descriptor)
close(125)                              = -1 EBADF (Bad file descriptor)
close(126)                              = -1 EBADF (Bad file descriptor)
close(127)                              = -1 EBADF (Bad file descriptor)
close(128)                              = -1 EBADF (Bad file descriptor)
close(129)                              = -1 EBADF (Bad file descriptor)
close(130)                              = -1 EBADF (Bad file descriptor)
close(131)                              = -1 EBADF (Bad file descriptor)
close(132)                              = -1 EBADF (Bad file descriptor)
close(133)                              = -1 EBADF (Bad file descriptor)
close(134)                              = -1 EBADF (Bad file descriptor)
close(135)                              = -1 EBADF (Bad file descriptor)
close(136)                              = -1 EBADF (Bad file descriptor)
close(137)                              = -1 EBADF (Bad file descriptor)
close(138)                              = -1 EBADF (Bad file descriptor)
close(139)                              = -1 EBADF (Bad file descriptor)
close(140)                              = -1 EBADF (Bad file descriptor)
close(141)                              = -1 EBADF (Bad file descriptor)
close(142)                              = -1 EBADF (Bad file descriptor)
close(143)                              = -1 EBADF (Bad file descriptor)
close(144)                              = -1 EBADF (Bad file descriptor)
close(145)                              = -1 EBADF (Bad file descriptor)
close(146)                              = -1 EBADF (Bad file descriptor)
close(147)                              = -1 EBADF (Bad file descriptor)
close(148)                              = -1 EBADF (Bad file descriptor)
close(149)                              = -1 EBADF (Bad file descriptor)
close(150)                              = -1 EBADF (Bad file descriptor)
close(151)                              = -1 EBADF (Bad file descriptor)
close(152)                              = -1 EBADF (Bad file descriptor)
close(153)                              = -1 EBADF (Bad file descriptor)
close(154)                              = -1 EBADF (Bad file descriptor)
close(155)                              = -1 EBADF (Bad file descriptor)
close(156)                              = -1 EBADF (Bad file descriptor)
close(157)                              = -1 EBADF (Bad file descriptor)
close(158)                              = -1 EBADF (Bad file descriptor)
close(159)                              = -1 EBADF (Bad file descriptor)
close(160)                              = -1 EBADF (Bad file descriptor)
close(161)                              = -1 EBADF (Bad file descriptor)
close(162)                              = -1 EBADF (Bad file descriptor)
close(163)                              = -1 EBADF (Bad file descriptor)
close(164)                              = -1 EBADF (Bad file descriptor)
close(165)                              = -1 EBADF (Bad file descriptor)
close(166)                              = -1 EBADF (Bad file descriptor)
close(167)                              = -1 EBADF (Bad file descriptor)
close(168)                              = -1 EBADF (Bad file descriptor)
close(169)                              = -1 EBADF (Bad file descriptor)
close(170)                              = -1 EBADF (Bad file descriptor)
close(171)                              = -1 EBADF (Bad file descriptor)
close(172)                              = -1 EBADF (Bad file descriptor)
close(173)                              = -1 EBADF (Bad file descriptor)
close(174)                              = -1 EBADF (Bad file descriptor)
close(175)                              = -1 EBADF (Bad file descriptor)
close(176)                              = -1 EBADF (Bad file descriptor)
close(177)                              = -1 EBADF (Bad file descriptor)
close(178)                              = -1 EBADF (Bad file descriptor)
close(179)                              = -1 EBADF (Bad file descriptor)
close(180)                              = -1 EBADF (Bad file descriptor)
close(181)                              = -1 EBADF (Bad file descriptor)
close(182)                              = -1 EBADF (Bad file descriptor)
close(183)                              = -1 EBADF (Bad file descriptor)
close(184)                              = -1 EBADF (Bad file descriptor)
close(185)                              = -1 EBADF (Bad file descriptor)
close(186)                              = -1 EBADF (Bad file descriptor)
close(187)                              = -1 EBADF (Bad file descriptor)
close(188)                              = -1 EBADF (Bad file descriptor)
close(189)                              = -1 EBADF (Bad file descriptor)
close(190)                              = -1 EBADF (Bad file descriptor)
close(191)                              = -1 EBADF (Bad file descriptor)
close(192)                              = -1 EBADF (Bad file descriptor)
close(193)                              = -1 EBADF (Bad file descriptor)
close(194)                              = -1 EBADF (Bad file descriptor)
close(195)                              = -1 EBADF (Bad file descriptor)
close(196)                              = -1 EBADF (Bad file descriptor)
close(197)                              = -1 EBADF (Bad file descriptor)
close(198)                              = -1 EBADF (Bad file descriptor)
close(199)                              = -1 EBADF (Bad file descriptor)
close(200)                              = -1 EBADF (Bad file descriptor)
close(201)                              = -1 EBADF (Bad file descriptor)
close(202)                              = -1 EBADF (Bad file descriptor)
close(203)                              = -1 EBADF (Bad file descriptor)
close(204)                              = -1 EBADF (Bad file descriptor)
close(205)                              = -1 EBADF (Bad file descriptor)
close(206)                              = -1 EBADF (Bad file descriptor)
close(207)                              = -1 EBADF (Bad file descriptor)
close(208)                              = -1 EBADF (Bad file descriptor)
close(209)                              = -1 EBADF (Bad file descriptor)
close(210)                              = -1 EBADF (Bad file descriptor)
close(211)                              = -1 EBADF (Bad file descriptor)
close(212)                              = -1 EBADF (Bad file descriptor)
close(213)                              = -1 EBADF (Bad file descriptor)
close(214)                              = -1 EBADF (Bad file descriptor)
close(215)                              = -1 EBADF (Bad file descriptor)
close(216)                              = -1 EBADF (Bad file descriptor)
close(217)                              = -1 EBADF (Bad file descriptor)
close(218)                              = -1 EBADF (Bad file descriptor)
close(219)                              = -1 EBADF (Bad file descriptor)
close(220)                              = -1 EBADF (Bad file descriptor)
close(221)                              = -1 EBADF (Bad file descriptor)
close(222)                              = -1 EBADF (Bad file descriptor)
close(223)                              = -1 EBADF (Bad file descriptor)
close(224)                              = -1 EBADF (Bad file descriptor)
close(225)                              = -1 EBADF (Bad file descriptor)
close(226)                              = -1 EBADF (Bad file descriptor)
close(227)                              = -1 EBADF (Bad file descriptor)
close(228)                              = -1 EBADF (Bad file descriptor)
close(229)                              = -1 EBADF (Bad file descriptor)
close(230)                              = -1 EBADF (Bad file descriptor)
close(231)                              = -1 EBADF (Bad file descriptor)
close(232)                              = -1 EBADF (Bad file descriptor)
close(233)                              = -1 EBADF (Bad file descriptor)
close(234)                              = -1 EBADF (Bad file descriptor)
close(235)                              = -1 EBADF (Bad file descriptor)
close(236)                              = -1 EBADF (Bad file descriptor)
close(237)                              = -1 EBADF (Bad file descriptor)
close(238)                              = -1 EBADF (Bad file descriptor)
close(239)                              = -1 EBADF (Bad file descriptor)
close(240)                              = -1 EBADF (Bad file descriptor)
close(241)                              = -1 EBADF (Bad file descriptor)
close(242)                              = -1 EBADF (Bad file descriptor)
close(243)                              = -1 EBADF (Bad file descriptor)
close(244)                              = -1 EBADF (Bad file descriptor)
close(245)                              = -1 EBADF (Bad file descriptor)
close(246)                              = -1 EBADF (Bad file descriptor)
close(247)                              = -1 EBADF (Bad file descriptor)
close(248)                              = -1 EBADF (Bad file descriptor)
close(249)                              = -1 EBADF (Bad file descriptor)
rt_sigprocmask(SIG_SETMASK, [RTMIN], NULL, 8) = 0
rt_sigaction(SIGTERM, {0x400267a0, [], 0}, NULL, 8) = 0
rt_sigaction(SIGINT, {0x400267a0, [], 0}, NULL, 8) = 0
rt_sigaction(SIGUSR1, {0x400267a0, [], SA_RESTART}, NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [INT USR1 TERM], NULL, 8) = 0
open("/dev/hwrng", O_RDONLY)            = 3
rt_sigaction(SIGALRM, {0x400267a0, [], 0}, NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [ALRM], NULL, 8) = 0
alarm(10)                               = 0
read(3, 0xbfb50380, 4)                  = ? ERESTARTSYS (To be restarted)
--- SIGALRM (Alarm clock) @ 0 (0) ---
sigreturn()                             = ? (mask now [RTMIN])
exit_group(1)                           = ?


>>> Jeff Dike <jdike@addtoit.com> 06/01/05 10:37AM >>>
On Wed, Jun 01, 2005 at 10:09:50AM -0700, Anthony Brock wrote:
> I'm now running two systems with Jeff's patches for pulling entropy
> from the host's /dev/random. The first host I boot comes up fine
> (successfully loads rngd). However, the second fails to load rngd. I
> 'm getting back a return code of '1' from the daemon (the rng-source
> is misbehaving) after a pause of 10 seconds. Any ideas? 

strace it?

		Jeff


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005 
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net 
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
