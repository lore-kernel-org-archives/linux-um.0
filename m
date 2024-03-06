Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A142C5475B
	for <linux-um@archiver.kernel.org>; Wed,  6 Mar 2024 16:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w/KlU02qP3DuMI4MuSALqPeEkY+/6f96bXviwBTkv+0=; b=0iNOM4ptO8dj7TLETE9O9/TPND
	VAs1GfQhBP+06PzZ5E6CqzYlaPe3UQmhGSyKCwn02RCK9cLqurjIHO0iy95s6yAYG71EwhJayrgcU
	f4Ljykao1zSWANQJOXdjHcYRH5YLX8IX0lzJGCSi3yq5knt68RETU46PVuDkDZJEXLjaUv7/iDn+s
	mpmNBlcjnn9O69KivL9C1DEE5AUJGM6XaEtZPnUjA9kl9cZs3ErZGeu0/VQm2nhOq0meqCai8JZcu
	2ONcxuSoG4mkSkXElkw+D9/PEpsK5Vs2zKlZgQ9rVD8irTVUyfqumh8NjBR/dqojDSQRw4wxndsLv
	8KhWb16Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhtv5-00000000x5j-1Soa;
	Wed, 06 Mar 2024 16:15:03 +0000
Received: from mail-am7eur03on20601.outbound.protection.outlook.com ([2a01:111:f403:260e::601] helo=EUR03-AM7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhtv1-00000000wze-1P3w
	for linux-um@lists.infradead.org;
	Wed, 06 Mar 2024 16:15:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pk0ysPWEKZF1yVp7+P1WuTCOPOwMiJ0lQdG+NCK9zPjxWsYA7k71Q/XIyeUzSTvcoPpFufT9L4dh83ICeeXkvpty+eXK4y+qX48CmVdqzfMCaQ9/elOrIcE/hJtOI8e05nlqQhlAM1J3vXBzlLfQJk3cFpb9qGyM+ifxkTavTlSI5zEb6kQlVihN4OyKuZtZcpAe+g3/+/eKrEFa0DbasJNivz8p88fgcmUKyMejC/84Au290/Kopa/dSIzXlpUJ0DgphrPmB7LHwGVGGZ4rYO08bQNf5xjnqpmTHdcRjaO7KBm/mySRLqZkCxCWCvQMyw4DvAxyow71aQ8i8y2RzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/KlU02qP3DuMI4MuSALqPeEkY+/6f96bXviwBTkv+0=;
 b=eH2l8GM0ha5A+dxvFC64DeRJM/CgOIYGyXnZOVmRElMY+KuDndhw20A25QV5z99s0bz2MpHXKW0pHxvp8xqCdwDePrXUxPtVjcA5a80QJUXMzyZbaL76sOD1rCXFAVdTtPN2yr3aptImUmjlZfXoSo6EScD2Uw6HUeCLH+3KS/IFzF+0GLyqt753JNejBGWGV5darkCd21nbWy9vukDYDq5wiYvdBQljv9hcfPz2P6AlVDF4d2XBzSTsDbihUQlEVGy7T9vib0VssAphJDceJHvXTZVFKk/IQd18gdOccARCj08pIUHwOUFPPFgdjzp4squLERcGRE7eM2AzWsG67g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/KlU02qP3DuMI4MuSALqPeEkY+/6f96bXviwBTkv+0=;
 b=DIt79yuExA/OrhKD85umx0KbbzPnfCh5a+w4qIQcNfdQaADdRM9DexOIB5a2EObWSwkueFDrOjTwsNFQJy1ZWd3LCWCOIUYjTrCf51o8qLFNuPRfwtuezi+tSnejQSYM71G2mQqdkftFB8tOL/DvKp5OAfUFecjvEnyXzn/xmoQ=
Received: from AM0PR10CA0053.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::33)
 by DB9PR02MB6537.eurprd02.prod.outlook.com (2603:10a6:10:21b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 16:14:50 +0000
Received: from AM4PEPF00027A66.eurprd04.prod.outlook.com
 (2603:10a6:20b:150:cafe::2f) by AM0PR10CA0053.outlook.office365.com
 (2603:10a6:20b:150::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Wed, 6 Mar 2024 16:14:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00027A66.mail.protection.outlook.com (10.167.16.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 16:14:50 +0000
Received: from pc52311-2249 (10.0.5.60) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 6 Mar
 2024 17:14:49 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Ingo Molnar <mingo@kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<kernel@axis.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov
	<anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>,
	<linux-um@lists.infradead.org>
Subject: Re: pcap-dbus.o:undefined reference to `dbus_message_demarshal'
In-Reply-To: <202403052336.y6DkUd8a-lkp@intel.com> (kernel test robot's
	message of "Tue, 5 Mar 2024 23:11:26 +0800")
References: <202403052336.y6DkUd8a-lkp@intel.com>
User-Agent: a.out
Date: Wed, 6 Mar 2024 17:14:49 +0100
Message-ID: <pndzfvbibgm.fsf@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A66:EE_|DB9PR02MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: 09f8211d-51de-4c7d-4739-08dc3df88cc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vsD4WJ0cmEV5xQ4ik2pQE26Ps+o+1JUOx6MXbAUiu5EPxGbYpvPV49VkouID95JEzu+JjMw9q9tsA4QnJ44RB8SUjhQlNFrhOsoYTY+f1bNiOaPGth0rtQNLpiXJvLsI2PMM7IepNDPZYoNaQ6KqmcNiw4rCOXW5BE5+AvotZBGpkt+sMN5s7ZLAz9tIZEJkhsbs2kCk+1dm+/kfXA0htKtwEmpkd35kKA1d+8x2R2iXGiGrL9OsfA3+juV+riSnVoiVL8MhVqQ7HDFmlQ+MgNq+r6XYOiDJaIovtddgu5diFuO5XXOClfvkK0GzfkE1d/0YdUYcNQKw8dJK5ON8rmZdmJtqHMN2gacT8O5l7h5XCbrhIFiR2Oo3rkwFl/m6wKXNIT7xMbhP6AsbfknAICkr8zRZa873gBTLgd+yQDxB5qzRnhjSirNugiJKAmg6Dwc1cZbCpw3Wif3t8RAdgccNk4Ge5/Rks/yYV5fyUJ+Jjeh6khF9UbGo5JzCJTNyGhq+AV18UxF0BloP2AXbid/px/eNyTSctu2hoc+GHVUHUO1Ri5rK063uHzzbmJO4Y2AzDq6DQ2gtB+BW/zQaQO6qZ6XNY36+rKcOHZamKPCerU/nayrG04NSUJub0XyROFhN+0J6qxeeDZS15uZsOPCvLM0fBhu/8cWi+/BDP7tmfpTJqnLj8POY1aIBhOPEomcDsRMMZ2lNyrbzm00Kiw==
X-Forefront-Antispam-Report: CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 16:14:50.1894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f8211d-51de-4c7d-4739-08dc3df88cc0
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A66.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6537
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240306_081459_700859_7C289EE2 
X-CRM114-Status: GOOD (  16.49  )
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

On Tue, Mar 05, 2024 at 23:11 +0800 kernel test robot <lkp@intel.com> wrote:

> Hi Vincent,
>
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   90d35da658da8cff0d4ecbb5113f5fac9d00eb72
> commit: 10f4c9b9a33b7df000f74fa0d896351fb1a61e6a x86/asm: Fix build of UML with KASAN
> date:   6 months ago
> config: um-randconfig-r111-20240305 (https://download.01.org/0day-ci/archive/20240305/202403052336.y6DkUd8a-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240305/202403052336.y6DkUd8a-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202403052336.y6DkUd8a-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    /usr/bin/ld: arch/um/drivers/pcap.o: in function `dbus_write':
>>> pcap-dbus.o:(.text+0x244ff): undefined reference to `dbus_message_demarshal'
>>> /usr/bin/ld: pcap-dbus.o:(.text+0x24515): undefined reference to `dbus_connection_send'
>>> /usr/bin/ld: pcap-dbus.o:(.text+0x2451e): undefined reference to `dbus_connection_flush'
>>> /usr/bin/ld: pcap-dbus.o:(.text+0x24526): undefined reference to `dbus_message_unref'
>>> /usr/bin/ld: pcap-dbus.o:(.text+0x24574): undefined reference to `dbus_error_free'
>    /usr/bin/ld: arch/um/drivers/pcap.o: in function `dbus_read':
>>> pcap-dbus.o:(.text+0x245c0): undefined reference to `dbus_connection_pop_message'
>>> /usr/bin/ld: pcap-dbus.o:(.text+0x245e2): undefined reference to `dbus_connection_pop_message'
>>> /usr/bin/ld: pcap-dbus.o:(.text+0x245f8): undefined reference to `dbus_connection_read_write'
>>> /usr/bin/ld: pcap-dbus.o:(.text+0x24662): undefined reference to `dbus_message_is_signal'
>>> /usr/bin/ld: pcap-dbus.o:(.text+0x2467e): undefined reference to `dbus_message_marshal'
>>> /usr/bin/ld: pcap-dbus.o:(.text+0x246e6): undefined reference to `dbus_free'
>    /usr/bin/ld: arch/um/drivers/pcap.o: in function `dbus_cleanup':
>>> pcap-dbus.o:(.text+0x2474c): undefined reference to `dbus_connection_unref'
>    /usr/bin/ld: arch/um/drivers/pcap.o: in function `dbus_activate':
>>> pcap-dbus.o:(.text+0x247f6): undefined reference to `dbus_connection_open'
>>> /usr/bin/ld: pcap-dbus.o:(.text+0x2480e): undefined reference to `dbus_bus_register'
>>> /usr/bin/ld: pcap-dbus.o:(.text+0x248fc): undefined reference to `dbus_bus_add_match'
>>> /usr/bin/ld: pcap-dbus.o:(.text+0x24904): undefined reference to `dbus_error_is_set'
>>> /usr/bin/ld: pcap-dbus.o:(.text+0x2494b): undefined reference to `dbus_bus_get'
>    /usr/bin/ld: pcap-dbus.o:(.text+0x2497c): undefined reference to `dbus_error_free'
>    /usr/bin/ld: pcap-dbus.o:(.text+0x2498d): undefined reference to `dbus_bus_add_match'
>    /usr/bin/ld: pcap-dbus.o:(.text+0x24995): undefined reference to `dbus_error_is_set'
>    /usr/bin/ld: pcap-dbus.o:(.text+0x249ce): undefined reference to `dbus_error_free'
>>> /usr/bin/ld: pcap-dbus.o:(.text+0x249da): undefined reference to `dbus_connection_unref'
>    /usr/bin/ld: pcap-dbus.o:(.text+0x24a06): undefined reference to `dbus_bus_get'
>    /usr/bin/ld: pcap-dbus.o:(.text+0x24a42): undefined reference to `dbus_error_free'
>>> /usr/bin/ld: pcap-dbus.o:(.text+0x24a55): undefined reference to `dbus_connection_set_max_received_size'
>    /usr/bin/ld: pcap-dbus.o:(.text+0x24a66): undefined reference to `dbus_connection_unref'
>    /usr/bin/ld: pcap-dbus.o:(.text+0x24adc): undefined reference to `dbus_error_free'
>    /usr/bin/ld: pcap-dbus.o:(.text+0x24b1a): undefined reference to `dbus_error_free'
>    collect2: error: ld returned 1 exit status

Hi Ingo!

This error seems to be unrelated to the reported commit 10f4c9b9a33b
("x86/asm: Fix build of UML with KASAN"). The root cause seems to be the
option `CONFIG_UML_NET_PCAP` (which is deprecated, as stated in
`arch/um/drivers/Kconfig`), which tries to build `pcap.o`. 

In the Makefile, one can find

  LDFLAGS_pcap.o = $(shell $(CC) $(KBUILD_CFLAGS) -print-file-name=libpcap.a)
  
and at the top the very old comment

 # pcap is broken in 2.5 because kbuild doesn't allow pcap.a to be linked
 # in to pcap.o

`libpcap` is indeed the one referencing these symbols (that can be found
in `libdbus-1` and `libsystemd`). I'm guessing we should just ignore
this report, right? (Can it even be disabled somehow?)

Thank you
Waqar Hameed

P.S 
Vincent has left the company and has therefore been removed from
the CC list.
D.S

