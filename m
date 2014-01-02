Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1VyiTm-0004oM-To
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 02 Jan 2014 13:38:30 +0000
Received: from mail-vb0-f49.google.com ([209.85.212.49])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VyiTl-0005u4-QJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 02 Jan 2014 13:38:30 +0000
Received: by mail-vb0-f49.google.com with SMTP id x11so6883102vbb.8
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 02 Jan 2014 05:38:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <d0b8642ac645400c9e1bf7e4f7d8a4d2@nixia.no>
References: <52B5A773.3000705@gmx.de> <52C01B3D.3010508@gmx.de>
	<d0b8642ac645400c9e1bf7e4f7d8a4d2@nixia.no>
Date: Thu, 2 Jan 2014 14:38:22 +0100
Message-ID: <CAFLxGvx-pw_8xfRXDr=qo+go3UGdZa_tai3RLvzCFANQ4cq4ZQ@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Content-Type: multipart/mixed; boundary=20cf3079bcc04f57a804eefce801
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
Subject: Re: [uml-devel] negative pid -516 possible ?
To: Stian Skjelstad <stian@nixia.no>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

--20cf3079bcc04f57a804eefce801
Content-Type: text/plain; charset=ISO-8859-1

On Sun, Dec 29, 2013 at 2:14 PM,  <stian@nixia.no> wrote:
>>> #6  0x08421d02 in rest_init () at init/main.c:401
>>>         pid = -516
>>> #7  0x080487e1 in start_kernel () at init/main.c:655
>>>         command_line = 0x85b6400 <command_line> "earlyprintk
>>> ubda=/home/tfoerste/virtual/uml/trinity ubdb=/mnt/ramdisk/trinity_swap
>>> eth0=tuntap,tap0,72:ef:3d:9f:c3:5a mem=1025M con0=fd:0,fd:1 con=pts
>>> rootfstype=ext4  root=98:0"
>>> #8  0x08049e09 in start_kernel_proc (unused=0x0) at
>>> arch/um/kernel/skas/process.c:46
>>>         pid = -516
>>> #9  0x0805f7cb in new_thread_handler () at
>>> arch/um/kernel/process.c:129
>>>         fn = 0x0
>>> #10 0x00000000 in ?? ()
>>> No symbol table info available.
>>>
>>>
>>> Is this a valid number ?
>> I'm asking b/c there's no process group id 516, and -516 always
>> happens in the back traces.
>> And furthermore after a while the UML system does no longer serve any
>> ssh login attempts.
>
> 516 ==  -ERESTART_RESTARTBLOCK  ??

Yeah, maybe.

Toralf, where exactly comes this back trace from? "gives for a guest"
is not a good error description.
Did it crash and you took it from the core dump?
Did it panic() and you attached to it?
Did it hang...?
IOW don't throw random back traces to us without much details. ;-)

The number -516 is a bit odd because you see it in
arch/um/kernel/skas/process.c.
In that function it comes from os_getpid() which indicates that the
host kernel reports that number.
...very strange.

init/main.c makes a bit more sense. Maybe a kthread creation within
UML returned that internal error.

Can you try the attached debug patch?
If the BUG_ON() trigger, please show us panic from UML, not just the
gdb back trace.

-- 
Thanks,
//richard

--20cf3079bcc04f57a804eefce801
Content-Type: text/plain; charset=US-ASCII; name="516.diff"
Content-Disposition: attachment; filename="516.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hpy26yyh0

ZGlmZiAtLWdpdCBhL2FyY2gvdW0va2VybmVsL3NrYXMvcHJvY2Vzcy5jIGIvYXJjaC91bS9rZXJu
ZWwvc2thcy9wcm9jZXNzLmMKaW5kZXggNGRhMTFiMy4uNzFhNTgyOCAxMDA2NDQKLS0tIGEvYXJj
aC91bS9rZXJuZWwvc2thcy9wcm9jZXNzLmMKKysrIGIvYXJjaC91bS9rZXJuZWwvc2thcy9wcm9j
ZXNzLmMKQEAgLTM4LDYgKzM4LDggQEAgc3RhdGljIGludCBfX2luaXQgc3RhcnRfa2VybmVsX3By
b2Modm9pZCAqdW51c2VkKQogCWJsb2NrX3NpZ25hbHMoKTsKIAlwaWQgPSBvc19nZXRwaWQoKTsK
IAorCUJVR19PTihwaWQgPT0gLTUxNik7CisKIAljcHVfdGFza3NbMF0ucGlkID0gcGlkOwogCWNw
dV90YXNrc1swXS50YXNrID0gY3VycmVudDsKICNpZmRlZiBDT05GSUdfU01QCmRpZmYgLS1naXQg
YS9pbml0L21haW4uYyBiL2luaXQvbWFpbi5jCmluZGV4IGZlYmM1MTEuLjlhZDY4YWIgMTAwNjQ0
Ci0tLSBhL2luaXQvbWFpbi5jCisrKyBiL2luaXQvbWFpbi5jCkBAIC0zODYsNiArMzg2LDcgQEAg
c3RhdGljIG5vaW5saW5lIHZvaWQgX19pbml0X3JlZm9rIHJlc3RfaW5pdCh2b2lkKQogCWtlcm5l
bF90aHJlYWQoa2VybmVsX2luaXQsIE5VTEwsIENMT05FX0ZTIHwgQ0xPTkVfU0lHSEFORCk7CiAJ
bnVtYV9kZWZhdWx0X3BvbGljeSgpOwogCXBpZCA9IGtlcm5lbF90aHJlYWQoa3RocmVhZGQsIE5V
TEwsIENMT05FX0ZTIHwgQ0xPTkVfRklMRVMpOworCUJVR19PTihwaWQgPT0gLTUxNik7CiAJcmN1
X3JlYWRfbG9jaygpOwogCWt0aHJlYWRkX3Rhc2sgPSBmaW5kX3Rhc2tfYnlfcGlkX25zKHBpZCwg
JmluaXRfcGlkX25zKTsKIAlyY3VfcmVhZF91bmxvY2soKTsK
--20cf3079bcc04f57a804eefce801
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
--20cf3079bcc04f57a804eefce801
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--20cf3079bcc04f57a804eefce801--


