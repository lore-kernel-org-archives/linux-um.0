Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n9jTs-000i9H-Tr
 for linux-um@lists.infradead.org; Tue, 18 Jan 2022 08:04:42 +0000
Message-ID: <06a7e64e62bf8191be5004dac52f84d711e0e9a0.camel@sipsolutions.net>
Subject: Re: [PATCH AUTOSEL 4.4 19/29] um: registers: Rename function names
 to avoid conflicts and build problems
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 18 Jan 2022 09:04:24 +0100
In-Reply-To: <20220118030822.1955469-19-sashal@kernel.org>
References: <20220118030822.1955469-1-sashal@kernel.org>
 <20220118030822.1955469-19-sashal@kernel.org>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, viro@zeniv.linux.org.uk

On Mon, 2022-01-17 at 22:08 -0500, Sasha Levin wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> [ Upstream commit 077b7320942b64b0da182aefd83c374462a65535 ]
> 
> The function names init_registers() and restore_registers() are used
> in several net/ethernet/ and gpu/drm/ drivers for other purposes (not
> calls to UML functions), so rename them.
> 
> This fixes multiple build errors.

FWIW, this is certainly fine to backport, but also almost certainly not
necessary: most likely all those drivers cannot be built before 5.14
(commit 68f5d3f3b654 ("um: add PCI over virtio emulation driver"))
anyway.

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

