Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8973EC48BF6
	for <linux-um@archiver.kernel.org>; Thu,  7 Mar 2024 10:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oBEubMOWP08Q0ICYD4UPkgvPypeF4tBKY2fcDDIiCZA=; b=gZpykt80JXHuv0XG3WaPcpc019
	Uoa5vkEbPu6QYeC6Je7ImQ8LJNhZjsWf5SprK6bWRtwqDiXqC36NYWAkb+L/0gF1ilyU0CiM8OW4y
	j6R1lt/2ilgg1PN44eO7R8L45LKfJgUS/lVswaJA3FOtxI2z8853daJ1cdbmxdkMiChj7ymCUJhG7
	2tZ8mcmfgiWqsjf+BP/XxilcLxVaGayJI5kwmuZLe6KpZXUAMCO6oyFNFHMjpGHb978AvWzU7uOlq
	UKELc1J2GixUfTzf+duusaBKKw3yATZQCPy5U/TlK7BLFevAnZYgW2sfy4gaOs6TOn2NAwfI6dn33
	3jfV/Eww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riArq-00000004486-0RsE;
	Thu, 07 Mar 2024 10:20:50 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riArm-0000000443w-0H2f
	for linux-um@lists.infradead.org;
	Thu, 07 Mar 2024 10:20:48 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1riASr-00DtMT-Ik; Thu, 07 Mar 2024 09:55:02 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1riASn-002dNO-0Z;
	Thu, 07 Mar 2024 09:55:01 +0000
Message-ID: <87cfca1e-3f53-4935-a274-0920bce86373@cambridgegreys.com>
Date: Thu, 7 Mar 2024 09:54:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pcap-dbus.o:undefined reference to `dbus_message_demarshal'
Content-Language: en-US
To: Waqar Hameed <waqar.hameed@axis.com>, Ingo Molnar <mingo@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 kernel@axis.com, Richard Weinberger <richard@nod.at>,
 Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
References: <202403052336.y6DkUd8a-lkp@intel.com> <pndzfvbibgm.fsf@axis.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <pndzfvbibgm.fsf@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_022046_325981_54C0C782 
X-CRM114-Status: GOOD (  27.11  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org



On 06/03/2024 16:14, Waqar Hameed wrote:
> On Tue, Mar 05, 2024 at 23:11 +0800 kernel test robot <lkp@intel.com> wrote:
> 
>> Hi Vincent,
>>
>> FYI, the error/warning still remains.
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   90d35da658da8cff0d4ecbb5113f5fac9d00eb72
>> commit: 10f4c9b9a33b7df000f74fa0d896351fb1a61e6a x86/asm: Fix build of UML with KASAN
>> date:   6 months ago
>> config: um-randconfig-r111-20240305 (https://download.01.org/0day-ci/archive/20240305/202403052336.y6DkUd8a-lkp@intel.com/config)
>> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240305/202403052336.y6DkUd8a-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202403052336.y6DkUd8a-lkp@intel.com/
>>
>> All errors (new ones prefixed by >>):
>>
>>     /usr/bin/ld: arch/um/drivers/pcap.o: in function `dbus_write':
>>>> pcap-dbus.o:(.text+0x244ff): undefined reference to `dbus_message_demarshal'
>>>> /usr/bin/ld: pcap-dbus.o:(.text+0x24515): undefined reference to `dbus_connection_send'
>>>> /usr/bin/ld: pcap-dbus.o:(.text+0x2451e): undefined reference to `dbus_connection_flush'
>>>> /usr/bin/ld: pcap-dbus.o:(.text+0x24526): undefined reference to `dbus_message_unref'
>>>> /usr/bin/ld: pcap-dbus.o:(.text+0x24574): undefined reference to `dbus_error_free'
>>     /usr/bin/ld: arch/um/drivers/pcap.o: in function `dbus_read':
>>>> pcap-dbus.o:(.text+0x245c0): undefined reference to `dbus_connection_pop_message'
>>>> /usr/bin/ld: pcap-dbus.o:(.text+0x245e2): undefined reference to `dbus_connection_pop_message'
>>>> /usr/bin/ld: pcap-dbus.o:(.text+0x245f8): undefined reference to `dbus_connection_read_write'
>>>> /usr/bin/ld: pcap-dbus.o:(.text+0x24662): undefined reference to `dbus_message_is_signal'
>>>> /usr/bin/ld: pcap-dbus.o:(.text+0x2467e): undefined reference to `dbus_message_marshal'
>>>> /usr/bin/ld: pcap-dbus.o:(.text+0x246e6): undefined reference to `dbus_free'
>>     /usr/bin/ld: arch/um/drivers/pcap.o: in function `dbus_cleanup':
>>>> pcap-dbus.o:(.text+0x2474c): undefined reference to `dbus_connection_unref'
>>     /usr/bin/ld: arch/um/drivers/pcap.o: in function `dbus_activate':
>>>> pcap-dbus.o:(.text+0x247f6): undefined reference to `dbus_connection_open'
>>>> /usr/bin/ld: pcap-dbus.o:(.text+0x2480e): undefined reference to `dbus_bus_register'
>>>> /usr/bin/ld: pcap-dbus.o:(.text+0x248fc): undefined reference to `dbus_bus_add_match'
>>>> /usr/bin/ld: pcap-dbus.o:(.text+0x24904): undefined reference to `dbus_error_is_set'
>>>> /usr/bin/ld: pcap-dbus.o:(.text+0x2494b): undefined reference to `dbus_bus_get'
>>     /usr/bin/ld: pcap-dbus.o:(.text+0x2497c): undefined reference to `dbus_error_free'
>>     /usr/bin/ld: pcap-dbus.o:(.text+0x2498d): undefined reference to `dbus_bus_add_match'
>>     /usr/bin/ld: pcap-dbus.o:(.text+0x24995): undefined reference to `dbus_error_is_set'
>>     /usr/bin/ld: pcap-dbus.o:(.text+0x249ce): undefined reference to `dbus_error_free'
>>>> /usr/bin/ld: pcap-dbus.o:(.text+0x249da): undefined reference to `dbus_connection_unref'
>>     /usr/bin/ld: pcap-dbus.o:(.text+0x24a06): undefined reference to `dbus_bus_get'
>>     /usr/bin/ld: pcap-dbus.o:(.text+0x24a42): undefined reference to `dbus_error_free'
>>>> /usr/bin/ld: pcap-dbus.o:(.text+0x24a55): undefined reference to `dbus_connection_set_max_received_size'
>>     /usr/bin/ld: pcap-dbus.o:(.text+0x24a66): undefined reference to `dbus_connection_unref'
>>     /usr/bin/ld: pcap-dbus.o:(.text+0x24adc): undefined reference to `dbus_error_free'
>>     /usr/bin/ld: pcap-dbus.o:(.text+0x24b1a): undefined reference to `dbus_error_free'
>>     collect2: error: ld returned 1 exit status
> 
> Hi Ingo!
> 
> This error seems to be unrelated to the reported commit 10f4c9b9a33b
> ("x86/asm: Fix build of UML with KASAN"). The root cause seems to be the
> option `CONFIG_UML_NET_PCAP` (which is deprecated, as stated in
> `arch/um/drivers/Kconfig`), which tries to build `pcap.o`.
> 
> In the Makefile, one can find
> 
>    LDFLAGS_pcap.o = $(shell $(CC) $(KBUILD_CFLAGS) -print-file-name=libpcap.a)
>    
> and at the top the very old comment
> 
>   # pcap is broken in 2.5 because kbuild doesn't allow pcap.a to be linked
>   # in to pcap.o
> 
> `libpcap` is indeed the one referencing these symbols (that can be found
> in `libdbus-1` and `libsystemd`). I'm guessing we should just ignore
> this report, right? (Can it even be disabled somehow?)
> 
> Thank you
> Waqar Hameed
> 
> P.S
> Vincent has left the company and has therefore been removed from
> the CC list.
> D.S
>


PCAP is not feasible to incorporate into the build system at present.
It has grown all kinds of warts over the years and brings a lot of dependencies.
IMHO we should remove it from the tree. It has reached a point where it cannot
be built on a modern system.

The users who need the same functionality can produce a bpf filter using tcpdump
and load it as "firmware" into the vector/raw driver.

I am working on a pure python bpf compiler which takes the same syntax as PCAP.
It is showing signs of life and it can do some of the simpler use cases. Once
that is ready, it should be possible to use that instead of pcap/tcpdump.

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

