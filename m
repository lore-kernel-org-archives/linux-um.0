Return-Path: <lorenzo.pieralisi@arm.com>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] PCI: vmd: depend on !UML
Date: Wed, 13 Oct 2021 15:13:04 +0100
Message-Id: <163413437431.14367.12294124839040027341.b4-ty@arm.com>
In-Reply-To: <20210811162530.affe26231bc3.I131b3c1e67e3d2ead6e98addd256c835fbef9a3e@changeid>
References: <20210811162530.affe26231bc3.I131b3c1e67e3d2ead6e98addd256c835fbef9a3e@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Johannes Berg <johannes@sipsolutions.net>, linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Jonathan Derrick <jonathan.derrick@intel.com>, linux-um@lists.infradead.org, Geert Uytterhoeven <geert@linux-m68k.org>, Johannes Berg <johannes.berg@intel.com>, Randy Dunlap <rdunlap@infradead.org>
List-ID: <linux-um.lists.infradead.org>

On Wed, 11 Aug 2021 16:25:30 +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> With UML having enabled (simulated) PCI on UML, VMD breaks
> allyesconfig/allmodconfig compilation because it assumes
> it's running on X86_64 bare metal, and has hardcoded API
> use of ARCH=x86. Make it depend on !UML to fix this.
> 
> [...]

Applied to pci/vmd, thanks!

[1/1] PCI: vmd: depend on !UML
      https://git.kernel.org/lpieralisi/pci/c/42cf2a633d

Thanks,
Lorenzo

