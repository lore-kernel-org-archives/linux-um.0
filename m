Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E89CAC582
	for <linux-um@archiver.kernel.org>; Fri, 12 Sep 2025 23:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3dwNY0wU9h+Jp/qHmj3QCzMa4YfF1MmR36mm3/7OnW8=; b=FgQFzU7/7BwBxnTcvc6aBDLD6w
	v/2kqvhGrrNburGH/+pMoHLj05MYvOi1PSCfLje9H9k+KPn2H9DPt+1LCB9tCHZT7RFDvyTbIVr7r
	IBCWhblHyuwSVANihUxZ2P1UdV42f/MyZJY9UqWHiuS5enWsZFlMVyJ1QY1gJ76Bj3vsWIDuGxWsi
	Rq67/PcXC/y/2+IEPPrqsjeGBDM8/kKjQaLIai9cPlVfakm3I3vSZcTqVkmLtKN2HaisVHiaskaO+
	pPGx08PxUsZ7imjgLEIy6A1AwrmI3fYwkCQ/wsajrspVCky94T03LfP3lCvQzELVMkryDlVtZWPYc
	/sZeEeHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxCtx-0000000C0sB-39SV;
	Fri, 12 Sep 2025 23:09:57 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxCtu-0000000C0op-2ZDE
	for linux-um@lists.infradead.org;
	Fri, 12 Sep 2025 23:09:55 +0000
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-77256e75eacso2254436b3a.0
        for <linux-um@lists.infradead.org>; Fri, 12 Sep 2025 16:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757718594; x=1758323394; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dwNY0wU9h+Jp/qHmj3QCzMa4YfF1MmR36mm3/7OnW8=;
        b=mVKNMevH38fWmtzyVbVhkhr6ilrgN2SjyEWAb4JxJQH4djhtmQK2o65qgxvLqNjdd6
         mvp0TMMkpk4q6mnlPGWx6pEH6mqVOrfidkdC4unSmffylfRM0j8ocerai8FQaLCWoje3
         ie2XPLYpsDuShzoT+5hIISyMnzgaNVrYgQTrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757718594; x=1758323394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dwNY0wU9h+Jp/qHmj3QCzMa4YfF1MmR36mm3/7OnW8=;
        b=lo5T6yHjRjxmMQ4j69whq7QtFUtUXoYO4ld4Q18g0blfoTEZPUPau0UtDIUWwxqRdH
         tmgT2bXGuLZ10GxLzcrnynjafh6GqTjQZoSdWz5u8W5KlpuIXkrjG60qBfNhpSJQo1lN
         Z7rPRRDE6h7aRe++uQeL2KrvCbpSoGzYRv1UckLJ41p23YUX2EDqEb9vQf0iy37HA3gv
         mlGWomUstXgfV1hWNz1bYL/0/cZSbAogAc8gucTUYZtH+lfnbNAx0GaEuSPXopZhwGQG
         cS9nHRyBc4/mfcMLfMbQA6SLepTOiGI6QxgzSfEFxL1wDKL5KXiKAN6En7P1+aIovBXf
         RhUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2r5OK6lJmV1ZiAWq7czdKMADjWVjynmbytpTOwxXW/spgYZNz8xQ9n3hYDMHOLv4tR0lh0kVMcw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx3aOmIK0oiamQYwo+jtcM/FGpejbxdz+fOVR6ffLcf//dUNjU5
	tvgmKbGPZWUPcgntP1zFbsmNXmxMIVNd8xsIDSJaCvLhyFxZ0AHxeeg3kVSuCViNqw==
X-Gm-Gg: ASbGncswbAkLsKpOgYNsG883fGkRXDH0PzLz468hWWjTdvKdgo+bG9LlTAkqqo8CqOM
	mGpRi7saBQuLoxtuF2piSGiNz5M6dVZ+qT6Tvwm6BTBM8BxyyQy6K0b9DmBjZFIIAUC0E9FvQ+W
	PvWMjDG3e9VTLWi71gcZuQDMyn/4FGFOK9qz4DOJmvc0knC7GWv+J7+3KU5EH2QB70Qcn/Sd4zE
	USQV9+FDC7hFH7YB9VXod2aNHBKsAqDomRUg+FiqkgG/pHaedHQz05Np8/L52oFyaN8W1KLYRaN
	EnHv+2AJA+mzfj0I79mC7KlWxrmHBUGIVlnl34xUOsJI0Rcs9Cro06qKhUWtU2+8KDdRrpXG0MC
	rfrqR5B8EcgzkROUuOyhGuJp9LFn0j/FWNTAxh9U3K1MFO+xRpBLxQSC89QU=
X-Google-Smtp-Source: AGHT+IFFuttMHqLS1NzNjjaUsptJHeOjOLiy3J4IGiKbJXBfuhvPakuAU9nJRFZCTzUYWTGc4g8XAg==
X-Received: by 2002:a05:6a21:339c:b0:244:21:b477 with SMTP id adf61e73a8af0-2602a59371fmr5525527637.16.1757718593795;
        Fri, 12 Sep 2025 16:09:53 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:e464:c3f:39d8:1bab])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-77607c473b9sm6643028b3a.93.2025.09.12.16.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 16:09:53 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>
Cc: linux-pci@vger.kernel.org,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Sami Tolvanen <samitolvanen@google.com>,
	Richard Weinberger <richard@nod.at>,
	Wei Liu <wei.liu@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	kunit-dev@googlegroups.com,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 1/4] PCI: Support FIXUP quirks in modules
Date: Fri, 12 Sep 2025 15:59:32 -0700
Message-ID: <20250912230208.967129-2-briannorris@chromium.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
In-Reply-To: <20250912230208.967129-1-briannorris@chromium.org>
References: <20250912230208.967129-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250912_160954_654760_EE347463 
X-CRM114-Status: GOOD (  16.31  )
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

The PCI framework supports "quirks" for PCI devices via several
DECLARE_PCI_FIXUP_*() macros. These macros allow arch or driver code to
match device IDs to provide customizations or workarounds for broken
devices.

This mechanism is generally used in code that can only be built into the
kernel, but there are a few occasions where this mechanism is used in
drivers that can be modules. For example, see commit 574f29036fce ("PCI:
iproc: Apply quirk_paxc_bridge() for module as well as built-in").

The PCI fixup mechanism only works for built-in code, however, because
pci_fixup_device() only scans the ".pci_fixup_*" linker sections found
in the main kernel; it never touches modules.

Extend the fixup approach to modules.

I don't attempt to be clever here; the algorithm here scales with the
number of modules in the system.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/pci/quirks.c   | 62 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/module.h | 18 ++++++++++++
 kernel/module/main.c   | 26 ++++++++++++++++++
 3 files changed, 106 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d97335a40193..db5e0ac82ed7 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -207,6 +207,62 @@ extern struct pci_fixup __end_pci_fixups_suspend_late[];
 
 static bool pci_apply_fixup_final_quirks;
 
+struct pci_fixup_arg {
+	struct pci_dev *dev;
+	enum pci_fixup_pass pass;
+};
+
+static int pci_module_fixup(struct module *mod, void *parm)
+{
+	struct pci_fixup_arg *arg = parm;
+	void *start;
+	unsigned int size;
+
+	switch (arg->pass) {
+	case pci_fixup_early:
+		start = mod->pci_fixup_early;
+		size = mod->pci_fixup_early_size;
+		break;
+	case pci_fixup_header:
+		start = mod->pci_fixup_header;
+		size = mod->pci_fixup_header_size;
+		break;
+	case pci_fixup_final:
+		start = mod->pci_fixup_final;
+		size = mod->pci_fixup_final_size;
+		break;
+	case pci_fixup_enable:
+		start = mod->pci_fixup_enable;
+		size = mod->pci_fixup_enable_size;
+		break;
+	case pci_fixup_resume:
+		start = mod->pci_fixup_resume;
+		size = mod->pci_fixup_resume_size;
+		break;
+	case pci_fixup_suspend:
+		start = mod->pci_fixup_suspend;
+		size = mod->pci_fixup_suspend_size;
+		break;
+	case pci_fixup_resume_early:
+		start = mod->pci_fixup_resume_early;
+		size = mod->pci_fixup_resume_early_size;
+		break;
+	case pci_fixup_suspend_late:
+		start = mod->pci_fixup_suspend_late;
+		size = mod->pci_fixup_suspend_late_size;
+		break;
+	default:
+		return 0;
+	}
+
+	if (!size)
+		return 0;
+
+	pci_do_fixups(arg->dev, start, start + size);
+
+	return 0;
+}
+
 void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev)
 {
 	struct pci_fixup *start, *end;
@@ -259,6 +315,12 @@ void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev)
 		return;
 	}
 	pci_do_fixups(dev, start, end);
+
+	struct pci_fixup_arg arg = {
+		.dev = dev,
+		.pass = pass,
+	};
+	module_for_each_mod(pci_module_fixup, &arg);
 }
 EXPORT_SYMBOL(pci_fixup_device);
 
diff --git a/include/linux/module.h b/include/linux/module.h
index 3319a5269d28..7faa8987b9eb 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -539,6 +539,24 @@ struct module {
 	int num_kunit_suites;
 	struct kunit_suite **kunit_suites;
 #endif
+#ifdef CONFIG_PCI_QUIRKS
+	void *pci_fixup_early;
+	unsigned int pci_fixup_early_size;
+	void *pci_fixup_header;
+	unsigned int pci_fixup_header_size;
+	void *pci_fixup_final;
+	unsigned int pci_fixup_final_size;
+	void *pci_fixup_enable;
+	unsigned int pci_fixup_enable_size;
+	void *pci_fixup_resume;
+	unsigned int pci_fixup_resume_size;
+	void *pci_fixup_suspend;
+	unsigned int pci_fixup_suspend_size;
+	void *pci_fixup_resume_early;
+	unsigned int pci_fixup_resume_early_size;
+	void *pci_fixup_suspend_late;
+	unsigned int pci_fixup_suspend_late_size;
+#endif
 
 
 #ifdef CONFIG_LIVEPATCH
diff --git a/kernel/module/main.c b/kernel/module/main.c
index c66b26184936..50a80c875adc 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2702,6 +2702,32 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 					      sizeof(*mod->kunit_init_suites),
 					      &mod->num_kunit_init_suites);
 #endif
+#ifdef CONFIG_PCI_QUIRKS
+	mod->pci_fixup_early = section_objs(info, ".pci_fixup_early",
+					    sizeof(*mod->pci_fixup_early),
+					    &mod->pci_fixup_early_size);
+	mod->pci_fixup_header = section_objs(info, ".pci_fixup_header",
+					     sizeof(*mod->pci_fixup_header),
+					     &mod->pci_fixup_header_size);
+	mod->pci_fixup_final = section_objs(info, ".pci_fixup_final",
+					    sizeof(*mod->pci_fixup_final),
+					    &mod->pci_fixup_final_size);
+	mod->pci_fixup_enable = section_objs(info, ".pci_fixup_enable",
+					     sizeof(*mod->pci_fixup_enable),
+					     &mod->pci_fixup_enable_size);
+	mod->pci_fixup_resume = section_objs(info, ".pci_fixup_resume",
+					     sizeof(*mod->pci_fixup_resume),
+					     &mod->pci_fixup_resume_size);
+	mod->pci_fixup_suspend = section_objs(info, ".pci_fixup_suspend",
+					      sizeof(*mod->pci_fixup_suspend),
+					      &mod->pci_fixup_suspend_size);
+	mod->pci_fixup_resume_early = section_objs(info, ".pci_fixup_resume_early",
+						   sizeof(*mod->pci_fixup_resume_early),
+						   &mod->pci_fixup_resume_early_size);
+	mod->pci_fixup_suspend_late = section_objs(info, ".pci_fixup_suspend_late",
+						   sizeof(*mod->pci_fixup_suspend_late),
+						   &mod->pci_fixup_suspend_late_size);
+#endif
 
 	mod->extable = section_objs(info, "__ex_table",
 				    sizeof(*mod->extable), &mod->num_exentries);
-- 
2.51.0.384.g4c02a37b29-goog


