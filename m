Return-Path: <linux-fbdev-owner@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] Kconfig : Remove HAS_IOMEM dependency for Graphics
 support
From: Christian Borntraeger <borntraeger@de.ibm.com>
References: <cover.1517508744.git.alifm@linux.vnet.ibm.com>
 <CGME20180202080007epcas5p306896fe66e4bbf4bf5f8d91306a5d016@epcas5p3.samsung.com>
 <246f92c9-15dc-223f-59d9-b2f0756cdf5e@de.ibm.com>
 <1610039.4trOurtpys@amdc3058>
 <2324e2cc-ff55-4d57-2807-c7f72f9ea0ca@de.ibm.com>
Date: Thu, 15 Feb 2018 12:02:18 +0100
MIME-Version: 1.0
In-Reply-To: <2324e2cc-ff55-4d57-2807-c7f72f9ea0ca@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <b1a3933e-6a8f-bd24-3629-5da730398f32@de.ibm.com>
Sender: linux-fbdev-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Farhan Ali <alifm@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-fbdev@vger.kernel.org, geert@linux-m68k.org, stefan.kristiansson@saunalahti.fi, tomi.valkeinen@ti.com, schwidefsky@de.ibm.com, dri-devel@lists.freedesktop.org, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

An even simpler approach would be:

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index cbe1d978693a..35b7aba4b6a0 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -952,6 +952,10 @@ config S390_HYPFS_FS
 
 source "arch/s390/kvm/Kconfig"
 
+config DUMMY_CONSOLE
+       bool
+       default y
+
 config S390_GUEST
        def_bool y
        prompt "s390 support for virtio devices"

