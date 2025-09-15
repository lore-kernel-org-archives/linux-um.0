Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A99CAC592
	for <linux-um@archiver.kernel.org>; Mon, 15 Sep 2025 20:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O72yw8vJtQy+8bHFkvEUobUMXSH/AYeLaHaVDBYLJyk=; b=FqX2M7pcIxsYIuOEoHRArqRlIq
	koDGRqrj5z6ven151KsTVmN/w0aqBl7ozKTCNSb5sV/ffJBIuEhm2T6VivH0d6KKvnvizoLSCaXpD
	B+gpBWS0V/HUujxJ35Fh/rK3WqhI5rgA22yvPuPHvovynE6l9vM9ZzHenyVBMLrjS2GUIt5v268A0
	NUKNlvlZLcIimzRt0of/kJ1x+chomimTsHaUKzOaZSjWvC8OJWZrzEojB4jLuouj2MwZ1YHY4HFaz
	XsIMD31Yd0EwjmEPfTkbf/cfsooOLU61SVEJg/TEfIiY7qoBs4yjeRGfYixGsjLWVptkkOja3RTW2
	6OlsyEDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyFlE-00000005bqI-3D9l;
	Mon, 15 Sep 2025 20:25:16 +0000
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyFlC-00000005bpt-3Du4
	for linux-um@lists.infradead.org;
	Mon, 15 Sep 2025 20:25:16 +0000
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-b49b56a3f27so2758471a12.1
        for <linux-um@lists.infradead.org>; Mon, 15 Sep 2025 13:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757967914; x=1758572714; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O72yw8vJtQy+8bHFkvEUobUMXSH/AYeLaHaVDBYLJyk=;
        b=QJfaFNnmdohDvcM2TwswfqqFAnDng3teT7Z57zjT7+hnBzEnuA2GcGxeDhLFgtGw2k
         xml6gmHCYUobSyTgoDvKSYDFIpyK0Qh5H56p83x1Apqes9SOdd/XDZNZNEosvgfaa31U
         emKxLE/+cXYCxDi/DWNj5LIRq3rbRRoiHQ8y8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757967914; x=1758572714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O72yw8vJtQy+8bHFkvEUobUMXSH/AYeLaHaVDBYLJyk=;
        b=V2/eHK08kKX7CYiaCt6HRIfDAoI8u1+zJQVKeFZkhJoG4nHCS/kKrbEF7WY6ISKUrZ
         khGDQW7i7Q8qjs5+MOLkSxZyRLI5tbq3V/bmo6YUsICCB4pcztfREMryc1rV4cp+M7n9
         vd8pbS+RmMvb495NhxsoKu8ltSKM1wAolL1oxFIEPlfbXF8U6ton5lnqYtBpT8ciw+Cz
         8Fs6wWVG1K8qDa4Y4qBu8oX/l47y9WbG0+MisT4JjQCuvfHHp0Y3ybpkePTo8Ktc8T1M
         6PdguVS/4Ml6ALdBgpgWMBE632HFRZ7aopReJo3ldkpTlWVR95+OHiv7u9Pvz2cYNdDN
         ejEg==
X-Forwarded-Encrypted: i=1; AJvYcCWx0i3WRixG8rcdvGCjKdga+4S+0HztEv8F85imzb4bN0qd/mBSHHWcLR8WbK4P3VoL5TveT8zkMg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwzBsSmklsfVdyFAdSgYy4Om4Dsec/9LOB/UirWreX6WiMdQNV1
	TOWGfXk5EGu7p7Xypw+qOFY5gNV2q7AVgHksRAI0VQqBQzC0ew+lLGlii+hM3NJXBFiHV+PIp3C
	hvhE=
X-Gm-Gg: ASbGncuKYiT2FNdu6s7lgW8lg6cGvzGSsWkcBSndGWLPyeheVJeJETqS/FU+p4u8+0+
	YI1X7eSdUuGkDM9KPw4mquT8qfFzBTwxBrkXH3ET1VChPxQag8NcN45Ppp+xf9h9E84J9FCXVQm
	Iol3wxEsNK9DLKjQnv1lR5+9aNVFc43sIuBtWjicWYBVyjDRBGywLReolLiFg71cIPZzbCHKZBs
	bfEVDvK1Gt8y0SoGn0eN15AX2/Bx1F3W+FX9y+TGg/CrH6Nggu13tPUVTuoVQuPGtuNVnUkaDVB
	8HZpr4Px5Sc4TRS83pcFUilqwfC2OrHIoSpdnCXjcRgNfDvxGQ1SF5yWudd19HuylSJylc+Tnjw
	gfLmefd9zqT0t2UBxCfqJvHcaRyHKF92noz8HqQSRE6zfjv/DJBh348Ii0Q+xWJrjN//cjzk=
X-Google-Smtp-Source: AGHT+IH0BB3qybe2HQfIXVITegc2cfF0wfUP7hE62PhWgnHrlmUKZL5W+LGvMXTHhPZvp8uroV0xQA==
X-Received: by 2002:a17:902:ebc2:b0:24b:25f:5f7f with SMTP id d9443c01a7336-25d2801094emr140529445ad.60.1757967913824;
        Mon, 15 Sep 2025 13:25:13 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:fd49:49b1:16e7:2c97])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-25fc8285639sm86930085ad.134.2025.09.15.13.25.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 13:25:13 -0700 (PDT)
Date: Mon, 15 Sep 2025 13:25:11 -0700
From: Brian Norris <briannorris@chromium.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
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
Message-ID: <aMh2J1K_YiWYaNxf@google.com>
References: <20250912230208.967129-1-briannorris@chromium.org>
 <20250912230208.967129-3-briannorris@chromium.org>
 <aMfJCbld_TMHPTbD@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMfJCbld_TMHPTbD@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_132514_853453_F3A07559 
X-CRM114-Status: GOOD (  23.06  )
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

Hi,

On Mon, Sep 15, 2025 at 08:06:33AM +0000, Tzung-Bi Shih wrote:
> On Fri, Sep 12, 2025 at 03:59:33PM -0700, Brian Norris wrote:
> > +static int test_config_read(struct pci_bus *bus, unsigned int devfn, int where,
> > +			    int size, u32 *val)
> > +{
> > +	if (PCI_SLOT(devfn) > 0)
> > +		return PCIBIOS_DEVICE_NOT_FOUND;
> > +
> > +	if (where + size > TEST_CONF_SIZE)
> > +		return PCIBIOS_BUFFER_TOO_SMALL;
> > +
> > +	if (size == 1)
> > +		*val = test_readb(test_conf_space + where);
> > +	else if (size == 2)
> > +		*val = test_readw(test_conf_space + where);
> > +	else if (size == 4)
> > +		*val = test_readl(test_conf_space + where);
> > +
> > +	return PCIBIOS_SUCCESSFUL;
> 
> To handle cases where size might be a value other than {1, 2, 4}, would a
> switch statement with a default case be more robust here?

I was patterning based on pci_generic_config_read() and friends, but I
see that those use an 'else' for the last block, where I used an 'else
if'.

I suppose I could switch to 'else'. I'm not sure 'switch/case' is much
better.

> > +static int test_config_write(struct pci_bus *bus, unsigned int devfn, int where,
> > +			     int size, u32 val)
> > +{
> > +	if (PCI_SLOT(devfn) > 0)
> > +		return PCIBIOS_DEVICE_NOT_FOUND;
> > +
> > +	if (where + size > TEST_CONF_SIZE)
> > +		return PCIBIOS_BUFFER_TOO_SMALL;
> > +
> > +	if (size == 1)
> > +		test_writeb(test_conf_space + where, val);
> > +	else if (size == 2)
> > +		test_writew(test_conf_space + where, val);
> > +	else if (size == 4)
> > +		test_writel(test_conf_space + where, val);
> > +
> > +	return PCIBIOS_SUCCESSFUL;
> 
> Same here.
> 
> > +static struct pci_dev *hook_device_early;
> > +static struct pci_dev *hook_device_header;
> > +static struct pci_dev *hook_device_final;
> > +static struct pci_dev *hook_device_enable;
> > +
> > +static void pci_fixup_early_hook(struct pci_dev *pdev)
> > +{
> > +	hook_device_early = pdev;
> > +}
> > +DECLARE_PCI_FIXUP_EARLY(TEST_VENDOR_ID, TEST_DEVICE_ID, pci_fixup_early_hook);
> > [...]
> > +static int pci_fixup_test_init(struct kunit *test)
> > +{
> > +	hook_device_early = NULL;
> > +	hook_device_header = NULL;
> > +	hook_device_final = NULL;
> > +	hook_device_enable = NULL;
> > +
> > +	return 0;
> > +}
> 
> FWIW: if the probe is synchronous and the thread is the same task_struct,
> the module level variables can be eliminated by using:
> 
>     test->priv = kunit_kzalloc(...);
>     KUNIT_ASSERT_PTR_NE(...);
> 
> And in the hooks, kunit_get_current_test() returns the struct kunit *.

Ah, good suggestion, will give that a shot.

> > +static void pci_fixup_match_test(struct kunit *test)
> > +{
> > +	struct device *dev = kunit_device_register(test, DEVICE_NAME);
> > +
> > +	KUNIT_ASSERT_PTR_NE(test, NULL, dev);
> > +
> > +	test_conf_space = kunit_kzalloc(test, TEST_CONF_SIZE, GFP_KERNEL);
> > +	KUNIT_ASSERT_PTR_NE(test, NULL, test_conf_space);
> 
> The common initialization code can be moved to pci_fixup_test_init().
> 
> > +	struct pci_host_bridge *bridge = devm_pci_alloc_host_bridge(dev, 0);
> > +
> > +	KUNIT_ASSERT_PTR_NE(test, NULL, bridge);
> > +	bridge->ops = &test_ops;
> 
> The `bridge` allocation can be moved to .init() too.
> 
> > +	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_early);
> > +	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_header);
> > +	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_final);
> > +	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_enable);
> 
> Does it really need to check them?  They are just initialized by .init().

Probably not. I wrote these before there were multiple test cases and an
.init() function, and I didn't reconsider them afterward. And they'll be
especially pointless once these move into a kzalloc'd private structure.

Thanks for the suggestions.

Brian

