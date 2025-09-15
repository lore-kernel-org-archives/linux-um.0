Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9860CAC58F
	for <linux-um@archiver.kernel.org>; Mon, 15 Sep 2025 08:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QubXfSg1vRGkM1InWDcY00t4cO4RjLQSGv8ob2i77/I=; b=3084/jFnkAKaaDr8I9OzOmjtYn
	v4U+TbgsXbKiyXMFNb02GA0aPB/g7px8zzeK57KJ5esuJoUXuKvYLB7+Roso6F5+PpnKI8szG60TQ
	/+zU+Q6yVBWFeoqaT/1j8qL+1Nfi3BKtZhz4rSUdEBgo0dNDKGKpY8a+yjvLjGAB6NEGvdh4P04lE
	9MTOzH+Y6Zh1V6Yt037U07uawD02Fq23+3rRaRaIDPS7pjQQO9/vk069oOvENr2veoTdwmTzj8OdT
	I6B0F21DdTQtRqahDjvoEqi2MujePq2lwX1UYyAdReGzvxf1S4/WlkfTzP/Gp5Yf4d/JvMHC0S+rM
	Ik4jvRnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy4ET-00000003938-3AiH;
	Mon, 15 Sep 2025 08:06:41 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy4ES-0000000392H-0fot
	for linux-um@lists.infradead.org;
	Mon, 15 Sep 2025 08:06:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 626994328D;
	Mon, 15 Sep 2025 08:06:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8173AC4CEF9;
	Mon, 15 Sep 2025 08:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757923598;
	bh=1wtoA59twXmHaJUE/DPZC+HVwZM8n7QOgu/PpOSxhro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TFDCJBL25hLGW+aRNeMA+Kjfwz+tX7+iwODS3z6mBS7kPxMyCeKLsZg/Sloup2gd5
	 F/5je3AOCvlIpUmFIuPwDwI7RC3qTBujKCEvrFYCOSQizVh13YbcQ4FLsgW1hyDMJn
	 xFBJ1L8MMWQeIIJ5xbfgIrFCNZAfyQf6db6DEB+V1gLGQP+4fUpNcSUel/mb48gsLP
	 fyl3bB+R8DqBD0+M2j6fA2+a7uGQyD4kocprnZF47rbtm2UA+WJQLipnxUF479eOVY
	 8KrQCAKvcNkxOBZuavdjNLEoThjCJcD/4Axrd8xSax+2gfav7W/d8pTDt/wZYUsDZf
	 YUO92zreZF9CQ==
Date: Mon, 15 Sep 2025 08:06:33 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>, linux-pci@vger.kernel.org,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Sami Tolvanen <samitolvanen@google.com>,
	Richard Weinberger <richard@nod.at>, Wei Liu <wei.liu@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	kunit-dev@googlegroups.com,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH 2/4] PCI: Add KUnit tests for FIXUP quirks
Message-ID: <aMfJCbld_TMHPTbD@google.com>
References: <20250912230208.967129-1-briannorris@chromium.org>
 <20250912230208.967129-3-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912230208.967129-3-briannorris@chromium.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_010640_240608_68825485 
X-CRM114-Status: GOOD (  14.75  )
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

On Fri, Sep 12, 2025 at 03:59:33PM -0700, Brian Norris wrote:
> +static int test_config_read(struct pci_bus *bus, unsigned int devfn, int where,
> +			    int size, u32 *val)
> +{
> +	if (PCI_SLOT(devfn) > 0)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +	if (where + size > TEST_CONF_SIZE)
> +		return PCIBIOS_BUFFER_TOO_SMALL;
> +
> +	if (size == 1)
> +		*val = test_readb(test_conf_space + where);
> +	else if (size == 2)
> +		*val = test_readw(test_conf_space + where);
> +	else if (size == 4)
> +		*val = test_readl(test_conf_space + where);
> +
> +	return PCIBIOS_SUCCESSFUL;

To handle cases where size might be a value other than {1, 2, 4}, would a
switch statement with a default case be more robust here?

> +static int test_config_write(struct pci_bus *bus, unsigned int devfn, int where,
> +			     int size, u32 val)
> +{
> +	if (PCI_SLOT(devfn) > 0)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +	if (where + size > TEST_CONF_SIZE)
> +		return PCIBIOS_BUFFER_TOO_SMALL;
> +
> +	if (size == 1)
> +		test_writeb(test_conf_space + where, val);
> +	else if (size == 2)
> +		test_writew(test_conf_space + where, val);
> +	else if (size == 4)
> +		test_writel(test_conf_space + where, val);
> +
> +	return PCIBIOS_SUCCESSFUL;

Same here.

> +static struct pci_dev *hook_device_early;
> +static struct pci_dev *hook_device_header;
> +static struct pci_dev *hook_device_final;
> +static struct pci_dev *hook_device_enable;
> +
> +static void pci_fixup_early_hook(struct pci_dev *pdev)
> +{
> +	hook_device_early = pdev;
> +}
> +DECLARE_PCI_FIXUP_EARLY(TEST_VENDOR_ID, TEST_DEVICE_ID, pci_fixup_early_hook);
> [...]
> +static int pci_fixup_test_init(struct kunit *test)
> +{
> +	hook_device_early = NULL;
> +	hook_device_header = NULL;
> +	hook_device_final = NULL;
> +	hook_device_enable = NULL;
> +
> +	return 0;
> +}

FWIW: if the probe is synchronous and the thread is the same task_struct,
the module level variables can be eliminated by using:

    test->priv = kunit_kzalloc(...);
    KUNIT_ASSERT_PTR_NE(...);

And in the hooks, kunit_get_current_test() returns the struct kunit *.

> +static void pci_fixup_match_test(struct kunit *test)
> +{
> +	struct device *dev = kunit_device_register(test, DEVICE_NAME);
> +
> +	KUNIT_ASSERT_PTR_NE(test, NULL, dev);
> +
> +	test_conf_space = kunit_kzalloc(test, TEST_CONF_SIZE, GFP_KERNEL);
> +	KUNIT_ASSERT_PTR_NE(test, NULL, test_conf_space);

The common initialization code can be moved to pci_fixup_test_init().

> +	struct pci_host_bridge *bridge = devm_pci_alloc_host_bridge(dev, 0);
> +
> +	KUNIT_ASSERT_PTR_NE(test, NULL, bridge);
> +	bridge->ops = &test_ops;

The `bridge` allocation can be moved to .init() too.

> +	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_early);
> +	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_header);
> +	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_final);
> +	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_enable);

Does it really need to check them?  They are just initialized by .init().

