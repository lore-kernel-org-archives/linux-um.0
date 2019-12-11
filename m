Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 11 Dec 2019 11:27:42 -0800
In-Reply-To: <20191211192742.95699-1-brendanhiggins@google.com>
Message-Id: <20191211192742.95699-8-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20191211192742.95699-1-brendanhiggins@google.com>
Subject: [PATCH v1 7/7] fsi: aspeed: add unspecified HAS_IOMEM dependency
From: Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
To: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, Jeremy Kerr <jk@ozlabs.org>, Alistar Popple <alistair@popple.id.au>, Eddie James <eajames@linux.ibm.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, davidgow@google.com, Brendan Higgins <brendanhiggins@google.com>, linux-fsi@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
List-ID: <linux-um.lists.infradead.org>

Currently CONFIG_FSI_MASTER_ASPEED=y implicitly depends on
CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
the following build error:

ld: drivers/fsi/fsi-master-aspeed.o: in function `fsi_master_aspeed_probe':
drivers/fsi/fsi-master-aspeed.c:436: undefined reference to `devm_ioremap_resource'

Fix the build error by adding the unspecified dependency.

Reported-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 drivers/fsi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fsi/Kconfig b/drivers/fsi/Kconfig
index 92ce6d85802cc..4cc0e630ab79b 100644
--- a/drivers/fsi/Kconfig
+++ b/drivers/fsi/Kconfig
@@ -55,6 +55,7 @@ config FSI_MASTER_AST_CF
 
 config FSI_MASTER_ASPEED
 	tristate "FSI ASPEED master"
+	depends on HAS_IOMEM
 	help
 	 This option enables a FSI master that is present behind an OPB bridge
 	 in the AST2600.
-- 
2.24.0.525.g8f36a354ae-goog


